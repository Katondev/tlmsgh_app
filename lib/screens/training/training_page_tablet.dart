import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/screens/training/training_item.dart';
import 'package:katon/utils/Routes/teacher_route_arguments.dart';
import 'package:katon/utils/Routes/teacher_routes.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:katon/utils/config.dart';

import '../home_page.dart';

class TrainingPageTablet extends StatelessWidget {
  final Arguments? arguments;
  const TrainingPageTablet({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.primaryWhite,
      child: SafeArea(
        child: Scaffold(
          body: Consumer<TrainingProvider>(
            builder: (context, value, child) => Scaffold(
                // backgroundColor: Colors.transparent,
                // appBar: commonAppBar(
                //     title: arguments?.title ?? "",
                //     description: arguments?.description),
                // endDrawer: endDrawer(),
                body: Padding(
              padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonAppBar2(
                      title: arguments?.title ?? "",
                      description: arguments?.description),
                  customHeight(15),
                  ConnectionWidget.connection,
                  Expanded(
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: AppColors.boxgreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      // padding: EdgeInsets.fromLTRB(60, 48, 60, 26),
                      padding: EdgeInsets.all(30),
                      child: value.value
                          ? Loader(message: "loading_wait".tr)
                          : value.connection
                              ? NoInternet(onTap: () => value.getAllTrainings())
                              : value.trainingModel == null ||
                                      value.trainingModel?.data
                                              ?.trainingPrograms?.length ==
                                          0
                                  ? NoDataFound(message: "no_data_found".tr)
                                  : Padding(
                                      padding: h15v10,
                                      child: LayoutGrid(
                                        rowGap: 20,
                                        columnGap: 40,
                                        gridFit: GridFit.loose,
                                        columnSizes: [auto, auto, auto],
                                        rowSizes: List<
                                                IntrinsicContentTrackSize>.generate(
                                            (value
                                                            .trainingModel
                                                            ?.data
                                                            ?.trainingPrograms
                                                            ?.length ==
                                                        1
                                                    ? value
                                                        .trainingModel
                                                        ?.data
                                                        ?.trainingPrograms
                                                        ?.length
                                                    : value
                                                            .trainingModel
                                                            ?.data
                                                            ?.trainingPrograms
                                                            ?.length ??
                                                        0 / 3)!
                                                .round(),
                                            (int index) => auto),
                                        children: value.trainingModel!.data!
                                            .trainingPrograms!
                                            .map(
                                          (trainingPrograms) {
                                            return TrainingItem(
                                              trainingPrograms:
                                                  trainingPrograms,
                                              onTap: () {
                                                value.trainingProgramId =
                                                    trainingPrograms.tpId!;
                                                navigatorKey.currentState
                                                    ?.pushNamed(
                                                  RoutesConst.trainingDetails,
                                                  arguments: trainingPrograms,
                                                );
                                              },
                                            );
                                          },
                                        ).toList(),
                                      ),
                                    ),
                    ),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}
