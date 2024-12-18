import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/controllers/get_user_data_controller.dart';
import 'package:loot_bazar/controllers/sign_in_controller.dart';
import 'package:loot_bazar/screens/admin-panel/admin_main_screen.dart';
import 'package:loot_bazar/screens/auth-ui/forget_password_screen.dart';
import 'package:loot_bazar/screens/auth-ui/sign_up_screen.dart';
import 'package:loot_bazar/screens/user-panel/main_screen.dart';
import 'package:loot_bazar/utils/app_constant.dart';
import 'package:lottie/lottie.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final SignInController signInController = Get.put(SignInController());
  final GetUserDataController getUserDataController =
      Get.put(GetUserDataController());

  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
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
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  width: Get.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Obx(
                      () => TextFormField(
                        controller: userPassword,
                        obscureText: signInController.isPasswordVisible.value,
                        cursorColor: AppConstant.appSecondaryColor,
                        keyboardType: TextInputType.visiblePassword,
                        decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: const Icon(Icons.password),
                            suffixIcon: GestureDetector(
                                onTap: () {
                                  signInController.isPasswordVisible.toggle();
                                },
                                child: signInController.isPasswordVisible.value
                                    ? const Icon(Icons.visibility_off)
                                    : const Icon(Icons.visibility)),
                            contentPadding:
                                const EdgeInsets.only(top: 2.0, left: 8.0),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  margin: const EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    onTap: () {
                      Get.to(() => const ForgetPasswordScreen());
                    },
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(
                          color: AppConstant.appRedColor,
                          fontWeight: FontWeight.bold),
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
                      child: const Text("SIGN IN"),
                      onPressed: () async {
                        String email = userEmail.text.trim();
                        String password = userPassword.text.trim();

                        if (email.isEmpty || password.isEmpty) {
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
                          UserCredential? userCredential =
                              await signInController.signInModel(
                                  email, password);

                          if (userCredential != null) {
                            var userData = await getUserDataController
                                .getUserData(userCredential.user!.uid);
                            if (userCredential.user!.emailVerified) {
                              //
                              if (userData[0]['isAdmin'] == true) {
                                Get.snackbar(
                                  "Success Admin Login",
                                  "",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appMainColor,
                                  colorText: AppConstant.appWhiteColor,
                                  messageText: const Text(
                                    "Login Successfully ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppConstant.appWhiteColor,
                                    ),
                                  ),
                                );
                                Get.offAll(() => const AdminMainScreen());
                              } else {
                                Get.offAll(() => const MainScreen());
                              }
                            } else {
                              Get.snackbar("Error", "",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: AppConstant.appMainColor,
                                  colorText: AppConstant.appWhiteColor,
                                  messageText: const Text(
                                    "Please verify your email before login ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: AppConstant.appWhiteColor,
                                    ),
                                  ));
                            }
                          } else {
                            Get.snackbar("Error", "",
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: AppConstant.appMainColor,
                                colorText: AppConstant.appWhiteColor,
                                messageText: const Text(
                                  "Please try again ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppConstant.appWhiteColor,
                                  ),
                                ));
                          }
                        }
                      },
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
