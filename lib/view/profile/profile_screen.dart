import 'package:flutter/material.dart';
import 'package:food_go_app/controller/auth_controller.dart';
import 'package:food_go_app/view/profile/widgets/coustom_profile_bottombutton.dart';
import 'package:food_go_app/view/profile/widgets/custom_profile_details_container.dart';
import 'package:get/get.dart';

class ProfileScreen extends GetView<AuthController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AuthController());
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfffc8089), Color(0xffef2a39)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Obx(() {
          if (controller.isProfileLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            controller.nameController.text =
                "${controller.currentUser.value?.firstName ?? ""} ${controller.currentUser.value?.lastName ?? ""}";
            controller.emailController.text =
                controller.currentUser.value?.email ?? "";
            controller.deliveryController.text =
                controller.currentUser.value?.address ?? "";
            controller.passwordController.text = "";
            return SingleChildScrollView(
              child: CustomProfileDetailsContainer(controller: controller),
            );
          }
        }),
      ),

      // Bottom fixed buttons
      bottomNavigationBar: CustomProfileBottomButton(),
    );
  }
}
