import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/svgIcon.dart';

class AboutUsCommonWidget extends StatelessWidget {
  const AboutUsCommonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: all20,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'go_to_spot'.tr,
            style: FontStyleUtilities.h2(
              fontColor: AppColors.primaryColor,
              fontWeight: FWT.bold,
            ),
          ),
          h30,
          Text(
            "about_us_description".tr,
            style: FontStyleUtilities.h5(fontColor: AppColors.white54),
            overflow: TextOverflow.visible,
          ),
          h30,
          ImageWithText(image: Images.aboutUsSvg, text: "learning_hub".tr),
          h14,
          ImageWithText(image: Images.aboutUsSvg, text: "transformation".tr),
          h14,
          ImageWithText(image: Images.aboutUsSvg, text: "hands_on".tr),
          h14,
          ImageWithText(image: Images.aboutUsSvg, text: '24/7'.tr),
          h30,
          Text(
            'trusted_by'.tr,
            style: FontStyleUtilities.h3(
              fontColor: AppColors.primaryColor,
              fontWeight: FWT.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class ImageWithText extends StatelessWidget {
  final String image;
  final String text;
  const ImageWithText({Key? key, required this.image, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgIcon(image, color: AppColors.primary),
        w10,
        Text(
          text,
          style: FontStyleUtilities.h5(
            fontColor: AppColors.white54,
          ),
        ),
      ],
    );
  }
}
