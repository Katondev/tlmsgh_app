import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:provider/provider.dart';

import '../../../models/argument_model.dart';
import '../../../utils/Routes/teacher_route_arguments.dart';
import '../../../utils/font_style.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../widgets/content_widget.dart';
import '../widgets/expansion_tile_custom.dart';

class TrainingOptionsMobile extends StatefulWidget {
  final Arguments arguments;
  const TrainingOptionsMobile({super.key, required this.arguments});

  @override
  State<TrainingOptionsMobile> createState() => _TrainingOptionsMobileState();
}

class _TrainingOptionsMobileState extends State<TrainingOptionsMobile> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryWhite,
      child: SafeArea(
        child: Scaffold(
          body: Consumer<TrainingProvider>(
            builder: (context, value, child) => Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(20),
                  child: CommonAppBar2(
                      title: "Training",
                      description: widget.arguments.title,
                      isshowback: true),
                ),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    children: [
                      Text(
                        "Choose Training Option",
                        style: FontStyleUtilities.h4(
                            fontWeight: FWT.medium,
                            fontColor: AppColors.primary),
                      ),
                      Divider(),
                      ListView.builder(
                        key: Key(value.selectedTile.toString()),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          var alldata = value.trainingOptionList[index];
                          return ExpansionTileCustom(
                            key: Key(index.toString()),
                            initiallyExpanded: index == value.selectedTile,
                            title: Text(
                              alldata.keys.toList()[0].toString(),
                              style: FontStyleUtilities.t1(
                                  fontWeight: FWT.medium,
                                  fontColor: AppColors.primary),
                            ),
                            onExpansionChanged: (val) {
                              if (val) {
                                value.radioGroupVal = "${index + 1}";

                                value.selectedTile = index;
                              } else {
                                value.radioGroupVal = "0";
                                value.selectedTile = -1;
                              }

                              value.notifyListeners();
                              log(val.toString());
                            },
                            leading: Radio(
                              value: "${index + 1}",
                              groupValue: value.radioGroupVal,
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              onChanged: (String? val) {
                                value.radioGroupVal = val;
                              },
                            ),
                            children: [
                              ListView.separated(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                separatorBuilder: (context, i) {
                                  return h6;
                                },
                                itemBuilder: (context, i) {
                                  var data = alldata.values.toList()[0][i];
                                  return ContentWidgetwithDot(
                                    title: data,
                                  );
                                },
                                itemCount: alldata.values.toList()[0].length,
                              ),
                              h20,
                              LargeButton(
                                onPressed: () {
                                  value.trainingOption = index + 1;
                                  log(value.trainingOption.toString());
                                  value.getTrainingParticipants(context);
                                },
                                height: 40,
                                borderRadius: BorderRadius.circular(30),
                                child: Text("submit".tr),
                              ),
                              h20,
                            ],
                          );
                        },
                        itemCount: value.trainingOptionList.length,
                      ),
                      // ExpansionTileCustom(
                      //   title: Text(
                      //     "Online Live Training",
                      //     style: FontStyleUtilities.t1(
                      //         fontWeight: FWT.medium, fontColor: AppColors.primary),
                      //   ),
                      //   onExpansionChanged: (val) {
                      //     if (val) {
                      //       value.radioGroupVal = "2";
                      //     } else {
                      //       value.radioGroupVal = "0";
                      //     }
                      //     value.notifyListeners();
                      //     log(val.toString());
                      //   },
                      //   leading: Radio(
                      //     value: "2",
                      //     groupValue: value.radioGroupVal,
                      //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      //     onChanged: (String? val) {
                      //       value.radioGroupVal = val;
                      //     },
                      //   ),
                      //   children: [
                      //     ListView.separated(
                      //       shrinkWrap: true,
                      //       separatorBuilder: (context, i) {
                      //         return h6;
                      //       },
                      //       itemBuilder: (context, i) {
                      //         var data = value.onlineTrainingList[i];
                      //         return ContentWidgetwithDot(
                      //           title: data,
                      //         );
                      //       },
                      //       itemCount: value.onlineTrainingList.length,
                      //     ),
                      //     h20,
                      //     LargeButton(
                      //       onPressed: () {},
                      //       height: 40,
                      //       borderRadius: BorderRadius.circular(30),
                      //       child: Text("submit".tr),
                      //     ),
                      //     h20,
                      //   ],
                      // ),
                      // ExpansionTileCustom(
                      //   title: Text(
                      //     "Physical Training",
                      //     style: FontStyleUtilities.t1(
                      //         fontWeight: FWT.medium, fontColor: AppColors.primary),
                      //   ),
                      //   onExpansionChanged: (val) {
                      //     if (val) {
                      //       value.radioGroupVal = "3";
                      //     } else {
                      //       value.radioGroupVal = "0";
                      //     }
                      //     value.notifyListeners();
                      //     log(val.toString());
                      //   },
                      //   leading: Radio(
                      //     value: "3",
                      //     groupValue: value.radioGroupVal,
                      //     visualDensity: VisualDensity(horizontal: -4, vertical: -4),
                      //     onChanged: (String? val) {
                      //       value.radioGroupVal = val;
                      //     },
                      //   ),
                      //   children: [
                      //     ListView.separated(
                      //       shrinkWrap: true,
                      //       separatorBuilder: (context, i) {
                      //         return h6;
                      //       },
                      //       itemBuilder: (context, i) {
                      //         var data = value.physicalTrainingList[i];
                      //         return ContentWidgetwithDot(
                      //           title: data,
                      //         );
                      //       },
                      //       itemCount: value.physicalTrainingList.length,
                      //     ),
                      //     h20,
                      //     LargeButton(
                      //       onPressed: () {},
                      //       height: 40,
                      //       borderRadius: BorderRadius.circular(30),
                      //       child: Text("submit".tr),
                      //     ),
                      //     h20,
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
