// ignore_for_file: unused_import

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/controllers/get_user_data_controller.dart';
import 'package:loot_bazar/screens/admin-panel/admin_main_screen.dart';
import 'package:loot_bazar/screens/auth-ui/sign_in_screen.dart';
import 'package:loot_bazar/screens/auth-ui/sign_up_screen.dart';
import 'package:loot_bazar/screens/auth-ui/welcome_screen.dart';
import 'package:loot_bazar/screens/user-panel/main_screen.dart';
import 'package:loot_bazar/utils/app_constant.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      loggdin(context);
    });
  }

  Future<void> loggdin(BuildContext context) async {
    if (user != null) {
      final GetUserDataController getUserDataController =
          Get.put(GetUserDataController());
      var userData = await getUserDataController.getUserData(user!.uid);

      if (userData[0]['isAdmin'] == true) {
        Get.offAll(() => const AdminMainScreen());
      } else {
        Get.offAll(() => const MainScreen());
      }
    } else {
      Get.to(() => WelcomeScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: AppConstant.appWhiteColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appWhiteColor,
        elevation: 0,
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                alignment: Alignment.center,
                child: Lottie.asset('assets/images/splash_icon.json'),
              ),
            ),
            // ignore: sized_box_for_whitespace
            Container(
              width: Get.width,
              // ignore: prefer_const_constructors
              margin: EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.center,
              child: Text(
                AppConstant.appPoweredBy,
                style: const TextStyle(
                    color: AppConstant.appTextColor,
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }
}
