import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/past_paper_model.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/screens/self_assessment/model/self_assessment_list_model.dart';
import 'package:katon/screens/self_assessment/self_assesment_controller.dart';
import 'package:katon/screens/self_assessment/self_test_assignment.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:provider/provider.dart';

import '../../components/app_text_style.dart';

class SelfAssessmentItem extends StatelessWidget {
  final SelfAssessmentList selfassesment_item;

  const SelfAssessmentItem({Key? key, required this.selfassesment_item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelfAssessmentController>(
      builder: (context, value, child) => Container(
        // width: context.width / 2.5 - 20,
        width: Responsive.isMobilenew(context)
            ? Get.width
            : context.width / 2.5 - 20,
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.borderColor),
            borderRadius: cr20),
        padding: Responsive.isMobilenew(context) ? all14 : all20,
        // margin: Responsive.isMobilenew(context)
        //     ? EdgeInsets.symmetric(horizontal: 20, vertical: 5)
        //     : t10l18,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: Translator().translate(
                    "${selfassesment_item.saTitle!.isEmpty ? selfassesment_item.saSubCategory : selfassesment_item.saTitle}"),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData
                        ? "${snapshot.data}"
                        : "${selfassesment_item.saTitle!.isEmpty ? selfassesment_item.saSubCategory : selfassesment_item.saTitle}",
                    maxLines: 2,
                    style: AppTextStyle.normalBold20
                        .copyWith(color: AppColors.primaryBlack),
                  );
                }),
            h10,
            h22,
            Container(
              // height: 30,
              width: Get.width,
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.buttonblueColor.withOpacity(.08),
              ),
              child: Text(
                "${selfassesment_item.saCategory}",
                style: AppTextStyle.normalRegular14.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            h10,
            GestureDetector(
              onTap: (selfassesment_item.saScore == null ||
                      selfassesment_item.saScore == 0)
                  ? () {
                      value.getAllSelfAssessment(selfassesment_item.saId!);
                    }
                  : () {},
              child: Container(
                // height: 30,
                width: Get.width,
                padding: EdgeInsets.symmetric(vertical: 8),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: (selfassesment_item.saScore == null ||
                          selfassesment_item.saScore == 0)
                      ? AppColors.primaryYellow
                      : AppColors.primaryBlack,
                ),
                child: Text(
                  selfassesment_item.saScore == null ||
                          selfassesment_item.saScore == 0
                      ? "start_exam_self".tr
                      : "done".tr,
                  style: AppTextStyle.normalBold14,
                ),
              ),
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     FutureBuilder(
            //         future:
            //             Translator().translate("${selfassesment_item.saTopic}"),
            //         builder: (context, snapshot) {
            //           return Text(
            //             snapshot.hasData
            //                 ? "${snapshot.data}"
            //                 : "${selfassesment_item.saTopic}",
            //             style: FontStyleUtilities.t3(),
            //           );
            //         }),
            //     FutureBuilder(
            //         future: Translator().translate(
            //             "${"Marks:${selfassesment_item.saScore ?? 0} / ${selfassesment_item.saTotalMarks}"}"),
            //         builder: (context, snapshot) {
            //           return Text(
            //             snapshot.hasData
            //                 ? "${snapshot.data}"
            //                 : "${"Marks:${selfassesment_item.saScore ?? 0} / ${selfassesment_item.saTotalMarks}"}",
            //             style: FontStyleUtilities.t2(),
            //           );
            //         }),
            //   ],
            // ),
            // h10,
            // Row(
            //   children: [
            //     SvgIcon(Images.calendarSvg, color: AppColors.black, height: 20),
            //     w8,
            //     FutureBuilder(
            //         future: Translator().translate(
            //             "${"year".tr}-${FormatDate.year(selfassesment_item.saDateTime.toString())}"),
            //         builder: (context, snapshot) {
            //           return Expanded(
            //             child: Text(
            //               snapshot.hasData
            //                   ? "${snapshot.data}"
            //                   : "${"year".tr}-${selfassesment_item.saDateTime}",
            //               style: FontStyleUtilities.t2(),
            //             ),
            //           );
            //         }),
            //     Spacer(),
            //     selfassesment_item.saScore == null ||
            //             selfassesment_item.saScore == 0
            //         ? LargeButton(
            //             onPressed: () async {
            //               value.getAllSelfAssessment(selfassesment_item.saId!);
            //             },
            //             child: Text(
            //               "start_exam_self".tr,
            //               style: FontStyleUtilities.t2(
            //                   fontWeight: FWT.medium,
            //                   fontColor: AppColors.primaryColor),
            //             ),
            //             color: Colors.transparent,
            //             borderColor: AppColors.borderColor,
            //             borderWidth: 1,
            //             height: 35,
            //             borderRadius: cr8,
            //             width: 90,
            //           )
            //         : LargeButton(
            //             onPressed: () {},
            //             child: Text(
            //               "done".tr,
            //               style: FontStyleUtilities.t2(
            //                   fontWeight: FWT.medium,
            //                   fontColor: AppColors.white),
            //             ),
            //             color: AppColors.black,
            //             borderColor: AppColors.borderColor,
            //             borderWidth: 0,
            //             height: 30,
            //             borderRadius: cr8,
            //             width: 100,
            //           )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}
