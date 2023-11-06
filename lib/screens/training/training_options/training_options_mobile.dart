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
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: value.trainingOption == 3? ListView.builder(
                        shrinkWrap: true,
                        itemCount: value!.PhysicalTraningDetails.length,
                        itemBuilder: (BuildContext context, i) {
                          var data = value.PhysicalTraningDetails[i];
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

class TranningOptionselect extends StatelessWidget {
  const TranningOptionselect(
      {super.key, this.title, this.image, this.description});
  final title;
  final image;
  final description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Image.asset(
              image.toString(),
              height: 30,
            ),
            w10,
            Text(
              title,
              style: FontStyleUtilities.t1(
                  fontColor: AppColors.black, fontWeight: FWT.semiBold),
            ),
          ],
        ),
        h10,
        Text(
          description.toString(),
          style: FontStyleUtilities.t1(
            fontColor: AppColors.black,
          ),
        ),
        h20,
      ],
    );
  }
}
