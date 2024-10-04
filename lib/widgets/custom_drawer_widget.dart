import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loot_bazar/screens/auth-ui/welcome_screen.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height / 25),
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0),
          ),
        ),
        backgroundColor: AppConstant.appSecondaryColor,
        child: Wrap(
          runSpacing: 10,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Loot Bazaar",
                  style: TextStyle(color: AppConstant.appWhiteColor),
                ),
                subtitle: Text(
                  "Version 1.0.1",
                  style: TextStyle(color: AppConstant.appWhiteColor),
                ),
                leading: CircleAvatar(
                  radius: 22,
                  backgroundColor: AppConstant.appSecondaryTextColor,
                  child: Text(
                    "L",
                    style: TextStyle(color: AppConstant.appWhiteColor),
                  ),
                ),
              ),
            ),
            const Divider(
              indent: 10,
              endIndent: 10,
              thickness: 1.5,
              color: AppConstant.appSecondaryTextColor,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Home",
                  style: TextStyle(color: AppConstant.appWhiteColor),
                ),
                leading: Icon(
                  Icons.home,
                  color: AppConstant.appWhiteColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appWhiteColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Products",
                  style: TextStyle(color: AppConstant.appWhiteColor),
                ),
                leading: Icon(
                  Icons.production_quantity_limits,
                  color: AppConstant.appWhiteColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appWhiteColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "orders",
                  style: TextStyle(
                    color: AppConstant.appWhiteColor,
                  ),
                ),
                leading: Icon(
                  Icons.shopping_bag,
                  color: AppConstant.appWhiteColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appWhiteColor,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ListTile(
                titleAlignment: ListTileTitleAlignment.center,
                title: Text(
                  "Contact",
                  style: TextStyle(color: AppConstant.appWhiteColor),
                ),
                leading: Icon(
                  Icons.help,
                  color: AppConstant.appWhiteColor,
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appWhiteColor,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10.0,
              ),
              child: ListTile(
                onTap: () async {
                  GoogleSignIn googleSignIn = GoogleSignIn();
                  FirebaseAuth auth = FirebaseAuth.instance;

                  await auth.signOut();
                  await googleSignIn.signOut();
                  Get.off(() => WelcomeScreen());
                },
                titleAlignment: ListTileTitleAlignment.center,
                title: const Text(
                  "Logout",
                  style: TextStyle(color: AppConstant.appWhiteColor),
                ),
                leading: const Icon(
                  Icons.logout,
                  color: AppConstant.appWhiteColor,
                ),
                trailing: const Icon(
                  Icons.arrow_forward,
                  color: AppConstant.appWhiteColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
