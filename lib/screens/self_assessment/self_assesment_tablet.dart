import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/self_assessment/self_assesment_controller.dart';
import 'package:katon/screens/self_assessment/self_assesment_item.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';

import '../../components/app_text_style.dart';
import '../../models/filter_category_model/filter_category_model.dart';
import '../../models/sign_in_model.dart';
import '../../models/snackbar_datamodel.dart';
import '../../services/snackbar_service.dart';
import '../../utils/api_translator.dart';
import '../../utils/constants.dart';
import '../../widgets/dropdown.dart';

class SelfAssessmentTablet extends StatefulWidget {
  final Arguments arguments;

  const SelfAssessmentTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<SelfAssessmentTablet> createState() => _SelfAssessmentTabletState();
}

class _SelfAssessmentTabletState extends State<SelfAssessmentTablet> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          // backgroundColor: AppColors.primaryWhite,

          // appBar: CommonAppbarMobile(title: arguments?.title ?? ""),

          drawer: AppPreference().isTeacherLogin
              ? TeacherDrawerBox(navKey: navigatorKey)
              : DrawerBox(navKey: navigatorKey),

          body: Consumer<SelfAssessmentController>(
            builder: (context, ePrv, child) => Padding(
              padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
              child: Column(
                children: [
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonAppBar2(
                        isshowback: true,
                        title: widget.arguments.title.toString(),
                        description: "${args.toString()} Language",
                      ),
                      Spacer(),
                      SizedBox(
                        width: 200,
                        child: DropDownCustom<FilterCategoryModel>(
                          onChange: (value) =>
                              ePrv.selectMainCategory(value: value),
                          //  ePrv.mainCategoryMList.any((r) => r.categoryId==ePrv.selectedMainCat?.value.categoryId)?
                          selectedValue:
                              ePrv.selectedMainCat.value.categoryId == null
                                  ? null
                                  : ePrv.selectedMainCat,
                          items: ePrv.mainCategoryMList
                              .map((e) => DropdownMenuItem<FilterCategoryModel>(
                                  enabled: e.isenabled ?? true,
                                  value: e,
                                  child: Text(
                                    "${e.isenabled ?? false ? e.categoryName : e.maincategoryName}",
                                    style: e.isenabled ?? false
                                        ? AppTextStyle.normalRegular12
                                        : AppTextStyle.normalRegular12
                                            .copyWith(color: Colors.black54),
                                  )))
                              .toList(),
                          hint: Text(
                            "Class/Garde",
                            style: AppTextStyle.normalRegular12,
                          ),
                        ),
                      ),
                      w10,
                      SizedBox(
                        width: 200,
                        child: DropDownCustom<Subject>(
                          onChange: (value) => ePrv.selectSubject(value: value),
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
                      ),
                      w10,
                      LargeButton(
                        height: 40,
                        width: 100,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          if (ePrv.selectedMainCat.value.categoryName ==
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
                            ePrv.generatePaperApi(context);
                          }
                        },
                        child: Text("Generate Paper"),
                      ),
                    ],
                  ),
                  customHeight(15),
                  ConnectionWidget.connection,
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.boxgreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.fromLTRB(31, 42, 31, 38),
                      child: ePrv.value
                          ? Loader(
                              message: "loading_wait".tr,
                            )
                          : ePrv.connection
                              ? NoInternet(
                                  onTap: () => ePrv.getAllSelfAssessmentList(),
                                )
                              : ePrv.selfAssessmentList == null ||
                                      ePrv.selfAssessmentList!.data!
                                              .selfAssessment?.length ==
                                          0
                                  ? NoDataFound(message: "no_record".tr)
                                  : GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        // mainAxisExtent: 200,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 1.2,
                                      ),
                                      itemBuilder: (context, index) {
                                        var data = ePrv.selfAssessmentList!
                                            .data!.selfAssessment![index];
                                        return SelfAssessmentItem(
                                          selfassesment_item: ePrv
                                              .selfAssessmentList!
                                              .data!
                                              .selfAssessment![index],
                                        );
                                      },
                                      itemCount: ePrv.selfAssessmentList!.data!
                                          .selfAssessment!.length,
                                    ),
                      // ListView.builder(
                      //   physics: BouncingScrollPhysics(),
                      //   itemCount: ePrv.selfAssessmentList!.data!
                      //       .selfAssessment!.length,
                      //   itemBuilder: (context, index) =>
                      //     SelfAssessmentItem(
                      //   selfassesment_item: ePrv
                      //       .selfAssessmentList!
                      //       .data!
                      //       .selfAssessment![index],
                      // ),
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
