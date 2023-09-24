// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/library_page/widget/expansion_widget.dart';
import 'package:katon/screens/practice/past_questions/past_questions_screen.dart';
import 'package:katon/screens/practice/self_assessment/self_assessment_screen.dart';
import 'package:katon/screens/self_assessment/self_assessment_paper.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';
import '../../../teacher/drawer.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/drawer/drawer.dart';
import '../../home_page.dart';
import '../../self_assessment/self_assesment_controller.dart';
import '../controller/practice_prv.dart';

class PracticeSubjectPagePhone extends StatefulWidget {
  final Arguments arguments;

  const PracticeSubjectPagePhone({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeSubjectPagePhone> createState() =>
      _PracticeSubjectPagePhoneState();
}

class _PracticeSubjectPagePhoneState extends State<PracticeSubjectPagePhone> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.boxgreyColor,
          resizeToAvoidBottomInset: false,
          drawer: AppPreference().isTeacherLogin
              ? TeacherDrawerBox(navKey: navigatorKey)
              : DrawerBox(navKey: navigatorKey),
              floatingActionButton:AppPreference().isTeacherLogin? null :FloatingActionButton(
            onPressed: () {
              Get.to(() => GeneratePaper());
            },
            backgroundColor: AppColors.primaryYellow,
            tooltip: 'Generate Paper',
            child: Icon(
              Icons.my_library_books_outlined,
              color: Colors.white,
            ),
          ),
          // endDrawer: endDrawer(),
          // appBar: CommonAppbarMobile(title: widget.arguments.title),
          body: Consumer<PracticePrv>(
            builder: (context, ePrv, child) {
               final self = Provider.of<SelfAssessmentController>(context);
              return Container(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonAppBar2(
                        isshowback: true,
                        title: args.toString(),
                        description: widget.arguments.description),
                    customHeight(15),
                    Expanded(
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
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        children: [
                                          ...List.generate(
                                              ePrv.practiceSubjectList.length,
                                              (index) {
                                            var data =
                                                ePrv.practiceSubjectList[index];
                                               ePrv.subCategoryName = data;
                                            return Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                     ePrv.subCategoryName =
                                                        ePrv.practiceSubjectList[
                                                            index];
                                                    self.selfAssessmntcat =
                                                        ePrv.practiceSubjectList[
                                                            index]; 
                                                    ePrv.SelectedIndex = index;
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
