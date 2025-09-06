import 'package:flutter/material.dart';
import 'package:food_go_app/controller/auth_controller.dart';
import 'package:food_go_app/profile/widgets/custom_profile_textfeilds.dart';
import 'package:get/get.dart';

class CoustomProfileTextfeild extends StatelessWidget {
  CoustomProfileTextfeild({super.key, required AuthController controller});
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            SizedBox(height: 60),
            CustomProfileTextField(
              hintText: '',
              controller: controller.nameController,
              label: 'Name',
              enabled: controller.textFieldEnable.value,
            ),
            SizedBox(height: 5),
            CustomProfileTextField(
              hintText: '',
              controller: controller.emailController,
              label: 'Email',
              enabled: controller.textFieldEnable.value,
            ),
            SizedBox(height: 5),
            CustomProfileTextField(
              hintText: '',
              controller: controller.deliveryController,
              label: 'Delivery',
              enabled: controller.textFieldEnable.value,
            ),
            SizedBox(height: 5),
            CustomProfileTextField(
              hintText: '*********',
              controller: controller.passwordController,
              label: 'Password',
              isPassword: true,
              enabled: controller.textFieldEnable.value,
            ),
            SizedBox(height: 20),
          ],
        ));
  }
}
