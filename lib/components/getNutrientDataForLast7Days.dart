import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<List<Map<String, double>>> getNutrientDataForLast7Days() async {
  User? user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('nutrient_data')
        .orderBy('date', descending: true)
        .limit(7)
        .get();

    return snapshot.docs.map((doc) {
      return {
        'calories': (doc['calories'] as num).toDouble(),
        'carbohydrates': (doc['carbohydrates'] as num).toDouble(),
        'fiber': (doc['fiber'] as num).toDouble(),
        'protein': (doc['protein'] as num).toDouble(),
        'fat': (doc['fat'] as num).toDouble(),
      };
    }).toList();
  }
  return [];
}
