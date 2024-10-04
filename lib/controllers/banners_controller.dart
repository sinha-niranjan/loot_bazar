import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class BannersController extends GetxController {
  RxList<String> bannerUrls = RxList<String>();

  @override
  void onInit() {
    super.onInit();
    fetchBannerUrls();
  }

  // fetch banners
  Future<void> fetchBannerUrls() async {
    try {
      QuerySnapshot bannersSnapshot =
          await FirebaseFirestore.instance.collection('banners').get();

      if (bannersSnapshot.docs.isNotEmpty) {
        bannerUrls.value = bannersSnapshot.docs
            .map((doc) => doc['imageUrl'] as String)
            .toList();
      }
    } catch (e) {
      Get.snackbar("error", "Something went wrong in fetching banners !! ",
          backgroundColor: AppConstant.appRedColor,
          colorText: AppConstant.appWhiteColor);
    }
  }
}
