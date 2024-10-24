import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/models/product_model.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel productModel;
  ProductDetailsScreen({super.key, required this.productModel});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppConstant.appBackgroundColor,
        appBar: AppBar(
          backgroundColor: AppConstant.appMainColor,
          title: const Text(
            "Product Details ",
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
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: AppConstant.appWhiteColor,
            child: Column(
              children: [
                SizedBox(
                  height: Get.height / 200,
                ),
                // product images
                CarouselSlider(
                  items: widget.productModel.productImages
                      .map((imageUrls) => ClipRRect(
                            child: CachedNetworkImage(
                              imageUrl: imageUrls,
                              fit: BoxFit.cover,
                              width: Get.width,
                              placeholder: (context, url) => const ColoredBox(
                                color: AppConstant.appWhiteColor,
                                child: Center(
                                  child: CupertinoActivityIndicator(),
                                ),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    scrollDirection: Axis.horizontal,
                    autoPlay: true,
                    aspectRatio: 0.8,
                    viewportFraction: 1,
                  ),
                ),
                SizedBox(
                  height: Get.height / 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.productModel.productName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: AppConstant.appMainColor),
                                  ),
                                ),
                                const Icon(
                                  Icons.favorite_outline,
                                  color: AppConstant.appMainColor,
                                )
                              ],
                            )),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: widget.productModel.isSale
                              ? SizedBox(
                                  width: Get.width,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Rs. ",
                                        style: TextStyle(
                                          color: AppConstant.appTextColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        widget.productModel.fullPrice,
                                        style: const TextStyle(
                                            color: AppConstant
                                                .appSecondaryTextColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor:
                                                AppConstant.appRedColor,
                                            decorationThickness: 3),
                                      ),
                                      SizedBox(
                                        width: Get.width / 50,
                                      ),
                                      Text(
                                        widget.productModel.salePrice,
                                        style: const TextStyle(
                                            color: AppConstant.appRedColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  width: Get.width,
                                  child: Row(
                                    children: [
                                      const Text(
                                        "Rs. ",
                                        style: TextStyle(
                                          color: AppConstant.appTextColor,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        widget.productModel.fullPrice,
                                        style: const TextStyle(
                                            color: AppConstant.appRedColor,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Category :   ${widget.productModel.categoryName}',
                              style: const TextStyle(
                                  color: AppConstant.appSecondaryTextColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(
                            widget.productModel.productDescription,
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 13),
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Material(
                                child: Container(
                                  width: Get.width / 3.0,
                                  height: Get.height / 16,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppConstant.appTextColor,
                                        width: 2.0),
                                    color: AppConstant.appMainColor,
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'WhatsApp',
                                      style: TextStyle(
                                          color: AppConstant.appWhiteColor),
                                    ),
                                  ),
                                ),
                              ),
                              Material(
                                child: Container(
                                  width: Get.width / 3.0,
                                  height: Get.height / 16,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: AppConstant.appTextColor,
                                        width: 2.0),
                                    color: AppConstant.appMainColor,
                                    borderRadius: BorderRadius.circular(25.0),
                                  ),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Add to cart',
                                      style: TextStyle(
                                          color: AppConstant.appWhiteColor),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
