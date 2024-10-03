import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/screens/auth-ui/sign_up_screen.dart';
import 'package:loot_bazar/utils/app_constant.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
            'Sign In',
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      obscureText: true,
                      cursorColor: AppConstant.appSecondaryColor,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.password),
                          suffixIcon: const Icon(Icons.visibility_off),
                          contentPadding:
                              const EdgeInsets.only(top: 2.0, left: 8.0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 15),
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(
                        color: AppConstant.appRedColor,
                        fontWeight: FontWeight.bold),
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
                      child: const Text("SIGN IN"),
                      onPressed: () {},
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height / 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        color: AppConstant.appMainColor,
                      ),
                    ),
                    SizedBox(
                      width: Get.width / 50,
                    ),
                    GestureDetector(
                      onTap: () => Get.off(() => const SignUpScreen()),
                      child: const Text(
                        "Sign Up?",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppConstant.appMainColor,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
