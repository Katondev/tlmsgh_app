import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:provider/provider.dart';

import '../../../models/argument_model.dart';
import '../../../utils/Routes/teacher_route_arguments.dart';
import '../../../utils/app_binding.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../utils/font_style.dart';
import '../../../utils/route_const.dart';
import '../../../widgets/button.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../widgets/content_widget.dart';
import '../widgets/expansion_tile_custom.dart';

class TrainingOptionsTablet extends StatefulWidget {
  final Arguments arguments;
  const TrainingOptionsTablet({super.key, required this.arguments});

  @override
  State<TrainingOptionsTablet> createState() => _TrainingOptionsTabletState();
}

class _TrainingOptionsTabletState extends State<TrainingOptionsTablet> {
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
                  padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
                  child: CommonAppBar2(
                    title: "Training",
                    description: widget.arguments.description,
                    isshowback: true,
                  ),
                ),
                Expanded(
                  child: ListView(
                    physics: BouncingScrollPhysics(),
                    padding: EdgeInsets.all(30),
                    children: [
                      Text(
                        "Choose Training Option",
                        style: FontStyleUtilities.h2(
                          fontWeight: FWT.medium,
                          fontColor: AppColors.primary,
                        ),
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
                              style: FontStyleUtilities.h5(
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
                                onPressed: () async {
                                  // navigatorKey.currentState?.pushNamed(
                                  //   RoutesConst.trainingSignature,
                                  //   arguments: TeacherRouteArguments().getTeacherArgument(
                                  //       RoutesConst.trainingSignature),
                                  // );
                                  value.trainingOption = index + 1;
                                  await value.getTrainingParticipants(context);
                                },
                                height: 50,
                                borderRadius: BorderRadius.circular(30),
                                child: Text(
                                  "submit".tr,
                                  style: FontStyleUtilities.h5(
                                      fontWeight: FWT.medium,
                                      fontColor: AppColors.white),
                                ),
                              ),
                              h20,
                            ],
                          );
                        },
                        itemCount: value.trainingOptionList.length,
                      ),
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
