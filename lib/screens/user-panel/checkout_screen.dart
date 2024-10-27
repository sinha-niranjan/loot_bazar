import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/controllers/cart_price_controller.dart';
import 'package:loot_bazar/controllers/get_customer_device_token_controller.dart';
import 'package:loot_bazar/models/cart_model.dart';
import 'package:loot_bazar/services/place_order_service.dart';
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

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();

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
                  width: Get.width / 2.5,
                  height: Get.height / 16,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: AppConstant.appTextColor, width: 2.0),
                    color: AppConstant.appWhiteColor,
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      showCustomBttomSheet();
                    },
                    child: const Text(
                      'Confirm Order',
                      style: TextStyle(
                          color: AppConstant.appMainColor, fontSize: 14),
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

  void showCustomBttomSheet() {
    Get.bottomSheet(
      Container(
        height: Get.height * 0.8,
        decoration: const BoxDecoration(
          color: AppConstant.appWhiteColor,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20,
                    ),
                    child: Container(
                      height: 55.0,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                          labelText: "Name",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20,
                    ),
                    child: Container(
                      height: 55.0,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          labelText: "Phone",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 20,
                    ),
                    child: Container(
                      height: 55.0,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        decoration: const InputDecoration(
                          labelText: "Address",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 10,
                          ),
                          hintStyle: TextStyle(fontSize: 12),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppConstant.appMainColor,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              ),
              onPressed: () async {
                if (nameController.text.trim() != "" &&
                    phoneController.text.trim() != "" &&
                    addressController.text.trim() != "") {
                  String name = nameController.text.trim();
                  String phone = phoneController.text.trim();
                  String address = addressController.text.trim();

                  String customerToken = await getCustomerDeviceToken();

                  // place order service
                  placeOrder(
                      context: context,
                      customerName: name,
                      customerPhone: phone,
                      customerAddress: address,
                      customerToken: customerToken);
                } else {
                  print("Please fill all details ");
                }
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  "Place Order",
                  style: TextStyle(
                    color: AppConstant.appWhiteColor,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppConstant.appTransparentBackgroundColor,
      isDismissible: true,
      enableDrag: true,
      elevation: 6,
    );
  }
}
