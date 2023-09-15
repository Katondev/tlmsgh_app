import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

import 'exam_prev_next_button.dart';
import 'exam_question_list.dart';

class OnlineExamWidget extends StatelessWidget {
  OnlineExamWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingProvider>(builder: (context, asn, child) {
      return Container(
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: cr10,
            boxShadow: [
              BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                  color: Colors.blueGrey.withOpacity(0.3))
            ]),
        child: Container(
          height: Get.height / 2,
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    controller: asn.controller,
                    itemCount: asn.questionModel!.data!.questionData!.length,
                    onPageChanged: (index) {
                      asn.onPageChange(index);
                    },
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: hz10,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Responsive.isMobile(context) ? 0 : 20,
                            ),
                            Text(
                              asn.questionModel!.data!.questionData![index]
                                  .question!,
                              style: Responsive.isMobile(context)
                                  ? FontStyleUtilities.h5(
                                      fontWeight: FWT.bold,
                                      fontColor: AppColors.primaryColor)
                                  : FontStyleUtilities.h4(
                                      fontWeight: FWT.bold,
                                      fontColor: AppColors.primaryColor),
                            ),
                            h10,
                            ExamQuestionList(
                              optionList: asn.questionModel!.data!
                                  .questionData![index].option!,
                              answer: asn.questionModel!.data!
                                  .questionData![index].answer!,
                              questionIndex: index,
                            )
                          ],
                        ),
                      );
                    }),
              ),
              if (Responsive.isMobile(context)) h4,
              ExamPreviousNextButton(),
              if (Responsive.isMobile(context)) h4,
            ],
          ),
        ),
      );
    });
  }
}
