import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/models/order_model.dart';
import 'package:loot_bazar/screens/user-panel/main_screen.dart';
import 'package:loot_bazar/services/generate_order_id_service.dart';
import 'package:loot_bazar/utils/app_constant.dart';

void placeOrder({
  required BuildContext context,
  required String customerName,
  required String customerPhone,
  required String customerAddress,
  required String customerToken,
}) async {
  final user = FirebaseAuth.instance.currentUser;
  EasyLoading.show(status: "Please wait..... ");
  if (user != null) {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('cart')
          .doc(user.uid)
          .collection('cartOrders')
          .get();

      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      for (var doc in documents) {
        Map<String, dynamic>? data = doc.data() as Map<String, dynamic>;

        String orderId = generateOrderId();

        OrderModel orderModel = new OrderModel(
            productId: data['productId'],
            categoryId: data['categoryId'],
            productName: data['productName'],
            categoryName: data['categoryName'],
            salePrice: data['salePrice'],
            fullPrice: data['fullPrice'],
            productImages: data['productImages'],
            deliveryTime: data['deliveryTime'],
            isSale: data['isSale'],
            productDescription: data['productDescription'],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            productQuantity: data['productQuantity'],
            productTotalPrice:
                double.parse(data['productTotalPrice'].toString()),
            customerId: user.uid,
            status: false,
            customerName: customerName,
            customerPhone: customerPhone,
            customerAddress: customerAddress,
            customerDeviceToken: customerToken);

        for (var x = 0; x < documents.length; x++) {
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .set({
            'uId': user.uid,
            'customerName': customerName,
            'customerPhone': customerPhone,
            'customerAddress': customerAddress,
            'customerDeviceToken': customerToken,
            'orderStatus': false,
            'createdAt': DateTime.now(),
          });

          // upload orders
          await FirebaseFirestore.instance
              .collection('orders')
              .doc(user.uid)
              .collection('confiremOrders')
              .doc(orderId)
              .set(orderModel.toMap());

          // delete cart products
          await FirebaseFirestore.instance
              .collection('cart')
              .doc(user.uid)
              .collection('cartOrders')
              .doc(orderModel.productId.toString())
              .delete()
              .then((value) {
            print('Delete cart products ${orderModel.productId.toString()}');
          });
        }
      }

      print("Order confirmed");
      Get.snackbar("Order Confirmed", "Thank you for your order ! ",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: AppConstant.appMainColor,
          colorText: AppConstant.appWhiteColor,
          duration: const Duration(seconds: 5));

      EasyLoading.dismiss();
      Get.offAll(() => const MainScreen());
    } catch (e) {
      print("error $e");
    }
  }
}
