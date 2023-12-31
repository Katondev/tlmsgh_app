// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/library_page/widget/expansion_widget.dart';
import 'package:katon/screens/practice/past_questions/past_questions_screen.dart';
import 'package:katon/screens/practice/self_assessment/self_assessment_screen.dart';
import 'package:katon/screens/training/pdf_viewer/pdf_viewer.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import '../../../teacher/drawer.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/drawer/drawer.dart';
import '../../../widgets/no_data_found.dart';
import '../../home_page.dart';
import '../controller/practice_prv.dart';

class PracticeTeacherPagePhone extends StatefulWidget {
  final Arguments arguments;

  const PracticeTeacherPagePhone({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeTeacherPagePhone> createState() =>
      _PracticeTeacherPagePhoneState();
}

class _PracticeTeacherPagePhoneState extends State<PracticeTeacherPagePhone> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.boxgreyColor,
      resizeToAvoidBottomInset: false,
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      // endDrawer: endDrawer(),
      appBar: CommonAppbarMobile(title: widget.arguments.title),
      body: Consumer<PracticePrv>(
        builder: (context, ePrv, child) {
          return Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: (ePrv.practiceTeacherList.isEmpty)
                      ? NoDataFound(message: "no_book_found".tr)
                      : GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            // crossAxisCount: 4,
                            maxCrossAxisExtent: 200,
                            mainAxisExtent: 200,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15,
                            childAspectRatio: 0.95,
                          ),
                          itemBuilder: (context, i) {
                            var data = ePrv.practiceTeacherList[i];
                            return GestureDetector(
                              onTap: () {
                                ePrv.selectedPractice = i;
                                navigatorKey.currentState!.pushNamed(
                                    RoutesConst.practiceSubject,
                                    arguments: data["title"]);
                              },
                              child: Container(
                                // height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: AppColors.primaryWhite,
                                    boxShadow: [
                                      BoxShadow(
                                          color: AppColors.primaryBlack
                                              .withOpacity(.05),
                                          blurRadius: 12),
                                    ]),

                                child: Column(
                                  children: [
                                    // Text(
                                    //   "${data.ppTitle}",
                                    //   textAlign: TextAlign.center,
                                    //   maxLines: 2,
                                    //   overflow: TextOverflow.ellipsis,
                                    //   style: AppTextStyle.normalBold20
                                    //       .copyWith(
                                    //     color: AppColors.primaryBlack,
                                    //   ),
                                    // ),
                                    // h20,
                                    Expanded(
                                      child: Container(
                                        width: Get.width,
                                        height: 100,
                                        padding: const EdgeInsets.all(40),
                                        child: Image.asset(
                                          data["image"],
                                          // height: 100,
                                        ),
                                      ),
                                    ),
                                    // h22,
                                    // const Spacer(),
                                    Container(
                                      width: Get.width,
                                      height: 50,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                        ),
                                        color: AppColors.boxgreyColor
                                            .withOpacity(.7),
                                      ),
                                      child: Text(
                                        data["title"],
                                        textAlign: TextAlign.center,
                                        style: AppTextStyle.normalRegular16
                                            .copyWith(
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: ePrv.practiceTeacherList.length,
                        ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
