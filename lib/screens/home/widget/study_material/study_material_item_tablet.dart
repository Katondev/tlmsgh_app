import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_widgets.dart';

class StudyMaterialItemTablet extends StatelessWidget {
  const StudyMaterialItemTablet({
    Key? key,
    required this.image,
    required this.bookName,
    required this.isFree,
    required this.bookPrice,
  }) : super(key: key);

  final String? image;
  final String? bookName;
  final bool? isFree;
  final double? bookPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 152,
      width: 470,
      margin: r20,
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: cr12,
          border: Border.all(width: 0.57, color: AppColors.gray200)),
      child: Row(
        children: [
          Container(
            height: 127,
            width: 137,
            margin: l11r36,
            padding: h31v17,
            decoration: BoxDecoration(
                borderRadius: cr8,
                color: AppColors.cardColor),
            child: Center(
              child: CachedNetworkImage(
                // height: 127,
                imageUrl: "$image",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: t24,
            child: SizedBox(
              width: 229,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Text(
                          "$bookName",
                          overflow: TextOverflow.ellipsis,
                          style: FontStyleUtilities.t4(fontWeight: FWT.medium),
                        ),
                      ),
                      Text(isFree == true ? "free".tr : "\$$bookPrice",
                          style: FontStyleUtilities.t4(fontWeight: FWT.medium))
                    ],
                  ),
                  h6,
                  RatingStars(height: 11, width: 11, space: 1),
                 h16,
                  LargeButton(
                    onPressed: () {},
                    height: 40,
                    width: 229,
                    borderWidth: 1,
                    textColor: AppColors.primaryColor,
                    color: AppColors.lightPurple1,
                    child: Text(
                      'details'.tr,
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: AppColors.primaryColor),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
