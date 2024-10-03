import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/controllers/forget_password_controller.dart';
import 'package:loot_bazar/utils/app_constant.dart';
import 'package:lottie/lottie.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final ForgetPasswordController forgetPasswordController =
      Get.put(ForgetPasswordController());
  TextEditingController userEmail = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
      return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: AppConstant.appWhiteColor,
          ),
          elevation: 0,
          centerTitle: false,
          backgroundColor: AppConstant.appMainColor,
          title: const Text(
            'Forget Password',
            style: TextStyle(
                color: AppConstant.appWhiteColor,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Column(
              children: [
                isKeyboardVisible
                    // ignore: avoid_unnecessary_containers
                    ? Container(
                        child: const Text(
                        "Welcome to Loot Bazaar",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppConstant.appMainColor),
                      ))
                    : Column(
                        children: [
                          Container(
                            child: Lottie.asset(
                                'assets/images/splash_sign_icon.json'),
                          )
                        ],
                      ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: userEmail,
                      cursorColor: AppConstant.appSecondaryColor,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: "Email",
                          prefixIcon: const Icon(Icons.email),
                          contentPadding:
                              const EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 25,
                ),
                Material(
                  child: Container(
                    width: Get.width / 2.5,
                    height: Get.height / 17,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppConstant.appMainColor, width: 2.0),
                      color: AppConstant.appTransparentBackgroundColor,
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: TextButton(
                      child: const Text(
                        "Forget",
                        style: TextStyle(
                            color: AppConstant.appTextColor,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () async {
                        String email = userEmail.text.trim();

                        if (email.isEmpty) {
                          Get.snackbar("Error", "",
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: AppConstant.appMainColor,
                              colorText: AppConstant.appWhiteColor,
                              messageText: const Text(
                                "Please enter all details",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppConstant.appWhiteColor,
                                ),
                              ));
                        } else {
                          String email = userEmail.text.trim();
                          forgetPasswordController.forgetPasswordMethod(email);
                        }
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
