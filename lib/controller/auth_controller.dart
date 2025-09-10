import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go_app/models/user_model.dart';
import 'package:food_go_app/profile/profile_screen.dart';
import 'package:food_go_app/services/auth_services.dart';
import 'package:food_go_app/view/home_screen/home_screen.dart';
import 'package:food_go_app/view/spalsh_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  // Firebase Auth object & instance.
  final AuthServices _authServices = AuthServices();
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // loading state

  var isLoading = false.obs;
  // Profile Loading
  var isProfileLoading = false.obs;

  // Profile Textfeild Enabled
  var textFieldEnable = false.obs;

  Rxn<UserModels> currentUser = Rxn<UserModels>();

  // textfeild controller SignUp
  final TextEditingController signupemailController = TextEditingController();
  final TextEditingController signuppasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  // Log In Contrller

  final TextEditingController loginEmailController = TextEditingController();
  final TextEditingController loginPasswordController = TextEditingController();

  // profile controller
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController deliveryController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

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
      Get.offAll(() => ProfileScreen(), transition: Transition.noTransition);
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

  // FetchUser Profile

  Future<void> fetchUserProfile() async {
    try {
      isProfileLoading.value = true;
      UserModels? userModels = await _authServices.getUserProfile();

      if (userModels != null) {
        log("Name: ${userModels.firstName}");
        log("Email: ${userModels.email}");
        log("Address: ${userModels.address}");
        log("Password: Not Available");

        currentUser.value = userModels;
        isProfileLoading.value = false;
      }
    } catch (e) {
      isProfileLoading.value = false;
      throw Exception("Profile data not found");
    }
  }

  Future signOut() async {
    await _authServices.signOut();
    Get.snackbar("Success", "User Sign Out Successfully");
    Get.offAll(SpalshScreen(), transition: Transition.noTransition);
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  //  update user function
  Future<void> updateUserProfile() async {
    try {
      isProfileLoading.value = true;

      UserModels updatedUser = UserModels(
        firstName: nameController.text,
        lastName: '',
        email: emailController.text,
        address: deliveryController.text,
      );

      await _authServices.updateUserProfile(updatedUser);

      // Controller current user update
      currentUser.value = updatedUser;

      // TextFields disable
      textFieldEnable.value = false;

      Get.snackbar(
        "Success",
        "Profile updated successfully",
        backgroundColor: Colors.grey,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update profile: ${e.toString()}",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      log("Failed to update profile: $e");
    } finally {
      isProfileLoading.value = false;
    }
  }
}
