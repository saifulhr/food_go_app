import 'package:flutter/material.dart';
import 'package:food_go_app/component/widgets/custom_button.dart';
import 'package:food_go_app/component/widgets/text_fields.dart';
import 'package:food_go_app/controller/auth_controller.dart';
import 'package:food_go_app/view/login/log_in_screen.dart';
import 'package:get/get.dart';

class SignupScreen extends GetView<AuthController> {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0XFFfc8089), Color(0XFFef2a39)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // App Title
                const Center(
                  child: Text(
                    "FoodGo",
                    style: TextStyle(
                      fontSize: 54,
                      fontFamily: 'Lobster',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 80),

                // SignUp title
                const Text(
                  "SignUp",
                  style: TextStyle(
                    fontSize: 40,
                    fontFamily: 'Lobster',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Text fields
                TextFields(
                  hintText: 'Enter Your First Name',
                  controller: controller.firstNameController,
                  icon: Icons.person,
                ),
                TextFields(
                  hintText: 'Enter Your Last Name',
                  controller: controller.lastNameController,
                  icon: Icons.person_outline,
                ),
                TextFields(
                  hintText: 'Enter Your Email address',
                  controller: controller.signupemailController,
                  icon: Icons.email,
                ),
                TextFields(
                  hintText: 'Enter Your Password',
                  controller: controller.signuppasswordController,
                  icon: Icons.lock,
                  isPassword: true,
                ),
                TextFields(
                  hintText: 'Enter Your Address',
                  controller: controller.addressController,
                  icon: Icons.location_on,
                ),
                const SizedBox(height: 30),

                // Sign Up button
                Obx(
                  () => controller.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Color(0XFFef2a39),
                          ),
                        )
                      : CustomButton(
                          text: 'Sign Up',
                          onPressed: () {
                            controller.signup();
                          },
                          backgroundColor: const Color(0XFFef2a39),
                        ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.to(
                        const LogInScreen(),
                        transition: Transition.noTransition,
                      );
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Already have an account? ",
                        style: TextStyle(fontSize: 16, color: Colors.black),
                        children: [
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
