import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/screens/user-panel/all_categories_screen.dart';
import 'package:loot_bazar/screens/user-panel/all_flash_sale_product.dart';
import 'package:loot_bazar/screens/user-panel/all_product_screen.dart';
import 'package:loot_bazar/widgets/all_products_widget.dart';
import 'package:loot_bazar/widgets/banner_widget.dart';
import 'package:loot_bazar/widgets/category_widget.dart';
import 'package:loot_bazar/widgets/custom_drawer_widget.dart';
import 'package:loot_bazar/widgets/flash_sale_widget.dart';
import 'package:loot_bazar/widgets/heading_widget.dart';

import '../../utils/app_constant.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: Text(
          AppConstant.appMainName,
          style: const TextStyle(
            color: AppConstant.appWhiteColor,
          ),
        ),
        iconTheme:
            const IconThemeData(color: AppConstant.appWhiteColor, size: 30),
      ),
      drawer: const DrawerWidget(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          color: AppConstant.appBackgroundColor,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 90,
                ),

                //banner
                const BannerWidget(),

                // heading
                HeadingWidget(
                  headingTitle: "Categories",
                  headingSubTitle: "According to your budget",
                  buttonText: "See More >> ",
                  onTap: () => Get.to(() => const AllCategoriesScreen()),
                ),

                const CategoryWidget(),
                HeadingWidget(
                  headingTitle: "Flash Sale",
                  headingSubTitle: "According to your budget",
                  buttonText: "See More >> ",
                  onTap: () => Get.to(() => const AllFlashSaleProduct()),
                ),
                const FlashSaleWidget(),
                HeadingWidget(
                  headingTitle: "All Products  ",
                  headingSubTitle: "According to your budget",
                  buttonText: "See More >> ",
                  onTap: () => Get.to(() => const AllProductScreen()),
                ),
                const AllProductsWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
