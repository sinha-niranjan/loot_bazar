import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // for password visibility
  var isPasswordVisible = true.obs;

  Future<UserCredential?> signInModel(
    String userEmail,
    String userPassword,
  ) async {
    try {
      EasyLoading.show(status: "Please wait... ");
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: userEmail, password: userPassword);

      EasyLoading.dismiss();
      Get.snackbar(
        "Success",
        "Verification email sent",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: AppConstant.appMainColor,
        colorText: AppConstant.appWhiteColor,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      Get.snackbar("Error", "invalid credentials $e",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appRedColor,
          colorText: AppConstant.appWhiteColor);
    }
    return null;
  }
}
