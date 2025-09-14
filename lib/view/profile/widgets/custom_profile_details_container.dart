import 'package:flutter/material.dart';
import 'package:food_go_app/controller/auth_controller.dart';
import 'package:food_go_app/view/profile/widgets/profile_screen_topbar.dart';
import 'package:food_go_app/view/profile/widgets/text_field_custom.dart';

class CustomProfileDetailsContainer extends StatelessWidget {
  const CustomProfileDetailsContainer({super.key, required this.controller});

  final AuthController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30.0),
          // Profile screen topbar
          child: ProfileScreentopbar(),
        ),

        Padding(
          padding: EdgeInsets.only(top: 161),
          child: Container(
            height: 781,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35),
                topLeft: Radius.circular(35),
              ),
            ),
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              // Custom textfeilds
              child: CoustomProfileTextfeild(controller: controller),
            ),
          ),
        ),
      ],
    );
  }
}
