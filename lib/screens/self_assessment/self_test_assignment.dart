import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/assignment_model.dart';
import 'package:katon/screens/practice/assignment/controller/assignment_controller.dart';
import 'package:katon/screens/practice/assignment/model/AssignmentQSetMoel.dart';
import 'package:katon/screens/practice/assignment/widget/assignemnt_appbar.dart';
import 'package:katon/screens/practice/assignment/widget/assignment_page_container.dart';
import 'package:katon/screens/practice/practice_details/widgets/answer_or_notanswer_widget.dart';
import 'package:katon/screens/self_assessment/model/self_assessment_que_model.dart';
import 'package:katon/screens/self_assessment/self_assesment_controller.dart';
import 'package:katon/screens/self_assessment/widget/self_answer_or_notanswer_widget.dart';
import 'package:katon/screens/self_assessment/widget/self_assignemnt_appbar.dart';
import 'package:katon/screens/self_assessment/widget/self_assignment_page_container.dart';
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

class SelfTestAssignment extends StatefulWidget {
  final SelfAssessment questionData;

  const SelfTestAssignment({super.key, required this.questionData});

  @override
  _SelfTestAssignmentState createState() => new _SelfTestAssignmentState();
}

class _SelfTestAssignmentState extends State<SelfTestAssignment> {
  SelfAssessmentController? selfAssessmentController;
  AssignmentQSetModel? questionDetail;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    selfAssessmentController =
        Provider.of<SelfAssessmentController>(context, listen: false);
    selfAssessmentController!.answerSubmitServer.clear();
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Consumer<SelfAssessmentController>(builder: (context, asn, child) {
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
            appBar: Responsive.isMobile(context)
                ? SelfAssignmentAppBar(
                    assignmentTitle: widget.questionData.saTitle!,
                    count: asn.timerText,
                    isTimer: asn.timer != null ? true : false,
                    assignmentTotalMark: widget.questionData.saTotalMarks!,
                    assignmentDuration: widget.questionData.saDuration!,
                    context: context,
                    callback: () {
                      asn.resultChecker(true);
                    })
                : SelfAssignmentAppBar(
                    assignmentTitle: widget.questionData.saTitle!,
                    count: asn.timerText,
                    isTimer: asn.timer != null ? true : false,
                    assignmentTotalMark: widget.questionData.saTotalMarks!,
                    context: context,
                    callback: () {
                      asn.resultChecker(true);
                    },
                    assignmentDuration: widget.questionData.saDuration!,
                  ),
            body: SafeArea(
              child: Column(
                children: [
                  if (Responsive.isMobile(context))
                    asn.timer != null
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 4.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Total Marks: ${widget.questionData.saTotalMarks!}",
                                    style: FontStyleUtilities.t2(
                                        fontColor: AppColors.primary,
                                        fontWeight: FWT.semiBold),
                                  ),
                                ),
                                Text(
                                  "${asn.timerText}/${widget.questionData.saDuration!}",
                                  style: FontStyleUtilities.t2(
                                      fontColor: AppColors.blackType,
                                      fontWeight: FWT.semiBold),
                                ),
                              ],
                            ),
                          )
                        : Container(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 20,
                      ),
                      child: asn.value1
                          ? Loader(message: "loading_wait".tr)
                          : asn.connection
                              ? NoInternet(
                                  onTap: () => asn.getAllSelfAssessment(
                                      widget.questionData.saId!))
                              : asn.selfAssessMentQueModel!.data == null ||
                                      asn.selfAssessMentQueModel!.data!
                                              .questionData?.length ==
                                          0
                                  ? NoDataFound(message: "no_record".tr)
                                  : Container(
                                      margin: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal:
                                              Responsive.isMobile(context)
                                                  ? 1
                                                  : 15),
                                      padding: v10,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ConnectionWidget.connection,
                                          Expanded(
                                            flex: Responsive.isMobile(context)
                                                ? 2
                                                : 0,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    color: AppColors.white,
                                                    borderRadius: cr24),
                                                margin: l15r15t10b10,
                                                padding:
                                                    Responsive.isMobile(context)
                                                        ? all0
                                                        : all20,
                                                child: Responsive.isMobile(
                                                        context)
                                                    ? SelfAssignmentPageContainer()
                                                    : Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  SelfAssignmentPageContainer()),
                                                          w16,
                                                          Column(
                                                            children: [
                                                              Padding(
                                                                padding: r10,
                                                                child:
                                                                    LargeButton(
                                                                  width: Responsive
                                                                          .isMobile(
                                                                              context)
                                                                      ? Get
                                                                          .width
                                                                      : 240,
                                                                  onPressed:
                                                                      () {},
                                                                  textColor:
                                                                      AppColors
                                                                          .primaryColor,
                                                                  color: AppColors
                                                                      .primary,
                                                                  child: Text(
                                                                    'Submit'.tr,
                                                                    style: FontStyleUtilities.h6(
                                                                        height:
                                                                            0,
                                                                        fontWeight: FWT
                                                                            .medium,
                                                                        fontColor:
                                                                            AppColors.white),
                                                                  ),
                                                                ),
                                                              ),
                                                              h14,
                                                              SelfAnswerOrNotAnswerWidget(),
                                                            ],
                                                          ),
                                                        ],
                                                      )),
                                          ),
                                          Responsive.isMobile(context)
                                              ? Expanded(
                                                  child: Container(
                                                      decoration: BoxDecoration(
                                                          color:
                                                              AppColors.white,
                                                          borderRadius: cr24),
                                                      margin: l15r15t10b10,
                                                      padding:
                                                          Responsive.isMobile(
                                                                  context)
                                                              ? all0
                                                              : all20,
                                                      child: Card(
                                                          elevation: 1,
                                                          child: SingleChildScrollView(
                                                              child:
                                                                  SelfAnswerOrNotAnswerWidget()))))
                                              : Container()
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
