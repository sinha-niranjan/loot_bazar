import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/models/product_model.dart';
import 'package:loot_bazar/screens/user-panel/product_details_screen.dart';
import 'package:loot_bazar/utils/app_constant.dart';
import 'package:loot_bazar/widgets/flash_sale_product_widget.dart';

class AllFlashSaleProduct extends StatefulWidget {
  const AllFlashSaleProduct({super.key});

  @override
  State<AllFlashSaleProduct> createState() => _AllFlashSaleProductState();
}

class _AllFlashSaleProductState extends State<AllFlashSaleProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appBackgroundColor,
      appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          title: const Text(
            "All Flash Sale Products ",
            style: TextStyle(
              color: AppConstant.appWhiteColor,
            ),
          ),
          iconTheme:
              const IconThemeData(color: AppConstant.appWhiteColor, size: 30),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.of(context).pop())),
      body: FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('products')
            .where('isSale', isEqualTo: true)
            .get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
          if (snapShot.hasError) {
            return const Center(
                child: Row(
              children: [Text("Error"), Icon(Icons.error)],
            ));
          }

          if (snapShot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: Get.height / 5,
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapShot.data!.docs.isEmpty) {
            return const Center(
                child: Row(
              children: [Text("No Products found!"), Icon(Icons.android)],
            ));
          }
          if (snapShot.data != null) {
            return GridView.builder(
                itemCount: snapShot.data!.docs.length,
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 20,
                    childAspectRatio: .8),
                itemBuilder: (context, index) {
                  final productData = snapShot.data!.docs[index];
                  ProductModel productModel = ProductModel(
                      productId: productData['productId'],
                      categoryId: productData['categoryId'],
                      productName: productData['productName'],
                      categoryName: productData['categoryName'],
                      salePrice: productData['salePrice'],
                      fullPrice: productData['fullPrice'],
                      productImages: productData['productImages'],
                      deliveryTime: productData['deliveryTime'],
                      isSale: productData['isSale'],
                      productDescription: productData['productDescription'],
                      createdAt: productData['createdAt'],
                      updatedAt: productData['updatedAt']);
                  return FlashSaleProductWidget(
                    productImages: productModel.productImages,
                    productName: productModel.productName,
                    salePrice: productModel.salePrice,
                    fullPrice: productModel.fullPrice,
                    deliveryTime: productModel.deliveryTime,
                    isSale: productModel.isSale,
                    width: 2.7,
                    height: 5,
                    onTap: () => Get.to(
                        () => ProductDetailsScreen(productModel: productModel)),
                  );
                });
          }

          return Container();
        },
      ),
    );
  }
}
