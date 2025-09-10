import 'package:flutter/material.dart';
import 'package:food_go_app/controller/auth_controller.dart';
import 'package:food_go_app/theme/all_images.dart';

import 'package:get/get.dart';

class CustomProfileBottomButton extends StatelessWidget {
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Row(
        children: [
          // Edit Button
          Expanded(
            child: GestureDetector(
              onTap: () async {
                if (controller.textFieldEnable.value) {
                  await controller.updateUserProfile();
                } else {
                  // Edit button clicked
                  controller.textFieldEnable.value = true;
                }
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  color: Color(0xFF6F4E37),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.textFieldEnable.value
                            ? 'Update Profile'
                            : 'Edit Profile',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      SizedBox(width: 10),
                      if (!controller.textFieldEnable.value)
                        Image.asset(AllImages.profileEditicon,height: 20,),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 10),

          // Logout Button
          Expanded(
            child: GestureDetector(
              onTap: () {
                controller.signOut();
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.red, width: 1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Log out',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    SizedBox(width: 10),
                    Icon(Icons.logout, color: Colors.red),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
