import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/elearning_model/category_model.dart';
import 'package:katon/models/elearning_model/sub_category_model.dart';
import 'package:katon/models/sign_in_model.dart';
import 'package:katon/models/snackbar_datamodel.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/screens/self_assessment/self_assesment_controller.dart';
import 'package:katon/services/snackbar_service.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/dropdown.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

import '../../components/app_text_style.dart';
import '../../models/filter_category_model/filter_category_model.dart';

class GeneratePaper extends StatefulWidget {
  const GeneratePaper({Key? key}) : super(key: key);

  @override
  State<GeneratePaper> createState() => _GeneratePaperState();
}

class _GeneratePaperState extends State<GeneratePaper> {
  SelfAssessmentController? eLearningPrv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    eLearningPrv =
        Provider.of<SelfAssessmentController>(context, listen: false);
    init();
  }

  void init() async {
    await eLearningPrv?.getAllCategoryInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryWhite,
      child: SafeArea(
        child: Scaffold(
          // appBar: CommonAppbarMobile(title: 'self_assessment'.tr),
          body: Consumer<SelfAssessmentController>(
            builder: (cnt, ePrv, child) {
              return Container(
                // padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                width: context.width,
                child: ListView(
                  // shrinkWrap: true,
                  // scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CommonAppBar2(
                          title: 'self_assessment'.tr, isshowback: true),
                    ),
                    h10,
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          DropDownCustom<FilterCategoryModel>(
                            onChange: (value) =>
                                ePrv.selectMainCategory(value: value),
                            selectedValue:
                                ePrv.selectedMainCat.value.categoryId == null
                                    ? null
                                    : ePrv.selectedMainCat,
                            items: ePrv.mainCategoryMList
                                .map((e) =>
                                    DropdownMenuItem<FilterCategoryModel>(
                                        enabled: e.isenabled ?? true,
                                        value: e,
                                        child: Text(
                                          "${e.isenabled ?? false ? e.categoryName : e.maincategoryName}",
                                          style: e.isenabled ?? false
                                              ? AppTextStyle.normalRegular12
                                              : AppTextStyle.normalRegular12
                                                  .copyWith(
                                                      color: Colors.black54),
                                        )))
                                .toList(),
                            hint: Text(
                              "Select Class",
                              style: AppTextStyle.normalRegular12,
                            ),
                          ),
                          // h10,
                          // DropDownCustom<Topic>(
                          //   onChange: (value) => ePrv.selectedTopic(value!),
                          //   selectedValue: ePrv.topic!.obs,
                          //   items: ePrv.topicFilt
                          //       .map(
                          //         (e) => DropdownMenuItem<Topic>(
                          //           value: e,
                          //           child: FutureBuilder(
                          //             future:
                          //                 Translator().translate("${e.topicName}"),
                          //             builder: (context, snapshot) => Text(
                          //               snapshot.hasData
                          //                   ? "${snapshot.data}"
                          //                   : "${e.topicName}",
                          //               style: AppTextStyle.normalRegular12,
                          //             ),
                          //           ),
                          //         ),
                          //       )
                          //       .toList(),
                          // ),
                          h10,
                          DropDownCustom<Subject>(
                            onChange: (value) =>
                                ePrv.selectSubject(value: value),
                            selectedValue:
                                ePrv.selectedSubject.value.label == null
                                    ? null
                                    : ePrv.selectedSubject,
                            items: ePrv.subjectList
                                .map((e) => DropdownMenuItem<Subject>(
                                    value: e,
                                    child: Text("${e.label}",
                                        style: AppTextStyle.normalRegular12)))
                                .toList(),
                            hint: Text(
                              "Select Subject",
                              style: AppTextStyle.normalRegular12,
                            ),
                          ),
                          h30,
                          ePrv.value
                              ? Loader(
                                  message: "loading_wait".tr,
                                )
                              : LargeButton(
                                  height: 48,
                                  onPressed: () {
                                    if (ePrv.selectedMainCat.value
                                            .categoryName ==
                                        "Class/Grade") {
                                      SnackBarService().showSnackBar(
                                          message: "Select Class/Grade",
                                          type: SnackBarType.error);
                                    } else if (ePrv.selectedSubject.value ==
                                        "Select Subject") {
                                      SnackBarService().showSnackBar(
                                          message: "Select Subject",
                                          type: SnackBarType.error);
                                    } else {
                                      //Navigator.of(context).pop();
                                      ePrv
                                          .generatePaperApi(context)
                                          .whenComplete(() {
                                        Navigator.of(context).pop();
                                      });
                                    }
                                  },
                                  child: Text(
                                    "generate_paper".tr,
                                    style:
                                        AppTextStyle.normalSemiBold14.copyWith(
                                      color: AppColors.primaryWhite,
                                    ),
                                  ),
                                )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
