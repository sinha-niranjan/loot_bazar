import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class FlashSaleProductWidget extends StatefulWidget {
  final List<dynamic> productImages;
  final String productName;
  final String fullPrice;
  final bool isSale;
  final String salePrice;
  final String deliveryTime;
  const FlashSaleProductWidget({
    super.key,
    required this.productImages,
    required this.productName,
    required this.fullPrice,
    required this.isSale,
    required this.salePrice,
    required this.deliveryTime,
  });

  @override
  State<FlashSaleProductWidget> createState() => _FlashSaleProductWidgetState();
}

class _FlashSaleProductWidgetState extends State<FlashSaleProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppConstant.appWhiteColor),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Container(
              decoration: const BoxDecoration(color: AppConstant.appWhiteColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height / 7,
                    width: Get.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppConstant.appWhiteColor,
                      image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(widget.productImages[0]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: SizedBox(
                      width: Get.width / 3.1,
                      child: Text(widget.productName,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: AppConstant.appMainColor,
                              fontSize: 10,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                  SizedBox(
                    width: Get.width / 3,
                    child: Row(
                      children: [
                        const Text(
                          "Rs. ",
                          style: TextStyle(
                            color: AppConstant.appTextColor,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.fullPrice,
                          style: const TextStyle(
                              color: AppConstant.appSecondaryTextColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                              decoration: TextDecoration.lineThrough,
                              decorationColor: AppConstant.appRedColor,
                              decorationThickness: 3),
                        ),
                        SizedBox(
                          width: Get.width / 50,
                        ),
                        Text(
                          widget.salePrice,
                          style: const TextStyle(
                              color: AppConstant.appRedColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
