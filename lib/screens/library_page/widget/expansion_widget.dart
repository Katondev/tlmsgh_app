import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/widgets/responsive.dart';

import '../../../components/app_text_style.dart';
import '../../../res.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';

class ExpansionWidget extends StatelessWidget {
  // final String subjectIcon;
  final String title;
  final String? trailingIcon;
  final EdgeInsetsGeometry margin;
  final Color? borderColor;
  const ExpansionWidget(
      {super.key,
      // required this.subjectIcon,
      required this.title,
      this.trailingIcon,
      required this.margin,
      this.borderColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75,
      width: Get.width,
      margin: margin,
      padding: (Responsive.isMobilenew(context))
          ? EdgeInsets.fromLTRB(26, 16, 30, 16)
          : EdgeInsets.fromLTRB(26, 16, 50, 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: borderColor ?? AppColors.primaryWhite),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 3,
                color: AppColors.primaryYellow,
              ),
            ),
            child: Text(
                "${title[0]}${(title.contains(" ")) ? title.split(" ")[1].toString()[0] : title[1]}",
                style: AppTextStyle.normalBold14
                    .copyWith(color: AppColors.primaryYellow)),
          ),
          w14,
          Expanded(
            flex: 2,
            child: Text(
              title,
             // maxLines: 7,
               overflow: TextOverflow.visible,
              style: AppTextStyle.normalRegular16
                  .copyWith(fontWeight: FontWeight.w400, color: AppColors.black),
            ),
          ),
         // Spacer(),
          (trailingIcon != null)
              ? SizedBox(
                  height: (trailingIcon == AppAssets.ic_arrow_left) ? 12 : 8,
                  child: Image.asset(
                    trailingIcon!,
                    // height: 10,
                    color: AppColors.primaryYellow,
                  ),
                )
              : SizedBox(),
          if (trailingIcon == AppAssets.ic_arrow_left) w2,
        ],
      ),
    );
  }
}
