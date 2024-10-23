import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/models/product_model.dart';
import 'package:loot_bazar/screens/user-panel/product_details_screen.dart';
import 'package:loot_bazar/widgets/flash_sale_product_widget.dart';

class AllProductsWidget extends StatefulWidget {
  const AllProductsWidget({super.key});

  @override
  State<AllProductsWidget> createState() => _AllProductsWidgetState();
}

class _AllProductsWidgetState extends State<AllProductsWidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance.collection('products').get(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapShot) {
          if (snapShot.hasError) {
            return const Center(
                child: Row(
              children: [Text("Error"), Icon(Icons.error)],
            ));
          }

          if (snapShot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
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
                      isSale: productModel.isSale,
                      width: 3,
                      height: 7,
                      onTap: () => Get.to(() =>
                          ProductDetailsScreen(productModel: productModel)),
                    );
                  }),
            );
          }

          return Container();
        });
  }
}
