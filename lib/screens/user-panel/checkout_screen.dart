import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/controllers/cart_price_controller.dart';
import 'package:loot_bazar/models/cart_model.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final ProductPriceController productPriceController =
      Get.put(ProductPriceController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstant.appBackgroundColor,
      appBar: AppBar(
        backgroundColor: AppConstant.appMainColor,
        title: const Text(
          "Checkout Screen",
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

                // calculate price

                productPriceController.fetchProductPrice();

                return SwipeActionCell(
                  key: ObjectKey(cartModel.productId),
                  trailingActions: [
                    SwipeAction(
                        title: "Delete",
                        forceAlignmentToBoundary: true,
                        performsFirstActionWithFullSwipe: true,
                        onTap: (CompletionHandler hadnler) async {
                          await FirebaseFirestore.instance
                              .collection('cart')
                              .doc(user!.uid)
                              .collection('cartOrders')
                              .doc(cartModel.productId)
                              .delete();
                        })
                  ],
                  child: Container(
                    color: AppConstant.appBackgroundColor,
                    child: Column(
                      children: [
                        Card(
                          elevation: 5,
                          shadowColor: AppConstant.appMainColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          color: AppConstant.appWhiteColor,
                          child: Padding(
                            padding:
                                const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(cartModel.productTotalPrice.toString()),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (cartModel.productQuantity > 1) {
                                        await FirebaseFirestore.instance
                                            .collection('cart')
                                            .doc(user!.uid)
                                            .collection('cartOrders')
                                            .doc(cartModel.productId)
                                            .update({
                                          'productQuantity':
                                              cartModel.productQuantity - 1,
                                          'productTotalPrice': (double.parse(
                                                  cartModel.isSale
                                                      ? cartModel.salePrice
                                                      : cartModel.fullPrice) *
                                              (cartModel.productQuantity - 1)),
                                        });
                                      }
                                    },
                                    child: const CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppConstant.appMainColor,
                                      foregroundColor:
                                          AppConstant.appWhiteColor,
                                      child: Text(
                                        "-",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: AppConstant.appMainColor,
                                    foregroundColor: AppConstant.appWhiteColor,
                                    child: Text(
                                      cartModel.productQuantity.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (cartModel.productQuantity > 0 &&
                                          cartModel.productQuantity < 100) {
                                        await FirebaseFirestore.instance
                                            .collection('cart')
                                            .doc(user!.uid)
                                            .collection('cartOrders')
                                            .doc(cartModel.productId)
                                            .update({
                                          'productQuantity':
                                              cartModel.productQuantity + 1,
                                          'productTotalPrice': (double.parse(
                                                  cartModel.isSale
                                                      ? cartModel.salePrice
                                                      : cartModel.fullPrice) *
                                              (cartModel.productQuantity + 1)),
                                        });
                                      }
                                    },
                                    child: const CircleAvatar(
                                      radius: 16,
                                      backgroundColor: AppConstant.appMainColor,
                                      foregroundColor:
                                          AppConstant.appWhiteColor,
                                      child: Text(
                                        "+",
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
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
              Obx(
                () => Text(
                  "Rs.${productPriceController.totalPrice.toStringAsFixed(1)}",
                  style: const TextStyle(
                      color: AppConstant.appGreenColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ),
              Material(
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(25.0), // Set the radius here
                ),
                child: Container(
                  width: Get.width / 3.5,
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
