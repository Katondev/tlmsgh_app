// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/library_page/widget/expansion_widget.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';
import '../../../models/filter_category_model/filter_category_model.dart';
import '../../../models/snackbar_datamodel.dart';
import '../../../services/snackbar_service.dart';
import '../../../widgets/button.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/dropdown.dart';
import '../../../widgets/loader.dart';
import '../../home_page.dart';
import '../../self_assessment/self_assesment_controller.dart';
import '../controller/practice_prv.dart';

class PracticeSubjectPageTablet extends StatefulWidget {
  final Arguments arguments;

  const PracticeSubjectPageTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeSubjectPageTablet> createState() =>
      _PracticeSubjectPageTabletState();
}

class _PracticeSubjectPageTabletState extends State<PracticeSubjectPageTablet> {
   SelfAssessmentController? ePev;
  @override
 
  @override
  Widget build(BuildContext context) {
   
    var args = ModalRoute.of(context)!.settings.arguments;
     if( args.toString() == "Self Assessment"){
      
    }
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Consumer<PracticePrv>(
          builder: (context, ePrv, child) {
            final self = Provider.of<SelfAssessmentController>(context);
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              // endDrawer: endDrawer(),
              body: Container(
                padding: const EdgeInsets.fromLTRB(35, 30, 35, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                       
                        CommonAppBar2(
                            isshowback: true,
                            title: args.toString(),
                            description: widget.arguments.description),
                                args.toString() == "Self Assessment"? Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       SizedBox(
                        width: 150  ,
                         child: DropDownCustom<Class>(
                              onChange: (value) =>
                                  self.selectSubject1(value: value),
                              selectedValue:
                                  self.classSelect.value.classClass == null
                                      ? null
                                      : self.classSelect,
                              items: self.classGrade
                                  .map((e) => DropdownMenuItem<Class>(
                                      value: e,
                                      child: Text("${e.classClass}",
                                          style: AppTextStyle.normalRegular12)))
                                  .toList(),
                              hint: Text(
                                "class",
                                style: AppTextStyle.normalRegular12,
                              ),
                            ),
                       ),
                          w10,
                           SizedBox(
                            width: 150  ,
                             child: DropDownCustom<Subjectt>(
                              
                              onChange: (value) =>
                                  self.selctTopic(value: value),
                              selectedValue:
                                  self.selectTopic.value.subject == null
                                      ? null
                                      : self.selectTopic,
                              items: self.subjects
                                  .map((e) => DropdownMenuItem<Subjectt>(
                                      value: e,
                                      child: Text("${e.subject ?? "SE"}",
                                          style: AppTextStyle.normalRegular12)))
                                  .toList(),
                              hint: Text(
                                " Subject",
                                style: AppTextStyle.normalRegular12,
                              ),
                                                     ),
                           ),
                            w10,
                           SizedBox(
                          width: 150  ,
                             child: DropDownCustom<SubjectTopic>(
                              onChange: (value) =>
                                  self.selctTopics(value: value),
                              selectedValue:
                                  self.selecttopics.value.topic == null
                                      ? null
                                      : self.selecttopics,
                              items: self.topics
                                  .map((e) => DropdownMenuItem<SubjectTopic>(
                                      value: e,
                                      child: Text("${e.topic}",
                                          style: AppTextStyle.normalRegular12)))
                                  .toList(),
                              hint: Text(
                                "Topics",
                                style: AppTextStyle.normalRegular12,
                              ),
                                                     ),
                           ),
                      w10,
                      // SizedBox(
                      //   width: 200,
                      //   child: DropDownCustom<Subject>(
                      //     onChange: (value) => ePrv.selectSubject(value: value),
                      //     selectedValue:
                      //         ePrv.selectedSubject.value.label == null
                      //             ? null
                      //             : ePrv.selectedSubject,
                      //     items: ePrv.subjectList
                      //         .map((e) => DropdownMenuItem<Subject>(
                      //             value: e,
                      //             child: Text("${e.label}",
                      //                 style: AppTextStyle.normalRegular12)))
                      //         .toList(),
                      //     hint: Text(
                      //       "Select Subject",
                      //       style: AppTextStyle.normalRegular12,
                      //     ),
                      //   ),
                      // ),
                      w10,
                      LargeButton(
                        height: 40,
                        width: 100,
                        borderRadius: BorderRadius.circular(0),
                        onPressed: () {
                          if (self.selectedMainCat.value.categoryName ==
                              "Class/Grade") {
                            SnackBarService().showSnackBar(
                                message: "Select Class/Grade",
                                type: SnackBarType.error);
                          } else if (self.selectedSubject.value ==
                              "Select Subject") {
                            SnackBarService().showSnackBar(
                                message: "Select Subject",
                                type: SnackBarType.error);
                          } else {
                            self.generatePaperApi(context);
                          }
                        },
                        child: Text("Generate"),
                      ),
                    ],
                  ):SizedBox(width: MediaQuery.of(context).size.width /5,)
                      ],
                    ),
                    customHeight(15),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.boxgreyColor,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.fromLTRB(60, 48, 60, 26),
                        child: ePrv.value
                            ? Loader(message: "loading_wait".tr)
                            : ePrv.connection
                                ? NoInternet(
                                    onTap: () {},
                                    // onTap: () => ePrv.resetOnTap(),
                                  )
                                : (ePrv.practiceSubjectList.isEmpty)
                                    ? NoDataFound(message: "no_book_found".tr)
                                    : SingleChildScrollView(
                                        physics: const BouncingScrollPhysics(),
                                        child: Column(
                                          children: [
                                            ...List.generate(
                                                ePrv.practiceSubjectList.length,
                                                (index) {
                                              var data = ePrv
                                                  .practiceSubjectList[index];
                                                  
                                              return Column(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      ePrv.SelectedIndex =
                                                          index;
                                                          ePrv.subCategoryName =
                                                        ePrv.practiceSubjectList[
                                                            index];
                                                    self.selfAssessmntcat =
                                                        ePrv.practiceSubjectList[
                                                            index]; 
                                                      ePrv.notifyListeners();
                                                      if (AppPreference()
                                                              .getString(
                                                                  PreferencesKey
                                                                      .uType) ==
                                                          "Student") {
                                                        if (ePrv.selectedPractice ==
                                                            0) {
                                                          navigatorKey
                                                              .currentState
                                                              ?.pushNamed(
                                                            RoutesConst
                                                                .practiceAssignment,
                                                            arguments: data,
                                                          );
                                                        } else if (ePrv
                                                                .selectedPractice ==
                                                            1) {
                                                          navigatorKey
                                                              .currentState
                                                              ?.pushNamed(
                                                            RoutesConst
                                                                .pastQuestions,
                                                            arguments: data,
                                                          );
                                                        } else if (ePrv
                                                                .selectedPractice ==
                                                            2) {
                                                          navigatorKey
                                                              .currentState
                                                              ?.pushNamed(
                                                            RoutesConst
                                                                .selfAssessment,
                                                            arguments: data,
                                                          );
                                                        }
                                                      } else if (AppPreference()
                                                              .getString(
                                                                  PreferencesKey
                                                                      .uType) ==
                                                          "Teacher") {
                                                        if (ePrv.selectedPractice ==
                                                            0) {
                                                              navigatorKey
                                                              .currentState
                                                              ?.pushNamed(
                                                            RoutesConst
                                                                .practiceAssignment,
                                                            arguments: data,
                                                          );
                                                        } else if (ePrv
                                                                .selectedPractice ==
                                                            1) {
                                                              navigatorKey
                                                              .currentState
                                                              ?.pushNamed(
                                                            RoutesConst
                                                                .pastQuestions,
                                                            arguments: data,
                                                          );
                                                            }
                                                      }
                                                    },
                                                    child: ExpansionWidget(
                                                      title: data,
                                                      margin: EdgeInsets.only(
                                                          bottom: 20),
                                                      borderColor: AppColors
                                                          .transparentColor,
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ],
                                        ),
                                      ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
