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
import '../../../widgets/common_appbar.dart';
import '../../../widgets/loader.dart';
import '../../home_page.dart';
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
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Consumer<PracticePrv>(
          builder: (context, ePrv, child) {
            return Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: Colors.transparent,
              // endDrawer: endDrawer(),
              body: Container(
                padding: const EdgeInsets.fromLTRB(35, 30, 35, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonAppBar2(
                        isshowback: true,
                        title: args.toString(),
                        description: widget.arguments.description),
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
                                                        } else if (ePrv
                                                                .selectedPractice ==
                                                            1) {}
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
