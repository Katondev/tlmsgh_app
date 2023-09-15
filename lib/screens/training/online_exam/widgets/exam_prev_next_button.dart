import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class ExamPreviousNextButton extends StatelessWidget {
  const ExamPreviousNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingProvider>(
      builder: (context, value, child) => Padding(
        padding: Responsive.isMobile(context) ? b10 : b20,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            value.index == 0
                ? SizedBox(width: Responsive.isMobile(context) ? 120 : 170)
                : LargeButton(
                    width: Responsive.isMobile(context) ? 120 : 170,
                    height: 50,
                    onPressed: () {
                      value.onPreviousPress();
                    },
                    textColor: AppColors.primaryColor,
                    color: AppColors.primary,
                    borderRadius: cr50,
                    child: Text(
                      'Previous'.tr,
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium, fontColor: AppColors.white),
                    ),
                  ),
            w10,
            value.index == value.questionModel!.data!.questionData!.length - 1
                ? SizedBox(width: Responsive.isMobile(context) ? 120 : 170)
                : LargeButton(
                    width: Responsive.isMobile(context) ? 120 : 170,
                    height: 50,
                    onPressed: () {
                      value.onNextPress();
                    },
                    textColor: AppColors.primaryColor,
                    color: AppColors.primary,
                    borderRadius: cr50,
                    child: Text(
                      'Next'.tr,
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium, fontColor: AppColors.white),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
