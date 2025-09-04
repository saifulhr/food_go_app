import 'package:flutter/material.dart';
import 'package:food_go_app/component/widgets/custom_button.dart';
import 'package:food_go_app/component/widgets/text_feilds.dart';
import 'package:food_go_app/controller/auth_controller.dart';
import 'package:food_go_app/view/signup_screen.dart';
import 'package:get/get.dart';

class LogInScreen extends GetView<AuthController> {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    return Scaffold(
      // full screen section
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
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            // Screen Log In Form Card
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 10,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                    "Log In",
                    style: TextStyle(
                      fontSize: 40,
                      fontFamily: 'Lobster',
                      color: Color(0xffEF2A39),
                    ),
                  ),
                    const SizedBox(height: 20),

                    //This is the TextFields Section
                    TextFeilds(
                      hintText: 'Enter Your Email address',
                      controller: controller.loginEmailController,
                      icon: Icons.email,
                    ),
                    TextFeilds(
                      hintText: 'Enter Your Password',
                      controller: controller.loginPasswordController,
                      icon: Icons.lock,
                      isPassword: true,
                    ),
                    const SizedBox(height: 30),
                    Obx(
                      () => controller.isLoading.value
                          ? const CircularProgressIndicator(
                              color: Color(0XFFef2a39),
                            )
                          : CustomButton(
                              text: 'Log in',
                              onPressed: () {
                                controller.signIn();
                              },
                              backgroundColor: Color(0XFFef2a39),
                            ),
                    ),
                    SizedBox(height: 10,),
                    Align(
                      alignment: AlignmentGeometry.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          Get.to(
                            const SignupScreen(),
                            transition: Transition.noTransition,
                          );
                        },
                        child: Text.rich(
                          TextSpan(
                            text: "Don't have any account? ",
                            style: TextStyle(fontSize: 15, color: Colors.black),
                            children: [
                              TextSpan(
                                text: "Register",
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
        ),
      ),
    );
  }
}
