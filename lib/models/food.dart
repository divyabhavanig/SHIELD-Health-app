import 'package:isar/isar.dart';
import '../nutrition_data.dart'; // Adjust the path according to your project structure

//this line is needed to generate the isar file
//run cmd interminal:dart run build_runner build
part 'food.g.dart';

@Collection()
class Food {
  Id id = Isar.autoIncrement;
  final String name;
  final double serving;
  final String imagePath;
  final double calories;
  final double carbs;
  final double fat;
  final double fiber;
  final double protein;
  final DateTime date;
  @Enumerated(EnumType.name)
  final FoodCategory category;

  Food({
    required this.name,
    required this.imagePath,
    required this.calories,
    required this.carbs,
    required this.fat,
    required this.fiber,
    required this.protein,
    required this.category,
    required this.date,
    required this.serving,
  });
  // Conversion method
  factory Food.fromNutritionData({
    required NutritionData data,
    required String imagePath, // You need to provide this
    required DateTime date, // You need to provide this
    required FoodCategory category, // You need to provide this
  }) {
    return Food(
      name: data.name,
      serving: data.serving,
      imagePath: imagePath,
      calories: data.calories,
      carbs: data.carbohydrates,
      fat: data.fat,
      fiber: data.fiber,
      protein: data.protein,
      date: date,
      category: FoodCategory.Today,
    );
  }
}

enum FoodCategory {
  Today,
}
