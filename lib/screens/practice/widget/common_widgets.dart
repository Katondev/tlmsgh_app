import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/assignment_model.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/svgIcon.dart';

class StartAssignmentButton extends StatelessWidget {
  final Function()? onPressed;
  final Assignment? assignment;
  const StartAssignmentButton({Key? key, this.onPressed, this.assignment})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgIcon(Images.calendar2Svg, height: 20, width: 20),
        w4,
        Text(
          "${assignment?.asnCreatedAt}".substring(0, 10),
          style: FontStyleUtilities.t2(
              fontWeight: FWT.regular, fontColor: AppColors.grey500),
        ),
        Spacer(),

        assignment?.asn_isCheckResult==true?LargeButton(
          onPressed: onPressed,
          height: 40,
          textColor: AppColors.primaryColor,
          color: AppColors.primaryYellow,
          child: Text(
            'show_question'.tr,
            style: FontStyleUtilities.h6(
                fontWeight: FWT.medium, fontColor: AppColors.white),
          ),
        ):
        LargeButton(
          onPressed: onPressed,
          height: 40,
          textColor: AppColors.primaryColor,
          color: AppColors.lightPurple1,
          child: Text(
            'start_assignment'.tr,
            style: FontStyleUtilities.h6(
                fontWeight: FWT.medium, fontColor: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }
}

class TotalMarksAndDuration extends StatelessWidget {
  final Assignment? assignment;
  const TotalMarksAndDuration({Key? key, this.assignment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        FutureBuilder(
            future: Translator().translate(
                "${"total_marks:".tr}  ${assignment?.asnTotalMarks}"),
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData
                    ? "${snapshot.data}"
                    : "${"total_marks:".tr}  ${assignment?.asnTotalMarks}",
                style: FontStyleUtilities.t2(
                    fontWeight: FWT.regular, fontColor: AppColors.grey500),
              );
            }),
        Spacer(),
        FutureBuilder(
            future: Translator()
                .translate("${"duration:".tr}  ${assignment?.asnDuration}"),
            builder: (context, snapshot) {
              return Text(
                snapshot.hasData
                    ? "${snapshot.data}"
                    : "${"duration:".tr}  ${assignment?.asnDuration}",
                style: FontStyleUtilities.t1(fontColor: AppColors.grey500),
              );
            }),
      ],
    );
  }
}
