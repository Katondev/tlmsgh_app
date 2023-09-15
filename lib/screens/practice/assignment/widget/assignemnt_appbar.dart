import 'package:flutter/material.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/widgets/responsive.dart';

AppBar AssignmentAppBar({
  String? assignmentTitle,
  String? count,
  int? assignmentTotalMark,
  int? assignmentDuration,
  BuildContext? context,
  bool? isTimer = false,
  VoidCallback? callback,
}) {
  return AppBar(
    shape: RoundedRectangleBorder(borderRadius: onlyTopLeft42),
    shadowColor: AppColors.shadowColor.withOpacity(0.25),
    toolbarHeight: 70,
    centerTitle: false,
    backgroundColor: Colors.transparent,
    leading: null,
    automaticallyImplyLeading: false,

    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            assignmentTitle ?? "",
            style: FontStyleUtilities.h4(fontWeight: FWT.semiBold),
          ),
        ),
        if (Responsive.isMobile(context!) == false)
          Text(
            "Total Marks: $assignmentTotalMark",
            style: FontStyleUtilities.t2(
                fontColor: AppColors.primaryYellow, fontWeight: FWT.semiBold),
          ),
        if (Responsive.isMobile(context) == false) w30,
        if (Responsive.isMobile(context) == false)
          Text(
            "Time: $count/$assignmentDuration",
            style: FontStyleUtilities.t2(
                fontColor: AppColors.blackType, fontWeight: FWT.semiBold),
          ),
        if (isTimer == true) w20,
        if (isTimer == true)
          OutlinedButton(
            onPressed: callback,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
              backgroundColor: AppColors.green,
              side: BorderSide(width: 2, color: AppColors.green),
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            child: Icon(
              Icons.close,
              color: AppColors.primaryWhite,
            ),
            // child: Text(
            //   "Submit",
            //   style: FontStyleUtilities.t2(
            //       fontColor: AppColors.white, fontWeight: FWT.semiBold),
            // ),
          ),
      ],
    ),
    // actions: [
    //   Text("Total Marks: $assignmentTotalMark",
    //       style: FontStyleUtilities.t2(fontColor: AppColors.primary,fontWeight: FWT.semiBold),),
    //   SizedBox(width: 10,),
    //   Text("Time: $assignmentTotalMark/$assignmentDuration",
    //       style: FontStyleUtilities.t2(fontColor: AppColors.grey500,fontWeight: FWT.semiBold),)
    // ]
  );
}
