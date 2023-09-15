import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/practice/assignment/widget/assignemnt_appbar.dart';
import 'package:katon/screens/practice/assignment/widget/assignment_page_container.dart';
import 'package:katon/screens/practice/practice_details/widgets/answer_or_notanswer_widget.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/screens/training/online_exam/widgets/given_answer_widget.dart';
import 'package:katon/screens/training/online_exam/widgets/online_exam_widget.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class OnlineExamTablet extends StatefulWidget {
  const OnlineExamTablet({super.key});

  @override
  _OnlineExamTabletState createState() => new _OnlineExamTabletState();
}

class _OnlineExamTabletState extends State<OnlineExamTablet> {
  // TrainingProvider? trainingPrv;

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Consumer<TrainingProvider>(builder: (contexts, asn, child) {
        return WillPopScope(
          onWillPop: () async {
            if (asn.timer != null) {
              asn.cancelTimer();
            } else {
              Navigator.pop(context);
            }
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text("${asn.questionModel!.data!.title}"),
            ),
            // appBar: AssignmentAppBar(
            //   assignmentTitle: asn.questionModel!.data!.title ?? "",
            //   count: asn.timerText,
            //   isTimer: asn.timer != null ? true : false,
            //   assignmentTotalMark: asn.questionModel!.data!.totalMarks!,
            //   context: context,
            //   callback: () {
            //     asn.resultChecker(true, context);
            //   },
            //   assignmentDuration: int.parse(asn.questionModel!.data!.duration!),
            // ),
            body: SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total Marks: ${asn.questionModel!.data!.totalMarks}",
                          style: FontStyleUtilities.h4(
                              fontColor: AppColors.primary,
                              fontWeight: FWT.semiBold),
                        ),
                        Text(
                          "Time: ${asn.timerText}/${int.parse(asn.questionModel!.data!.duration!)}",
                          style: FontStyleUtilities.h4(
                              fontColor: AppColors.blackType,
                              fontWeight: FWT.semiBold),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: asn.value
                          ? Loader(message: "loading_wait".tr)
                          : asn.connection
                              ? NoInternet(onTap: () => asn.getExamQuestions())
                              : asn.questionModel!.data == null ||
                                      asn.questionModel!.data!.questionData
                                              ?.length ==
                                          0
                                  ? NoDataFound(message: "no_record".tr)
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                      padding: v10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ConnectionWidget.connection,
                                          Expanded(
                                            flex: 0,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: cr24),
                                                margin: l15r15t10b10,
                                                padding: all20,
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child:
                                                            OnlineExamWidget()),
                                                    w16,
                                                    Column(
                                                      children: [
                                                        GivenAnswerWidget(),
                                                        h14,
                                                        Padding(
                                                          padding: r10,
                                                          child: LargeButton(
                                                            width: Responsive
                                                                    .isMobile(
                                                                        context)
                                                                ? Get.width
                                                                : 240,
                                                            onPressed: () {
                                                              asn.resultChecker(
                                                                  true,
                                                                  context);
                                                            },
                                                            textColor: AppColors
                                                                .primaryColor,
                                                            color: AppColors
                                                                .primary,
                                                            child: Text(
                                                              'Submit'.tr,
                                                              style: FontStyleUtilities.h6(
                                                                  height: 0,
                                                                  fontWeight: FWT
                                                                      .medium,
                                                                  fontColor:
                                                                      AppColors
                                                                          .white),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
