import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  // this is the signup services start point
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // signup function with user details.
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
      // user null check
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
  // this the sign up services end point.
  //////

  Future<User?> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw e;
    } catch (e) {
      throw Exception("Something went wrong: ${e.toString()}");
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
