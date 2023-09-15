import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/exam_result/widgets/exam_table.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';

class ExamResultPageTablet extends StatelessWidget {
  final Arguments arguments;

  const ExamResultPageTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: commonAppBar(
        title: arguments.title,
        description: arguments.description,
      ),
      // endDrawer: endDrawer(),
      body: Container(
        margin: hz60,
        decoration: BoxDecoration(
          borderRadius: cr24,
        ),
        child: Column(
          children: [
            h20,
            Container(
              decoration: BoxDecoration(
                  color: Color(0xffDDE3ED), borderRadius: onlyTopLeftRight24),
              child: TabBar(
                overlayColor: MaterialStateProperty.all(
                    AppColors.primaryColor.withOpacity(0.2)),
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.white,
                unselectedLabelColor: AppColors.black,
                labelStyle: FontStyleUtilities.h5(fontWeight: FWT.semiBold),
                unselectedLabelStyle:
                    FontStyleUtilities.h5(fontWeight: FWT.semiBold),
                indicator: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: onlyTopLeftRight24,
                  ),
                  color: Color(0xff00BEE3),
                ),
                tabs: [
                  Tab(text: "term_1".tr),
                  Tab(text: "term_2".tr),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Container(
                    // height: 594,
                    color: AppColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ExamTable(
                          circleColor: AppColors.darkBlue,
                          strokeColor: AppColors.grey,
                          color: AppColors.purple,
                          text: "semester_1".tr,
                          processPercentage: 70,
                        ),
                        ExamTable(
                          circleColor: AppColors.redAccent,
                          strokeColor: AppColors.grey,
                          color: AppColors.redAccent,
                          text: "semester_2".tr,
                          processPercentage: 50,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    // height: 594,
                    color: AppColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ExamTable(
                            circleColor: AppColors.darkBlue,
                            strokeColor: AppColors.grey,
                            color: AppColors.purple,
                            text: "semester_3".tr,
                            processPercentage: 70),
                        ExamTable(
                            circleColor: AppColors.redAccent,
                            strokeColor: AppColors.grey,
                            color: AppColors.redAccent,
                            text: "semester_4".tr,
                            processPercentage: 50),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
