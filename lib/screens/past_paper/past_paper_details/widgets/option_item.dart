import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';

class OptionItem extends StatelessWidget {
  final int index;
  final int questionIndex;

  OptionItem({Key? key, required this.index, required this.questionIndex})
      : super(key: key);

  final List alphabetList = ["a", "B", "C", "d", "E"];

  @override
  Widget build(BuildContext context) {
    return Consumer<PastPaperProvider>(
        builder: (context, value, child) =>
        Padding(
          padding: v5,
          child:
          Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    border:
                    Border.all(color: Colors.blueGrey.withOpacity(0.5)),
                    shape: BoxShape.circle),
                child: Center(
                  child: Text(
                      "${value.alphabetList[index == 0 ? 4 : index]}".tr),
                )),
            w10,
            FutureBuilder(
                future: Translator().translate(
                    "${value.pastPaperDetailModel?.data
                        ?.questionData?[questionIndex].option?[index]}"),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData
                        ? "${snapshot.data}"
                        : "${value.pastPaperDetailModel?.data
                        ?.questionData?[questionIndex].option?[index]}",
                    style:
                    FontStyleUtilities.t1(fontColor: AppColors.black),
                  );
                }),
          ]),
        ));
  }
}
