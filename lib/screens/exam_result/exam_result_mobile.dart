import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/exam_result/widgets/exam_table.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';

import '../home_page.dart';

class ExamResultPageMobile extends StatelessWidget {
  final Arguments arguments;
  const ExamResultPageMobile({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CommonAppbarMobile(title: arguments.title),
      // endDrawer: endDrawerMobile(),
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      body: Container(
        margin: hz10,
        decoration: BoxDecoration(
          borderRadius: cr24,
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
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
              processPercentage: 50,
            ),
          ],
        ),
      ),
    );
  }
}
