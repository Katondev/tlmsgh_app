import 'package:flutter/material.dart';
import 'package:katon/screens/practice/assignment/controller/assignment_controller.dart';
import 'package:katon/screens/practice/assignment/widget/assignment_previous_next_button.dart';
import 'package:katon/screens/practice/assignment/widget/assignment_question_list.dart';
import 'package:katon/screens/practice/practice_details/widgets/answer_or_notanswer_widget.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class AssignmentPageContainer extends StatelessWidget {
  AssignmentPageContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentController>(builder: (context, asn, child) {
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
        child: Column(
          children: [
            SizedBox(
              height: 400,
              child: PageView.builder(
                  controller: asn.controller,
                  itemCount: asn.questionDetail.data!.questionData!.length,
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
                            asn.questionDetail.data!.questionData![index]
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
                          AssignmentQuestionList(
                            optionList: asn.questionDetail.data!
                                .questionData![index].option!,
                            answer: asn.questionDetail.data!
                                .questionData![index].answer!,
                            questionIndex: index,
                          )
                        ],
                      ),
                    );
                  }),
            ),
            if (Responsive.isMobile(context)) h4,
            AssignmentPreviousNextButton(),
            if (Responsive.isMobile(context)) h4,
          ],
        ),
      );
    });
  }
}
