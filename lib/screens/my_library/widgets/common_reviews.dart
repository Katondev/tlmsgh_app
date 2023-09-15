import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/common_widgets.dart';

class CommonReviews extends StatelessWidget {
  const CommonReviews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DottedLine(width: 0.6, color: AppColors.primary),
        h26,
        Text(
          "reviews".tr,
          style: FontStyleUtilities.h6(
            height: 0,
            fontColor: AppColors.gray800,
            fontWeight: FWT.medium,
          ),
        ),
        ReviewsList(),
      ],
    );
  }
}
