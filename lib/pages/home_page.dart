import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:shieldhealth/database/food_database.dart';
import 'package:shieldhealth/helpers/helper_functions.dart';
import '../models/food.dart';

import '../components/my_drawer.dart';
import '../components/my_food_tile.dart';
import '../components/my_sliver_app_bar.dart';
import '../components/Percent_tracker.dart';

import 'food_page.dart';

class HomePage extends StatefulWidget {
  final String userId;

  HomePage({required this.userId});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  //tab controller
  late TabController _tabController;
  TextEditingController nameController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  TextEditingController calController = TextEditingController();
  TextEditingController proteinController = TextEditingController();
  TextEditingController fiberController = TextEditingController();
  TextEditingController fatController = TextEditingController();
  TextEditingController servController = TextEditingController();
  TextEditingController carbController = TextEditingController();
  void initState() {
    super.initState();
    Provider.of<FoodDatabase>(context, listen: false).readFood();
    _tfLiteInit();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    Tflite.close();
    nameController.dispose();
    imageController.dispose();
    calController.dispose();
    proteinController.dispose();
    fiberController.dispose();
    fatController.dispose();
    servController.dispose();
    carbController.dispose();
    super.dispose();
  }

  Future<double> _getTotalNutrientForToday(String nutrient) async {
    final database = Provider.of<FoodDatabase>(context, listen: false);
    return await database.getTotalNutrientForToday(nutrient);
  }

  Widget buildPercentTracker(String nutrient, double max, String label) {
    return FutureBuilder<double>(
      future: _getTotalNutrientForToday(nutrient),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error');
        } else if (snapshot.hasData) {
          return PercentTracker(
            Pcolor: Color(0xff003c3a),
            Pmax: max,
            Pvalue: snapshot.data!,
            Ptext: label,
          );
        } else {
          return Text('No data');
        }
      },
    );
  }

  void openNewFoodBox() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Add Food"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                      controller: nameController,
                      decoration: const InputDecoration(hintText: "Name")),
                  TextField(
                    controller: calController,
                    decoration: const InputDecoration(hintText: "cal"),
                  ),
                  TextField(
                    controller: carbController,
                    decoration: const InputDecoration(hintText: "carbs"),
                  ),
                  TextField(
                    controller: proteinController,
                    decoration: const InputDecoration(hintText: "protein"),
                  ),
                  TextField(
                    controller: fiberController,
                    decoration: const InputDecoration(hintText: "fiber"),
                  ),
                  TextField(
                    controller: fatController,
                    decoration: const InputDecoration(hintText: "fat"),
                  ),
                ],
              ),
              actions: [
                //cancel button
                _cancelButton(),
                //save button
                _createNewFoodButton()
              ],
            ));
  }

  Future<void> _tfLiteInit() async {
    String? res = await Tflite.loadModel(
      model: "assets/my_model.tflite",
      labels: "assets/labels.txt",
      numThreads: 1,
      isAsset: true,
      useGpuDelegate: false,
    );
    print('Model loaded: $res');
  }

  void openImageBox() async {
    String label = '';
    Future<void> fetchAndDisplayNutrition(String foodLabel) async {
      try {
        String jsonData = await rootBundle.loadString('assets/nutrition.json');
        List<dynamic> jsonList = jsonDecode(jsonData);

        var data = jsonList.firstWhere(
          (element) => element['Name'] == foodLabel,
          orElse: () => null,
        );

        if (data != null) {
          setState(() async {
            Food newfood = Food(
                name: data['Name'],
                imagePath: data['image_path'],
                calories: (data['Calories'] as num).toDouble(),
                carbs: (data['Carbohydates'] as num).toDouble(),
                fat: (data['Fat'] as num).toDouble(),
                fiber: (data['Fiber'] as num).toDouble(),
                protein: (data['Protein'] as num).toDouble(),
                category: FoodCategory.Today,
                date: DateTime.now(),
                serving: (data['Serving'] as num).toDouble());
            //save to db
            await context.read<FoodDatabase>().createNewFood(newfood);
            //Navigator.of(context).pop();
          });
        } else {
          print('Nutrition data not found for $foodLabel');
        }
      } catch (e) {
        print('Error fetching nutrition data: $e');
      }
    }

    // Function to pick an image from gallery or take a photo
    Future<void> _pickImage(ImageSource source) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      if (image == null) return;

      setState(() {});

      var recognitions = await Tflite.runModelOnImage(
        path: image.path,
        imageMean: 0.0,
        imageStd: 255.0,
        numResults: 2,
        threshold: 0.2,
        asynch: true,
      );

      if (recognitions != null && recognitions.isNotEmpty) {
        setState(() {
          label = recognitions[0]['label'].toString();
        });

        fetchAndDisplayNutrition(label);
      } else {
        print('No recognitions found');
      }
    }

    // Show dialog with options to pick an image or take a photo
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add Image'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await _pickImage(ImageSource.gallery); // Pick from gallery

              // Reopen dialog to show selected image
            },
            child:
                Text('Pick Image', style: TextStyle(color: Color(0xffF5BE63))),
          ),
          TextButton(
            onPressed: () async {
              await _pickImage(ImageSource.camera); // Take a photo

              // Reopen dialog to show selected image
            },
            child: Text(
              'Take Photo',
              style: TextStyle(color: Color(0xffF5BE63)),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'Cancel',
              style: TextStyle(color: Color(0xffF5BE63)),
            ),
          ),
        ],
      ),
    );
  }

  void openEditBox(Food food) {
    //prefilled existing values into textfields
    String ename = food.name;
    String ecalories = food.calories.toString();
    String ecarbs = food.carbs.toString();
    String efat = food.calories.toString();
    String efiber = food.calories.toString();
    String eprotein = food.calories.toString();
    food.serving.toString();

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Edit Food"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                      controller: nameController,
                      decoration: InputDecoration(hintText: ename)),
                  TextField(
                    controller: calController,
                    decoration: InputDecoration(hintText: ecalories),
                  ),
                  TextField(
                    controller: carbController,
                    decoration: InputDecoration(hintText: ecarbs),
                  ),
                  TextField(
                    controller: proteinController,
                    decoration: InputDecoration(hintText: eprotein),
                  ),
                  TextField(
                    controller: fiberController,
                    decoration: InputDecoration(hintText: efiber),
                  ),
                  TextField(
                    controller: fatController,
                    decoration: InputDecoration(hintText: efat),
                  ),
                ],
              ),
              actions: [
                //cancel button
                _cancelButton(),
                //save button
                _editFoodButton(food),
              ],
            ));
  }

  void openDeleteBox(Food food) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("Delete Food"),
              actions: [
                //cancel button
                _cancelButton(),
                //delete button
                _deleteFoodButton(food.id),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
              child: Center(
                  child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          //calories

                          //carbs & proteins
                          Row(
                            children: [
                              // PercentTracker(
                              //   Pcolor: Color(0xff000000),
                              //   Pmax: 275,
                              //   Pvalue: 20,
                              //   Ptext: 'Carbs',
                              // ),
                              // PercentTracker(
                              //   Pcolor: Color(0xff000000),
                              //   Pmax: 500,
                              //   Pvalue: 10,
                              //   Ptext: 'Protein',
                              // ),
                              buildPercentTracker('carbs', 275, 'Carbs'),
                              SizedBox(width: 10),
                              buildPercentTracker('protein', 500, 'Protein'),
                            ],
                          ),
                          //fat and fiber
                          Row(
                            children: [
                              buildPercentTracker('fat', 70, 'Fat'),
                              SizedBox(width: 10),
                              buildPercentTracker('fiber', 30, 'Fiber'),
                              // PercentTracker(
                              //   Pcolor: Color(0xff000000),
                              //   Pmax: 70,
                              //   Pvalue: 20,
                              //   Ptext: 'Fat',
                              // ),
                              // PercentTracker(
                              //   Pcolor: Color(0xff000000),
                              //   Pmax: 30,
                              //   Pvalue: 10,
                              //   Ptext: 'Fiber',
                              // ),
                            ],
                          )
                        ],
                      ),
                      buildPercentTracker('calories', 2000, 'Calories')
                      // PercentTracker(
                      //   Pcolor: Color(0xff000000),
                      //   Pmax: 2000,
                      //   Pvalue: 20,
                      //   Ptext: 'Calories',
                      // ),
                    ],
                  ),
                ],
              )),
              title: Text("T O D A Y") // MyTabBar(
              //   tabController: _tabController,
              // ),
              ),
        ],
        body: // Consumer<NutriTracker>(
            //   builder: (context, NutriTracker, child) => TabBarView(
            //     controller: _tabController,
            //     children: getFoodInThisCategory(NutriTracker.menu),
            //   ),
            // ),

            Consumer<FoodDatabase>(
          builder: (context, value, child) => Scaffold(
            backgroundColor: Color(0xff003c3a),
            floatingActionButton: Stack(
              children: [
                Positioned(
                  bottom: 16,
                  right: 16,
                  child: FloatingActionButton(
                    backgroundColor: Color(0xffF5BE63),
                    foregroundColor: Colors.black,
                    onPressed: openNewFoodBox,
                    child: const Icon(
                      Icons.add,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 80,
                  right: 16,
                  child: FloatingActionButton(
                      backgroundColor: Color(0xffF5BE63),
                      foregroundColor: Colors.black,
                      onPressed: () async {
                        // await _navigateToSecondPage(context);
                        openImageBox();
                      },
                      child: const Icon(
                        Icons.image,
                      )),
                ),
              ],
            ),
            body: ListView.builder(
              itemCount: value.allFood.length,
              itemBuilder: (context, index) {
                //get individual food
                Food individualFood = value.allFood[index];
                //return the food tile ui
                return FoodTile(
                  food: individualFood,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FoodPage(food: individualFood),
                      )),
                  onDeletePressed: (context) => openDeleteBox(individualFood),
                  onEditPressed: (context) => openEditBox(individualFood),
                );
              },
            ),
          ),
        ),
      ),
      backgroundColor: Color(0xffAFD198),
    );
  }

  //cancel button
  Widget _cancelButton() {
    return MaterialButton(
      onPressed: () {
        Navigator.pop(context);
        nameController.clear();
        servController.clear();
        calController.clear();
        proteinController.clear();
        fatController.clear();
        fiberController.clear();
        carbController.clear();
        imageController.clear();
      },
      child: const Text('Cancel'),
    );
  }

  //save button
  Widget _createNewFoodButton() {
    return MaterialButton(
      onPressed: () async {
        if (nameController.text.isNotEmpty &&
            calController.text.isNotEmpty &&
            proteinController.text.isNotEmpty &&
            carbController.text.isNotEmpty &&
            fiberController.text.isNotEmpty &&
            fatController.text.isNotEmpty) {
          //pop box

          //create new food

          Food newfood = Food(
              name: nameController.text,
              imagePath: 'lib/images/app_image.png',
              calories: convertStringToDouble(calController.text),
              carbs: convertStringToDouble(carbController.text),
              fat: convertStringToDouble(fatController.text),
              fiber: convertStringToDouble(fiberController.text),
              protein: convertStringToDouble(proteinController.text),
              category: FoodCategory.Today,
              date: DateTime.now(),
              serving: 1);
          //save to db
          await context.read<FoodDatabase>().createNewFood(newfood);
          Navigator.pop(context);
          //clear controllers
          nameController.clear();
          servController.clear();
          calController.clear();
          proteinController.clear();
          fatController.clear();
          fiberController.clear();
          carbController.clear();
          imageController.clear();
          setState(() {});
        }
      },
      child: const Text('save'),
    );
  }
  //save for edit button

  Widget _editFoodButton(food) {
    return MaterialButton(
      onPressed: () async {
        if (nameController.text.isNotEmpty ||
            servController.text.isNotEmpty ||
            calController.text.isNotEmpty ||
            proteinController.text.isNotEmpty ||
            carbController.text.isNotEmpty ||
            fiberController.text.isNotEmpty ||
            fatController.text.isNotEmpty ||
            imageController.text.isNotEmpty) {
          Food updatedFood = Food(
              name: nameController.text.isNotEmpty
                  ? nameController.text
                  : food.name,
              imagePath: imageController.text.isNotEmpty
                  ? imageController.text
                  : food.imagePath,
              calories: calController.text.isNotEmpty
                  ? convertStringToDouble(calController.text)
                  : food.calories,
              carbs: carbController.text.isNotEmpty
                  ? convertStringToDouble(carbController.text)
                  : food.carbs,
              fat: fatController.text.isNotEmpty
                  ? convertStringToDouble(fatController.text)
                  : food.fat,
              fiber: fiberController.text.isNotEmpty
                  ? fiberController.text
                  : food.fiber,
              protein: proteinController.text.isNotEmpty
                  ? convertStringToDouble(proteinController.text)
                  : food.protein,
              category: FoodCategory.Today,
              date: DateTime.now(),
              serving: servController.text.isNotEmpty ? 1 : food.serving);

          //old expense id
          int existingId = food.id;
          //save to db
          await context
              .read<FoodDatabase>()
              .updateFood(existingId, updatedFood);
          Navigator.pop(context);
          nameController.clear();
          servController.clear();
          calController.clear();
          proteinController.clear();
          fatController.clear();
          fiberController.clear();
          carbController.clear();
          imageController.clear();
          setState(() {});
        }
      },
      child: Text("Edit Food"),
    ); //material button
  } //food botton func

  Widget _deleteFoodButton(int id) {
    return MaterialButton(
        onPressed: () async {
          await context.read<FoodDatabase>().deleteFood(id);
          Navigator.pop(context);
          setState(() {});
        },
        child: Text("delete food"));
  } //delete button
}
