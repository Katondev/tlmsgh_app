import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/screens/practice/assignment/controller/assignment_controller.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class AssignmentPreviousNextButton extends StatelessWidget {
  const AssignmentPreviousNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentController>(
      builder: (context, value, child) => Padding(
        padding: Responsive.isMobile(context) ? b10 : b20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            value.index == 0
                ? SizedBox(width: Responsive.isMobile(context) ? 120 : 170)
                : LargeButton(
                    width: Responsive.isMobile(context) ? 120 : 170,
                    height: 44,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: () {
                      value.onPreviousPress();
                    },
                    textColor: AppColors.primaryColor,
                    color: AppColors.primary,
                    child: Text(
                      'Previous'.tr,
                      style: AppTextStyle.normalBold14,
                    ),
                  ),
            w10,
            value.index == value.questionDetail.data!.questionData!.length - 1
                ? SizedBox(width: Responsive.isMobile(context) ? 120 : 170)
                : LargeButton(
                    width: Responsive.isMobile(context) ? 120 : 170,
                    height: 44,
                    borderRadius: BorderRadius.circular(10),
                    onPressed: () {
                      value.onNextPress();
                    },
                    textColor: AppColors.primaryColor,
                    color: AppColors.primary,
                    child: Text(
                      'Next'.tr,
                      style: AppTextStyle.normalBold14,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
