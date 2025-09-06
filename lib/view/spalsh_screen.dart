import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_go_app/profile/profile_screen.dart';
import 'package:food_go_app/theme/all_images.dart';
import 'package:food_go_app/view/signup_screen.dart';
import 'package:get/route_manager.dart';

class SpalshScreen extends StatefulWidget {
  const SpalshScreen({super.key});

  @override
  State<SpalshScreen> createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 4), () {checkLoginStatus();});
  }

  checkLoginStatus() {
    User? currentuser = FirebaseAuth.instance.currentUser;
    if (currentuser != null) {
      Get.offAll(ProfileScreen(), transition: Transition.noTransition);
    } else {
      Get.offAll(SignupScreen(), transition: Transition.noTransition);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xfffc8089), Color(0xffef2a39)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Stack(
          children: [
            // Splash screen text position
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 210),
                Center(
                  child: Text(
                    'Foodgo',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontFamily: 'Lobster',
                    ),
                  ),
                ),
              ],
            ),
            // Spalsh screen Image01 Position
            Positioned(
              bottom: 0,
              left: -15,
              child: Image(
                image: AssetImage(AllImages.spalsScreenhBurger01),
                width: 180,
                height: 200,
              ),
            ),
            // Splash screen Image02 Position
            Positioned(
              bottom: 0,
              left: -15,
              right: 0,
              child: Image(
                image: AssetImage(AllImages.spalsScreenhBurger02),
                width: 130,
                height: 140,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
