import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';

import '../../../../utils/app_colors.dart';
import '../../../../widgets/responsive.dart';

class StageWidget extends StatelessWidget {
  const StageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Responsive.isMobilenew(context) ? 50 : 70,
      // color: AppColors.black12,
      color: AppColors.boxgrey,
      width: Get.width,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(horizontal: 15),
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, i) {
          var data = stageList[i];
          return stage(context, data);
        },
        itemCount: stageList.length,
      ),
    );
  }
}

List stageList = [
  "Training Option",
  "Signed Form",
  "Get Training",
  "Online Exam",
  "Certification",
];

Widget stage(BuildContext context, String stage) {
  return Container(
    height: Responsive.isMobilenew(context) ? 30 : 40,
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Row(
      children: [
        // Image.asset(
        //   "assets/images/fast-forward.png",
        //   height: Responsive.isMobilenew(context) ? 18 : 20,
        // ),
        Icon(
          Icons.arrow_forward_ios,
          size: Responsive.isMobilenew(context) ? 15 : 18,
        ),
        w6,
        Text(
          "${stage}",
          style: Responsive.isMobilenew(context)
              ? FontStyleUtilities.t1(fontWeight: FWT.medium)
              : FontStyleUtilities.h5(fontWeight: FWT.medium),
        ),
      ],
    ),
  );
}
