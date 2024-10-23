import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/models/product_model.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class ProductDetailsScreen extends StatefulWidget {
  ProductModel productModel;
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
        body: Container(
          child: Column(
            children: [
              SizedBox(
                height: Get.height / 30,
              ),
              // product images
              CarouselSlider(
                items: widget.productModel.productImages
                    .map((imageUrls) => ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: imageUrls,
                            fit: BoxFit.cover,
                            width: Get.width - 10,
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
                  aspectRatio: 2,
                  viewportFraction: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(widget.productModel.productName),
                                Icon(Icons.favorite_outline)
                              ],
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Text("Category : " +
                                widget.productModel.categoryName)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child:
                              Text("Price :" + widget.productModel.fullPrice),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Text(widget.productModel.productDescription),
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
                ),
              )
            ],
          ),
        ));
  }
}
