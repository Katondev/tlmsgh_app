import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/practice/assignment/widget/assignemnt_appbar.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/screens/training/online_exam/widgets/given_answer_widget.dart';
import 'package:katon/screens/training/online_exam/widgets/online_exam_widget.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';

class OnlineExamMobile extends StatefulWidget {
  const OnlineExamMobile({super.key});

  @override
  _OnlineExamMobileState createState() => new _OnlineExamMobileState();
}

class _OnlineExamMobileState extends State<OnlineExamMobile> {
  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Consumer<TrainingProvider>(builder: (context, asn, child) {
        return Scaffold(
          appBar: AssignmentAppBar(
              assignmentTitle: asn.questionModel!.data!.title ?? "",
              count: asn.timerText,
              assignmentTotalMark: asn.questionModel!.data!.totalMarks!,
              assignmentDuration: int.parse(asn.questionModel!.data!.duration!),
              context: context,
              isTimer: asn.timer != null ? true : false,
              callback: () {
                asn.resultChecker(true, context);
              }),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 4.0),
                  child: asn.timer != null
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                "Total Marks: ${asn.questionModel!.data!.totalMarks!}",
                                style: FontStyleUtilities.t2(
                                    fontColor: AppColors.primary,
                                    fontWeight: FWT.semiBold),
                              ),
                            ),
                            Text(
                              "${asn.timerText}/${int.parse(asn.questionModel!.data!.duration!)}",
                              style: FontStyleUtilities.t2(
                                  fontColor: AppColors.blackType,
                                  fontWeight: FWT.semiBold),
                            ),
                          ],
                        )
                      : Container(),
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
                                        vertical: 10, horizontal: 1),
                                    padding: v10,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ConnectionWidget.connection,
                                        Expanded(
                                          flex: 2,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius: cr24),
                                              margin: l15r15t10b10,
                                              padding: all0,
                                              child: OnlineExamWidget()),
                                        ),
                                        Expanded(
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: cr24),
                                                margin: l15r15t10b10,
                                                padding: all0,
                                                child: Card(
                                                    elevation: 1,
                                                    child:
                                                        GivenAnswerWidget())))
                                      ],
                                    ),
                                  ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
