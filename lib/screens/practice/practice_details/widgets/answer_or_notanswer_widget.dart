import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/practice/assignment/controller/assignment_controller.dart';
import 'package:katon/screens/practice/practice_details/controller/mcq_test_prv.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class AnswerOrNotAnswerWidget extends StatelessWidget {
  const AnswerOrNotAnswerWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentController>(builder: (context, asn, child) {
      return Container(
        // height: Responsive.isMobile(context) ? 190 : 225,
        //width: 200,
        decoration: Responsive.isMobile(context)
            ? BoxDecoration()
            : BoxDecoration(
                color: AppColors.white,
                border: Border.all(width: 1, color: AppColors.borderColor),
                borderRadius: cr10,
                boxShadow: [
                    BoxShadow(
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: Offset(0, 0),
                        color: Colors.blueGrey.withOpacity(0.2))
                  ]),
        padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            h10,
            Row(
              children: [
                Row(
                  children: [
                    Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: AppColors.gray300, borderRadius: cr6)),
                    w10,
                    Text(
                      "Attemted  ${asn.answerCounter}",
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: AppColors.primaryColor),
                    ),
                  ],
                ),
                w10,
                Row(
                  children: [
                    Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                            color: AppColors.primary, borderRadius: cr6)),
                    w10,
                    Text(
                      "Not Attemted  ${asn.unAnswerCounter}",
                      style: FontStyleUtilities.h6(
                          fontWeight: FWT.medium,
                          fontColor: AppColors.primaryColor),
                    ),
                  ],
                ),
              ],
            ),
            h10,
            Responsive.isMobile(context)
                ? SizedBox()
                : Text(
                    "Section",
                    style: FontStyleUtilities.h6(
                        fontWeight: FWT.bold, fontColor: AppColors.black),
                  ),
            Wrap(
                children: List.generate(
                    asn.questionDetail.data!.questionData!.length,
                    (index) => InkWell(
                          onTap: () => asn.onPageChange(index),
                          child: Container(
                            width: 40,
                            height: 40,
                            margin: EdgeInsets.all(5),
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: asn.answerList[index]["isAnswered"]
                                  ? AppColors.gray300
                                  : AppColors.primary,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Text(
                              "${index + 1}",
                              style: FontStyleUtilities.h6(
                                  fontWeight: FWT.bold,
                                  fontColor: AppColors.white),
                            ),
                          ),
                        ))),
            SizedBox(
              height: Responsive.isMobile(context) ? 0 : 10,
            ),
          ],
        ),
      );
    });
  }
}

class CommonTimer {
  static Consumer commonTimer = Consumer<McqTestPrv>(
    builder: (context, value, child) => Container(
      height: 56,
      width: 260,
      decoration: BoxDecoration(
        borderRadius: cr12,
        color: AppColors.primary,
      ),
      child: Center(
        child: Text(
          '${value.timerText}'.tr,
          style: FontStyleUtilities.h6(
              fontWeight: FWT.medium, fontColor: AppColors.white),
        ),
      ),
    ),
  );
}
