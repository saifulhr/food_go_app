import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_go_app/models/user_model.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // SignUp
  Future<User?> signUp(
    String email,
    String password,
    String firstName,
    String lastName,
    String address,
  ) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection("users").doc(user.uid).set({
          "uid": user.uid,
          "firstName": firstName,
          "lastName": lastName,
          "email": email,
          "address": address,
          "createdAt": DateTime.now(),
        });
      }

      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  // SignIn
  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } catch (e) {
      throw Exception("Something went wrong: ${e.toString()}");
    }
  }

  // SignOut
  Future<void> signOut() async {
    await _auth.signOut();
  }

  // Get user profile
  Future<UserModels?> getUserProfile() async {
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        DocumentSnapshot doc = await _firestore
            .collection("users")
            .doc(user.uid)
            .get();
        if (doc.exists) {
          return UserModels.fromJson(doc.data() as Map<String, dynamic>);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error fetching profile data: ${e.toString()}');
    }
  }

  // Update user profile
  Future<void> updateUserProfile(UserModels updatedUser) async {
    try {
      final uid = _auth.currentUser?.uid;
      if (uid != null) {
        await _firestore
            .collection('users')
            .doc(uid)
            .update(updatedUser.toJson());
      } else {
        throw Exception("User is not logged in");
      }
    } catch (e) {
      throw Exception("Failed to update profile: ${e.toString()}");
    }
  }
}
