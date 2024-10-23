import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      body: Container(
        child: ListView.builder(
          itemCount: 30,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) {
            return const Column(
              children: [
                Card(
                  elevation: 5,
                  color: AppConstant.appWhiteColor,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: AppConstant.appSecondaryTextColor,
                        child: Text(
                          "N",
                          style: TextStyle(color: AppConstant.appWhiteColor),
                        ),
                      ),
                      title: Text(
                        "New Dresses for women",
                      ),
                      subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text("2200"),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppConstant.appMainColor,
                            foregroundColor: AppConstant.appWhiteColor,
                            child: Text(
                              "-",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            radius: 16,
                            backgroundColor: AppConstant.appMainColor,
                            foregroundColor: AppConstant.appWhiteColor,
                            child: Text(
                              "+",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                )
              ],
            );
          },
        ),
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
