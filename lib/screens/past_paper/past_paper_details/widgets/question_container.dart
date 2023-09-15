import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/screens/past_paper/past_paper_details/widgets/option_item.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';

class QuestionContainer extends StatelessWidget {
  const QuestionContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PastPaperProvider>(
        builder: (context, value, child) => Expanded(
              child: Container(
                height: Get.height,
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.borderColor),
                  color: AppColors.white,
                  borderRadius: cr12,
                ),
                child: Padding(
                  padding: hz20,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      h10,
                      Center(
                        child: Text("section_a".tr,
                            style: FontStyleUtilities.h4(
                                fontWeight: FWT.bold,
                                fontColor: AppColors.black)),
                      ),
                      Divider(thickness: 1, height: 20),
                      // Text(
                      //     "${value.pastPaperDetailModel?.data?.questionData?.length.toString()}"),
                      (value.pastPaperDetailModel != null &&
                              value.pastPaperDetailModel!.data != null &&
                              value.pastPaperDetailModel!.data!.questionData !=
                                  null)
                          ? ListView.builder(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: value.pastPaperDetailModel?.data
                                  ?.questionData?.length,
                              itemBuilder: (context, questionIndex) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FutureBuilder(
                                      future: Translator().translate(
                                          "${questionIndex + 1}. ${value.pastPaperDetailModel?.data?.questionData?[questionIndex].question}"),
                                      builder: (context, snapshot) {
                                        return Text(
                                          snapshot.hasData
                                              ? "${snapshot.data}"
                                              : "${questionIndex + 1}. ${value.pastPaperDetailModel?.data?.questionData?[questionIndex].question}",
                                          style: FontStyleUtilities.h5(
                                              fontWeight: FWT.medium,
                                              fontColor: AppColors.black),
                                        );
                                      }),
                                  h10,
                                  Container(
                                    width: Get.width,
                                    child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: value
                                            .pastPaperDetailModel
                                            ?.data
                                            ?.questionData?[questionIndex]
                                            .option
                                            ?.length,
                                        itemBuilder: (context, index) {
                                          return value
                                                  .pastPaperDetailModel!
                                                  .data!
                                                  .questionData![questionIndex]
                                                  .option![index]
                                                  .isNotEmpty
                                              ? OptionItem(
                                                  index: index,
                                                  questionIndex: questionIndex,
                                                )
                                              : SizedBox.shrink();
                                        }),
                                  ),
                                  Divider(thickness: 1, height: 20),
                                ],
                              ),
                            )
                          : Center(
                              child: Text('No questions Found'),
                            )
                    ],
                  ),
                ),
              ),
            ));
  }
}
