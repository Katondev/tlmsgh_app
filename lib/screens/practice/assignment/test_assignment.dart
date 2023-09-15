import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/assignment_model.dart';
import 'package:katon/screens/practice/assignment/controller/assignment_controller.dart';
import 'package:katon/screens/practice/assignment/model/AssignmentQSetMoel.dart';
import 'package:katon/screens/practice/assignment/widget/assignemnt_appbar.dart';
import 'package:katon/screens/practice/assignment/widget/assignment_page_container.dart';
import 'package:katon/screens/practice/practice_details/widgets/answer_or_notanswer_widget.dart';
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

class TestAssignment extends StatefulWidget {
  final Assignment assignment;

  const TestAssignment({super.key, required this.assignment});

  @override
  _TestAssignmentState createState() => new _TestAssignmentState();
}

class _TestAssignmentState extends State<TestAssignment> {
  AssignmentController? assignmentController;
  AssignmentQSetModel? questionDetail;
  final cnt = Get.put(AppBarCnt());
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      assignmentController =
          Provider.of<AssignmentController>(context, listen: false);
      getData();
    });
  }

  getData() async {
    assignmentController!.index = 0;
    assignmentController!.answerSubmitServer.clear();
    await assignmentController!.init(widget.assignment.asnId!);
  }

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Consumer<AssignmentController>(builder: (contexts, asn, child) {
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
                ? AssignmentAppBar(
                    assignmentTitle: widget.assignment.asnTitle ?? "",
                    count: asn.timerText,
                    assignmentTotalMark: widget.assignment.asnTotalMarks!,
                    assignmentDuration:
                        int.parse(widget.assignment.asnDuration!),
                    context: context,
                    isTimer: asn.timer != null ? true : false,
                    callback: () {
                      asn.resultChecker(true);
                    })
                : AssignmentAppBar(
                    assignmentTitle: widget.assignment.asnTitle ?? "",
                    count: asn.timerText,
                    isTimer: asn.timer != null ? true : false,
                    assignmentTotalMark: widget.assignment.asnTotalMarks!,
                    context: context,
                    callback: () {
                      Get.back();
                    },
                    assignmentDuration:
                        int.parse(widget.assignment.asnDuration!),
                  ),
            body: SafeArea(
              child: Column(
                children: [
                  if (Responsive.isMobile(context))
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 4.0),
                      child: asn.timer != null
                          ? Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Total Marks: ${widget.assignment.asnTotalMarks!}",
                                    style: FontStyleUtilities.t2(
                                        fontColor: AppColors.primary,
                                        fontWeight: FWT.semiBold),
                                  ),
                                ),
                                Text(
                                  "${asn.timerText}/${int.parse(widget.assignment.asnDuration!)}",
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
                              ? NoInternet(
                                  onTap: () => asn.getAssignmentQSetDetails(
                                      widget.assignment.asnId!))
                              : asn.questionDetail.data == null ||
                                      asn.questionDetail.data!.questionData
                                              ?.length ==
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
                                                    ? AssignmentPageContainer()
                                                    : Row(
                                                        children: [
                                                          Expanded(
                                                              child:
                                                                  AssignmentPageContainer()),
                                                          w16,
                                                          Column(
                                                            children: [
                                                              Padding(
                                                                padding: r10,
                                                                child:
                                                                    LargeButton(
                                                                  height: 44,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  width: Responsive
                                                                          .isMobile(
                                                                              context)
                                                                      ? Get
                                                                          .width
                                                                      : 240,
                                                                  onPressed:
                                                                      () {
                                                                    asn.resultChecker(
                                                                        true);
                                                                  },
                                                                  textColor:
                                                                      AppColors
                                                                          .primaryColor,
                                                                  color: AppColors
                                                                      .primaryYellow,
                                                                  child: Text(
                                                                    'Submit'.tr,
                                                                    style: AppTextStyle
                                                                        .normalBold14,
                                                                  ),
                                                                ),
                                                              ),
                                                              h14,
                                                              AnswerOrNotAnswerWidget(),
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
                                                          child:
                                                              AnswerOrNotAnswerWidget())))
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
