import 'package:cloud_firestore/cloud_firestore.dart';
import 'user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createUser(UserModel user) async {
    try {
      await _firestore.collection('users').doc(user.id).set(user.toJson());
    } catch (e) {
      throw Exception('Failed to create user: $e');
    }
  }

  Future<Map<String, dynamic>?> getUserDetails(String email) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception('Error fetching user details: $e');
    }
  }

  Future<String> generateUserId() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('users').get();
      int userCount = querySnapshot.docs.length + 1;
      return 'u$userCount';
    } catch (e) {
      throw Exception('Failed to generate user ID: $e');
    }
  }
}
