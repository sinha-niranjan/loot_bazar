import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/screens/auth-ui/sign_in_screen.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class ForgetPasswordController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> forgetPasswordMethod(
    String userEmail,
  ) async {
    try {
      EasyLoading.show(status: "Please wait... ");

      // check if the email is already sign up
      QuerySnapshot result = await _firestore
          .collection('users')
          .where('email', isEqualTo: userEmail)
          .limit(1)
          .get();

      if (result.docs.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: userEmail);

        Get.snackbar("Request Sent Successfully",
            "Password reset link sent ot $userEmail. ",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appRedColor,
            colorText: AppConstant.appWhiteColor);
        Get.offAll(() => const SignInScreen());
      } else {
        Get.snackbar("Error  ", "no account found with this email. ",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: AppConstant.appRedColor,
            colorText: AppConstant.appWhiteColor);
      }

      EasyLoading.dismiss();
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "$e ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appRedColor,
          colorText: AppConstant.appWhiteColor);
    }
  }
}
