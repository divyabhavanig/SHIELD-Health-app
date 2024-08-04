// lib/services/food_service.dart

// For date formatting
// Or other relevant packages
import '../models/food.dart'; // Adjust the import based on your project structure
import '../nutrition_data.dart'; // Adjust the import based on your project structure

Future<Food?> createFoodFromNutritionData(String foodLabel) async {
  try {
    // Fetch the nutrition data
    NutritionData? nutritionData = await fetchNutritionData(foodLabel);

    if (nutritionData != null) {
      // Define default values
      String defaultImagePath = 'lib/images/app_image.png'; // Example path
      DateTime today = DateTime.now();
      FoodCategory defaultCategory = FoodCategory.Today;

      // Create and return the Food instance
      return Food.fromNutritionData(
        data: nutritionData,
        imagePath: defaultImagePath,
        date: today,
        category: defaultCategory,
      );
    }
  } catch (e) {
    print('Error creating Food instance: $e');
  }
  return null;
}
