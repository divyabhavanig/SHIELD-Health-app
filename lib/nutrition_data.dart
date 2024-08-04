import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

class NutritionData {
  final String name;
  final double serving;
  final double calories;
  final double fat;
  final double protein;
  final double carbohydrates;
  final double fiber;

  NutritionData({
    required this.name,
    required this.serving,
    required this.calories,
    required this.fat,
    required this.protein,
    required this.carbohydrates,
    required this.fiber,
  });

  factory NutritionData.fromJson(Map<String, dynamic> json) {
    return NutritionData(
      name: json['Name'],
      serving: json['Serving'].toDouble(),
      calories: json['Calories'],
      fat: json['Fat'].toDouble(),
      protein: json['Protein'].toDouble(),
      carbohydrates: json['Carbohydrates'].toDouble(), // Fixed typo
      fiber: json['Fiber'].toDouble(),
    );
  }
}

Future<NutritionData?> fetchNutritionData(String foodLabel) async {
  try {
    String data = await rootBundle.loadString('assets/nutrition.json');
    List<dynamic> jsonList = json.decode(data);
    var foodData = jsonList.firstWhere(
        (element) => element['Name'] == foodLabel,
        orElse: () => null);
    if (foodData != null) {
      return NutritionData.fromJson(foodData);
    }
  } catch (e) {
    print('Error fetching nutrition data: $e');
  }
  return null;
}
