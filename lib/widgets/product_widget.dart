import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class ProductWidget extends StatefulWidget {
  final String categoryImage;
  final String categoryName;
  const ProductWidget({
    super.key,
    required this.categoryImage,
    required this.categoryName,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
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
                children: [
                  Container(
                    height: Get.height / 7,
                    width: Get.width / 3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: AppConstant.appWhiteColor,
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(widget.categoryImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(widget.categoryName,
                        style: const TextStyle(
                            color: AppConstant.appMainColor,
                            fontWeight: FontWeight.w600)),
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
