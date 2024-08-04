import 'package:flutter/material.dart';
import '../components/neu_button.dart';
import '../models/food.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  const FoodPage({super.key, required this.food});

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Scaffold(
        backgroundColor: Color(0xff003c3a),
        body: Column(
          children: [
            //food image
            Image.asset(
              widget.food.imagePath,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.food.name,
              style: TextStyle(
                  color: Color(0xffF5BE63),
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
            //food calories
            SizedBox(
              height: 10,
            ),
            Text(
              'Calories: ' + widget.food.calories.toString() + ' kcal',
              style: TextStyle(
                  color: Color(0xffF5BE63),
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            //food nutrition parameters
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //food carbs
                NeuButton(
                  text: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Carbs',
                        style:
                            TextStyle(color: Color(0xffF5BE63), fontSize: 20.0),
                      ),
                      Text(
                        widget.food.carbs.toString() + ' g',
                        style:
                            TextStyle(color: Color(0xffF5BE63), fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                NeuButton(
                  text: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Protein',
                        style:
                            TextStyle(color: Color(0xffF5BE63), fontSize: 20.0),
                      ),
                      Text(
                        widget.food.protein.toString() + ' g',
                        style:
                            TextStyle(color: Color(0xffF5BE63), fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                //food protein
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //food fat
                NeuButton(
                  text: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Fat',
                        style:
                            TextStyle(color: Color(0xffF5BE63), fontSize: 20.0),
                      ),
                      Text(
                        widget.food.fat.toString() + ' g',
                        style:
                            TextStyle(color: Color(0xffF5BE63), fontSize: 20.0),
                      ),
                    ],
                  ),
                ),
                NeuButton(
                  text: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Fat',
                        style:
                            TextStyle(color: Color(0xffF5BE63), fontSize: 20.0),
                      ),
                      Text(
                        widget.food.fat.toString() + ' g',
                        style:
                            TextStyle(color: Color(0xffF5BE63), fontSize: 20.0),
                      ),
                    ],
                  ),
                ),

                //food fiber
              ],
            ),
            //food name
          ],
        ),
      ),

      //back button
      SafeArea(
        child: Opacity(
          opacity: 0.9,
          child: Container(
            margin: const EdgeInsets.only(left: 25),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.tertiary,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
      ),
    ]);
  }
}
