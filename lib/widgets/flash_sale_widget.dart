import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/models/categories_model.dart';
import 'package:loot_bazar/models/product_model.dart';
import 'package:loot_bazar/utils/app_constant.dart';
import 'package:loot_bazar/widgets/flash_sale_product_widget.dart';
import 'package:loot_bazar/widgets/product_widget.dart';

class FlashSaleWidget extends StatefulWidget {
  const FlashSaleWidget({super.key});

  @override
  State<FlashSaleWidget> createState() => _FlashSaleWidgetState();
}

class _FlashSaleWidgetState extends State<FlashSaleWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
            return Container(
              child: const Center(
                child: CupertinoActivityIndicator(),
              ),
            );
          }

          if (snapShot.data!.docs.isEmpty) {
            return const Center(
                child: Row(
              children: [Text("No Product found!"), Icon(Icons.android)],
            ));
          }
          if (snapShot.data != null) {
            return SizedBox(
              height: Get.height / 5,
              child: ListView.builder(
                  itemCount: snapShot.data!.docs.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
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
                        isSale: productModel.isSale);
                  }),
            );
          }

          return Container();
        });
  }
}
