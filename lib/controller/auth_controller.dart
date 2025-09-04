import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go_app/services/auth_services.dart';
import 'package:food_go_app/view/home_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Firebase Auth object & instance.
  final AuthServices _authServices = AuthServices();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // loading state

  var isLoading = false.obs;

  // textfeild controller SignUp
  final TextEditingController signupemailController = TextEditingController();
  final TextEditingController signuppasswordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // Log In Contrller

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  // Signup Function

  Future<void> signup() async {
    try {
      // UI screen Loading
      isLoading.value = true;
      User? user = await _authServices.signUp(
        signupemailController.text,
        signuppasswordController.text,
        firstNameController.text,
        lastNameController.text,
        addressController.text,
      );
      // user null check
      if (user != null) {
        Get.snackbar(
          "Success",
          "Your Registration Succsesfully Done",
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );
      }
      log("${user?.email}");
      // back to all screen
      Get.offAll(() => HomeScreen(), transition: Transition.noTransition);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar("Error", "${e.toString()}");
    }
  }

  // Sign In function
  Future<void> signIn() async {
    try {
      isLoading.value = true;

      User? user = await _authServices.signIn(
        loginEmailController.text,
        loginPasswordController.text,
      );

      if (user != null) {
        Get.snackbar(
          "Success",
          "User Login Successfully",
          backgroundColor: Colors.grey,
          colorText: Colors.white,
        );

        log("User email: ${user.email}");

        Get.offAll(() => HomeScreen(), transition: Transition.noTransition);
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = '';
      // Cheack Wrong Email or Password
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else {
        errorMessage = 'Login failed. Please try again.';
      }

      Get.snackbar(
        "Login Error",
        errorMessage,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "An unexpected error occurred: ${e.toString()}",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (firebaseAuth.currentUser != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(HomeScreen(), transition: Transition.noTransition);
      });
    }
  }
}
