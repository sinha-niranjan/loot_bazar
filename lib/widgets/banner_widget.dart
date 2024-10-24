import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loot_bazar/controllers/banners_controller.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  final CarouselController carouselController = CarouselController();
  final BannersController _bannersController = Get.put(BannersController());
  @override
  Widget build(BuildContext context) {
    // ignore: avoid_unnecessary_containers
    return Container(
      child: Obx(() {
        return CarouselSlider(
          items: _bannersController.bannerUrls
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
        );
      }),
    );
  }
}
