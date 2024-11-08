import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:loot_bazar/models/order_model.dart';
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
          onPressed: () {
            String feedback = feedbackController.text.trim();
            print(feedback);
            print(productRating);
            Navigator.of(context).pop(); // Close the dialog
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
