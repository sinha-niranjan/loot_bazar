import 'package:flutter/cupertino.dart';
import 'package:loot_bazar/utils/app_constant.dart';

class HeadingWidget extends StatelessWidget {
  final String headingTitle;
  final String headingSubTitle;
  final VoidCallback onTap;
  final String buttonText;

  const HeadingWidget(
      {super.key,
      required this.headingTitle,
      required this.headingSubTitle,
      required this.onTap,
      required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppConstant.appWhiteColor,
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(right: 5.0, left: 5.0, top: 10.0),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  headingTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppConstant.appTextColor,
                  ),
                ),
                Text(
                  headingSubTitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 12,
                    color: AppConstant.appSecondaryTextColor,
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: AppConstant.appSecondaryColor,
                    width: 1.5,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    buttonText,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12.0,
                        color: AppConstant.appSecondaryColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
