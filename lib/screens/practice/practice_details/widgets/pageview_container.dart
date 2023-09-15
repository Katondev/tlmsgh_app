import 'package:flutter/material.dart';
import 'package:katon/screens/practice/practice_details/controller/mcq_test_prv.dart';
import 'package:katon/screens/practice/practice_details/widgets/answer_or_notanswer_widget.dart';
import 'package:katon/screens/practice/practice_details/widgets/previous_and_next_button.dart';
import 'package:katon/screens/practice/practice_details/widgets/question_list.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class PageViewContainer extends StatelessWidget {
  const PageViewContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<McqTestPrv>(
      builder: (context, value, child) => Container(
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
            Responsive.isMobile(context)
                ? Padding(
                    padding: h10v5,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Total marks: 3",
                          style: FontStyleUtilities.h5(
                              fontWeight: FWT.bold,
                              height: 0,
                              fontColor: AppColors.primary),
                        ),
                        Text(
                          value.timerText,
                          style: FontStyleUtilities.h5(
                              fontWeight: FWT.bold,
                              height: 0,
                              fontColor: AppColors.primary),
                        )
                      ],
                    ),
                  )
                : SizedBox(),
            Expanded(
              child: PageView.builder(
                controller: value.controller,
                itemCount: 10,
                onPageChanged: (index) {
                  value.onPageChange(index);
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
                          "Questions ${index + 1}",
                          style: Responsive.isMobile(context)
                              ? FontStyleUtilities.h5(
                                  fontWeight: FWT.bold,
                                  fontColor: AppColors.primaryColor)
                              : FontStyleUtilities.h4(
                                  fontWeight: FWT.bold,
                                  fontColor: AppColors.primaryColor),
                        ),
                        h10,
                        QuestionList()
                      ],
                    ),
                  );
                },
              ),
            ),
            PreviousAndNextButton(),
            Responsive.isMobile(context)
                ? AnswerOrNotAnswerWidget()
                : SizedBox(),
          ],
        ),
      ),
    );
  }
}
