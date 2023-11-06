import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/screens/training/training_options/training_options_mobile.dart';
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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: value.trainingOption == 3? ListView.builder(
                        shrinkWrap: true,
                        itemCount: value!.PhysicalTraningDetails.length,
                        itemBuilder: (BuildContext context, i) {
                          var data = value.PhysicalTraningDetails[i];
                          value.selectedTrainingMode = i;
                  
                          return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                TranningOptionselect(
                                  title: data["title"],
                                  image: data["image"],
                                  description: data["description"],
                                ),
                                h10,
                                LargeButton(
                                  onPressed: () {
                                      value.trainingOption = 3;
                                    log(value.trainingOption.toString());
                                      value.getTrainingParticipants(context);
                                  },
                                  height: 40,
                                  borderRadius: BorderRadius.circular(30),
                                  child: Text("submit".tr),
                                ),
                                h20,
                              ],
                            ),
                          );
                        }):value.trainingOption == 2? ListView.builder(
                        shrinkWrap: true,
                        itemCount: value!.LiveTraningList.length,
                        itemBuilder: (BuildContext context, i) {
                          var data = value.LiveTraningList[i];
                          value.selectedTrainingMode = i;
                  
                          return Column(
                            children: [
                              TranningOptionselect(
                                title: data["title"],
                                image: data["image"],
                                description: data["description"],
                              ),
                              h10,
                              LargeButton(
                                onPressed: () {
                                  value.trainingOption = 2;
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
                        }):ListView.builder(
                        shrinkWrap: true,
                        itemCount: value!.recoardedTranning.length,
                        itemBuilder: (BuildContext context, i) {
                          var data = value.recoardedTranning[i];
                          value.selectedTrainingMode = i;
                  
                          return Column(
                            children: [
                              TranningOptionselect(
                                title: data["title"],
                                image: data["image"],
                                description: data["description"],
                              ),
                              h10,
                              LargeButton(
                                onPressed: () {
                                   value.trainingOption =  1;
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
                        }),
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
