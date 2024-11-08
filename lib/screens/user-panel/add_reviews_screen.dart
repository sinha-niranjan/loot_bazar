import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loot_bazar/models/order_model.dart';
import 'package:loot_bazar/models/review_model.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class AddReviewsDialog extends StatefulWidget {
  final OrderModel orderModel;
  const AddReviewsDialog({super.key, required this.orderModel});

  @override
  State<AddReviewsDialog> createState() => _AddReviewsDialogState();
}

class _AddReviewsDialogState extends State<AddReviewsDialog> {
  TextEditingController feedbackController = TextEditingController();
  double productRating = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppConstant.appBackgroundColor,
      title: const Text(
        "Add Reviews",
        style: TextStyle(color: AppConstant.appMainColor),
      ),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('Add your rating and review'),
            const SizedBox(height: 20),
            RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: AppConstant.appMainColor,
              ),
              onRatingUpdate: (rating) {
                setState(() {
                  productRating = rating;
                });
              },
            ),
            const SizedBox(height: 20),
            const Text("Feedback"),
            const SizedBox(height: 20),
            TextFormField(
              controller: feedbackController,
              decoration: const InputDecoration(
                labelText: "Share your feedback",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text("Cancel"),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: AppConstant.appMainColor),
          onPressed: () async {
            Navigator.of(context).pop();
            EasyLoading.show(status: "Please wait...");
            String feedback = feedbackController.text.trim();

            ReviewModel reviewModel = ReviewModel(
              customerName: widget.orderModel.customerName,
              customerPhone: widget.orderModel.customerPhone,
              customerDeviceToken: widget.orderModel.customerDeviceToken,
              customerId: widget.orderModel.customerId,
              feedback: feedback,
              rating: productRating.toString(),
              createdAt: DateTime.now(),
            );

            try {
              await FirebaseFirestore.instance
                  .collection('products')
                  .doc(widget.orderModel.productId)
                  .collection('reviews')
                  .doc(widget.orderModel.customerId)
                  .set(reviewModel.toMap());
            } catch (e) {
              EasyLoading.showError("Failed to add review");
            } finally {
              EasyLoading.dismiss();
            }
          },
          child: const Text(
            'Submit',
            style: TextStyle(
              color: AppConstant.appWhiteColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
