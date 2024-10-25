import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/models/cart_model.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          "Cart Screen",
          style: TextStyle(
            color: AppConstant.appWhiteColor,
          ),
        ),
        iconTheme:
            const IconThemeData(color: AppConstant.appWhiteColor, size: 30),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => Navigator.of(context).pop()),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('cart')
            .doc(user!.uid)
            .collection('cartOrders')
            .snapshots(),
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
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Your Cart is Empty!",
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppConstant.appMainColor),
                ),
                Icon(
                  Icons.android,
                  size: 300,
                  color: AppConstant.appMainColor,
                )
              ],
            ));
          }
          if (snapShot.data != null) {
            return ListView.builder(
              itemCount: snapShot.data!.docs.length,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                final productData = snapShot.data!.docs[index];
                CartModel cartModel = CartModel(
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
                  updatedAt: productData['updatedAt'],
                  productQuantity: productData['productQuantity'],
                  productTotalPrice: productData['productTotalPrice'],
                );

                return SwipeActionCell(
                  key: ObjectKey(cartModel.productId),
                  trailingActions: [
                    SwipeAction(
                        title: "Delete",
                        forceAlignmentToBoundary: true,
                        performsFirstActionWithFullSwipe: true,
                        onTap: (CompletionHandler hadnler) async {
                          print("deleted");

                          await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(user!.uid)
                              .collection('cartOrders')
                              .doc(cartModel.productId)
                              .delete();
                        })
                  ],
                  child: Column(
                    children: [
                      Card(
                        elevation: 5,
                        shadowColor: AppConstant.appMainColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        color: AppConstant.appWhiteColor,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor:
                                  AppConstant.appSecondaryTextColor,
                              backgroundImage: NetworkImage(
                                cartModel.productImages[0],
                              ),
                            ),
                            title: Text(
                              cartModel.productName,
                            ),
                            subtitle: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(cartModel.productTotalPrice.toString()),
                                const SizedBox(
                                  width: 20,
                                ),
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppConstant.appMainColor,
                                  foregroundColor: AppConstant.appWhiteColor,
                                  child: Text(
                                    "-",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppConstant.appMainColor,
                                  foregroundColor: AppConstant.appWhiteColor,
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
      bottomNavigationBar: Container(
        color: AppConstant.appMainColor,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total:",
                style: TextStyle(
                    color: AppConstant.appWhiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const Text(
                "Rs.12,000",
                style: TextStyle(
                    color: AppConstant.appGreenColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25.0), // Set the radius here
                ),
                child: Container(
                  width: Get.width / 2.5,
                  height: Get.height / 16,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppConstant.appTextColor, width: 2.0),
                    color: AppConstant.appWhiteColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Checkout',
                      style: TextStyle(color: AppConstant.appMainColor),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
