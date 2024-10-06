import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class ProductWidget extends StatefulWidget {
  final String categoryImage;
  final String categoryName;
  final double height;
  final double width;
  const ProductWidget({
    super.key,
    required this.categoryImage,
    required this.categoryName,
    required this.height,
    required this.width,
  });

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppConstant.appWhiteColor,
          borderRadius: BorderRadius.circular(10)),
      child: (Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Container(
          decoration: const BoxDecoration(
            color: AppConstant.appWhiteColor,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Get.height / widget.height,
                  width: Get.width / widget.width,
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
                  child: SizedBox(
                    width: Get.width / 4,
                    child: Text(widget.categoryName,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: AppConstant.appMainColor,
                            fontWeight: FontWeight.w600)),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}
