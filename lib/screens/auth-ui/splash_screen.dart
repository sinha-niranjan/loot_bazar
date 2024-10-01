// ignore_for_file: unused_import

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Get.offAll(() => const WelcomeScreen());
    });
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
