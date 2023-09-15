import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';

class QuestionList extends StatelessWidget {
  const QuestionList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.centerLeft,
            height: 50,
            width: Get.width,
            padding: l10,
            margin: b10,
            decoration: BoxDecoration(
                color: AppColors.lightPurple1,
                borderRadius: cr16,
                border: Border.all(color: AppColors.borderColor, width: 1)),
            child: Text("${"$index"}",
                style: FontStyleUtilities.h4(
                    fontWeight: FWT.bold, fontColor: AppColors.primaryColor)),
          );
        },
      ),
    );
  }
}
