import 'package:flutter/material.dart';
import 'package:katon/components/app_text_style.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';

class TrendingNowWidget extends StatelessWidget {
  const TrendingNowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 430,
      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 40),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: AppColors.boxShadowColor.withOpacity(.15),
                spreadRadius: 3,
                blurRadius: 9,
                offset: Offset(0, 3))
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Trending now",
            style: AppTextStyle.normalBold20.copyWith(
              color: AppColors.textgreyColor,
            ),
          ),
          h16,
          trendingWidget(
            tag: "#healthcare",
            connects: 20580,
          ),
          h10,
          trendingWidget(
            tag: "#smartlearning",
            connects: 3050,
          ),
          h10,
          trendingWidget(
            tag: "#tlms",
            connects: 1029,
          ),
          h10,
          trendingWidget(
            tag: "#smartbox",
            connects: 100,
          ),
          h10,
          trendingWidget(
            tag: "#smartlearning",
            connects: 89,
          ),
          h10,
          trendingWidget(
            tag: "#tlms",
            connects: 58,
          ),
          h10,
          trendingWidget(
            tag: "#smartbox",
            connects: 20,
          ),
        ],
      ),
    );
  }
}

Widget trendingWidget({required String tag, required int connects}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "${tag}",
        style: AppTextStyle.normalBold12.copyWith(
          color: AppColors.primaryBlack,
        ),
      ),
      // h2,
      Text(
        "${connects} connects",
        style: AppTextStyle.normalRegular12.copyWith(
          color: AppColors.textgreyColor,
        ),
      ),
    ],
  );
}
