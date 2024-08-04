import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:shieldhealth/models/food.dart';
import 'package:path_provider/path_provider.dart';

class FoodDatabase extends ChangeNotifier {
  static late Isar isar;
  List<Food> _allFood = [];

  // Initialize DB
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open([FoodSchema], directory: dir.path);
  }

  // Getters
  List<Food> get allFood => _allFood;

  // Create
  Future<void> createNewFood(Food newFood) async {
    await isar.writeTxn(() => isar.foods.put(newFood));
    await readFood(); // Refresh food data
  }

  // Read
  Future<void> readFood() async {
    List<Food> fetchedFood = await isar.foods.where().findAll();
    _allFood.clear();
    _allFood.addAll(fetchedFood);
    notifyListeners(); // Notify listeners about the data change
  }

  // Update
  Future<void> updateFood(int id, Food updatedFood) async {
    updatedFood.id = id;
    await isar.writeTxn(() => isar.foods.put(updatedFood));
    await readFood(); // Refresh food data
  }

  // Delete
  Future<void> deleteFood(int id) async {
    await isar.writeTxn(() => isar.foods.delete(id));
    await readFood(); // Refresh food data
  }

  // Get total nutrient for today
  Future<double> getTotalNutrientForToday(String nutrient) async {
    await readFood(); // Ensure we have the latest data
    DateTime todayStart = DateTime.now().subtract(Duration(days: 1));
    double total = 0.0;

    for (var food in _allFood) {
      if (food.date.isAfter(todayStart)) {
        switch (nutrient.toLowerCase()) {
          case 'calories':
            total += food.calories;
            break;
          case 'carbs':
            total += food.carbs;
            break;
          case 'protein':
            total += food.protein;
            break;
          case 'fat':
            total += food.fat;
            break;
          case 'fiber':
            total += food.fiber;
            break;
          default:
            throw ArgumentError('Unknown nutrient type: $nutrient');
        }
      }
    }

    return total;
  }
}
