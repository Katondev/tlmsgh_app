import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/practice/practice_details/controller/mcq_test_prv.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class PreviousAndNextButton extends StatelessWidget {
  const PreviousAndNextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<McqTestPrv>(
      builder: (context, value, child) => Padding(
        padding:Responsive.isMobile(context)?b10:b20,
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
            value.index == 9
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
