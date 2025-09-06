import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreentopbar extends StatelessWidget {
  const ProfileScreentopbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(Icons.arrow_back, color: Colors.white),
        ),
        Spacer(),
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.settings, color: Colors.white),
        ),
      ],
    );
  }
}
