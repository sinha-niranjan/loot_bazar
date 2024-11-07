import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/controllers/cart_price_controller.dart';
import 'package:loot_bazar/models/order_model.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class AllOrdersScreen extends StatefulWidget {
  const AllOrdersScreen({super.key});

  @override
  State<AllOrdersScreen> createState() => _AllOrdersScreenState();
}

class _AllOrdersScreenState extends State<AllOrdersScreen> {
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
          "All Orders",
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
            .collection('orders')
            .doc(user!.uid)
            .collection('confiremOrders')
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
                  "Your Orders is Empty!",
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
                final order = snapShot.data!.docs[index];
                OrderModel orderModel = OrderModel(
                  productId: order['productId'],
                  categoryId: order['categoryId'],
                  productName: order['productName'],
                  categoryName: order['categoryName'],
                  salePrice: order['salePrice'],
                  fullPrice: order['fullPrice'],
                  productImages: order['productImages'],
                  deliveryTime: order['deliveryTime'],
                  isSale: order['isSale'],
                  productDescription: order['productDescription'],
                  createdAt: order['createdAt'],
                  updatedAt: order['updatedAt'],
                  productQuantity: order['productQuantity'],
                  productTotalPrice:
                      double.parse(order['productTotalPrice'].toString()),
                  customerId: order['customerId'],
                  status: order['status'],
                  customerAddress: order['customerAddress'],
                  customerPhone: order['customerPhone'],
                  customerDeviceToken: order['customerDeviceToken'],
                  customerName: order['customerName'],
                );

                // calculate price

                productPriceController.fetchProductPrice();

                return Container(
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
                          padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                          child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor:
                                    AppConstant.appSecondaryTextColor,
                                backgroundImage: NetworkImage(
                                  orderModel.productImages[0],
                                ),
                              ),
                              title: Text(
                                orderModel.productName,
                              ),
                              subtitle: Row(
                                children: [
                                  const Text(
                                    "Price: \$",
                                    style: TextStyle(
                                        color: AppConstant.appMainColor),
                                  ),
                                  Text(
                                    orderModel.productTotalPrice.toString(),
                                    style: const TextStyle(
                                        color:
                                            AppConstant.appSecondaryTextColor),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  orderModel.status != true
                                      ? const Text(
                                          "Pending..... ",
                                          style: TextStyle(
                                            color: AppConstant.appGreenColor,
                                          ),
                                        )
                                      : const Text(
                                          "Delivered..... ",
                                          style: TextStyle(
                                              color: AppConstant.appRedColor),
                                        ),
                                ],
                              )),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
