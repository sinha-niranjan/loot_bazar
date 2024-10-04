import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loot_bazar/screens/auth-ui/welcome_screen.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: AppConstant.appWhiteColor,
        ),
        elevation: 0,
        centerTitle: false,
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          'Admin Panel',
          style: TextStyle(
              color: AppConstant.appWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              FirebaseAuth auth = FirebaseAuth.instance;

              await auth.signOut();
              await googleSignIn.signOut();
              Get.off(() => WelcomeScreen());
            },
            child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.logout,
                    size: 35, color: AppConstant.appWhiteColor)),
          )
        ],
      ),
    );
  }
}
