import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loot_bazar/controllers/google_sign_in_controller.dart';
import 'package:lottie/lottie.dart';
import '../../utils/app_constant.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  final GoogleSignInController _googleSignInController =
      Get.put(GoogleSignInController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appWhiteColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          'Loot Bazaar',
          style: TextStyle(
              color: AppConstant.appWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ),
      // ignore: avoid_unnecessary_containers
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              child: Lottie.asset('assets/images/splash_login_icon.json'),
            ),
            SizedBox(
              height: Get.height / 12,
            ),
            Material(
              child: Container(
                width: Get.width / 1.3,
                height: Get.height / 13,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: AppConstant.appMainColor, width: 2.0),
                  color: AppConstant.appTransparentBackgroundColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TextButton.icon(
                  icon: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(
                      'assets/images/google-icon.png',
                      width: Get.width / 12,
                      height: Get.width / 12,
                    ),
                  ),
                  onPressed: () {
                    _googleSignInController.signInWithGoogle();
                  },
                  label: const Text(
                    'Sign in with google',
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: Get.height / 50,
            ),
            Material(
              child: Container(
                width: Get.width / 1.3,
                height: Get.height / 13,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: AppConstant.appTextColor, width: 2.0),
                  color: AppConstant.appTransparentBackgroundColor,
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: TextButton.icon(
                  icon: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.email,
                      size: 30,
                      color: AppConstant.appTextColor,
                    ),
                  ),
                  onPressed: () {},
                  label: const Text(
                    'Sign in with Email',
                    style: TextStyle(color: AppConstant.appTextColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
