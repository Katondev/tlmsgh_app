import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/practice/assignment/controller/assignment_controller.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';

class AssignmentQuestionList extends StatelessWidget {
  final List<String> optionList;
  final String answer;
  final int questionIndex;

  const AssignmentQuestionList({
    Key? key,
    required this.optionList,
    required this.answer,
    required this.questionIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentController>(builder: (context, asn, child) {
      return Expanded(
        child: ListView.builder(
          itemCount: optionList.length,
          itemBuilder: (context, index) {
            return optionList[index].isEmpty
                ? SizedBox.shrink()
                : InkWell(
                    onTap: () {
                      asn.answerChecker(
                          ans: optionList[index],
                          correctAnswer: answer,
                          index: index,
                          option: optionList,
                          question: questionIndex);
                      asn.answerList[questionIndex] = {
                        "index": questionIndex,
                        "isAnswered": true,
                        "answer": optionList[index],
                        "answerIndex": index
                      };
                      asn.getUnansweredCount();
                    },
                    child: Container(
                      alignment: Alignment.centerLeft,
                      height: 40,
                      width: Get.width,
                      padding: l10,
                      margin: b10,
                      decoration: BoxDecoration(
                          color: asn.answerList[questionIndex]["isAnswered"] &&
                                  index ==
                                      asn.answerList[questionIndex]
                                          ["answerIndex"]
                              ? AppColors.primary
                              : AppColors.lightPurple1,
                          borderRadius: cr16,
                          border: Border.all(
                              color: AppColors.borderColor, width: 1)),
                      child: Text(optionList[index],
                          style: FontStyleUtilities.t2(
                            fontWeight: FWT.bold,
                            fontColor: asn.answerList[questionIndex]
                                        ["isAnswered"] &&
                                    index ==
                                        asn.answerList[questionIndex]
                                            ["answerIndex"]
                                ? AppColors.primaryWhite
                                : AppColors.primaryColor,
                          )),
                    ),
                  );
          },
        ),
      );
    });
  }
}
