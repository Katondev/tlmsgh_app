import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/screens/training/training_item.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:katon/utils/config.dart';

import '../../utils/Routes/teacher_route_arguments.dart';

class TrainingPageMobile extends StatelessWidget {
  final Arguments? arguments;
  const TrainingPageMobile({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
        child: Consumer<TrainingProvider>(
      builder: (context, value, child) => Scaffold(
          appBar: CommonAppbarMobile(title: arguments?.title ?? ""),
          // endDrawer: endDrawerMobile(),
          drawer: AppPreference().isTeacherLogin
              ? TeacherDrawerBox(navKey: navigatorKey)
              : DrawerBox(navKey: navigatorKey),
          backgroundColor: Colors.transparent,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConnectionWidget.connection,
              value.value
                  ? Expanded(child: Loader(message: "loading_wait".tr))
                  : value.connection
                      ? Expanded(
                          child:
                              NoInternet(onTap: () => value.getAllTrainings()))
                      : value.trainingModel == null ||
                              value.trainingModel?.data?.trainingPrograms
                                      ?.length ==
                                  0
                          ? Expanded(
                              child: NoDataFound(message: "no_data_found".tr))
                          : Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GridView.builder(
                                  // controller: scrollController,
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithMaxCrossAxisExtent(
                                          childAspectRatio: 10 / 19.2,
                                          maxCrossAxisExtent: 300,
                                          mainAxisExtent: 330,
                                          crossAxisSpacing: 10,
                                          mainAxisSpacing: 10),
                                  itemCount: value.trainingModel?.data
                                      ?.trainingPrograms?.length,
                                  itemBuilder: (context, i) {
                                    // if (ePrv.books.length ==
                                    //     i) {
                                    //   return ePrv
                                    //           .isLoadingStarted
                                    //       ? Center(
                                    //           child:
                                    //               CircularProgressIndicator(),
                                    //         )
                                    //       : SizedBox();
                                    // }
                                    var data = value.trainingModel?.data
                                        ?.trainingPrograms?[i];
                                    return TrainingItem(
                                      trainingPrograms: data,
                                      onTap: () {
                                        value.trainingProgramId = data!.tpId!;
                                        navigatorKey.currentState?.pushNamed(
                                            RoutesConst.trainingDetails,
                                            arguments: data);
                                      },
                                    );
                                  },
                                ),
                                // child: SingleChildScrollView(
                                //   physics: BouncingScrollPhysics(),
                                //   child: LayoutGrid(
                                //     rowGap: 10,
                                //     columnGap: 10,
                                //     gridFit: GridFit.passthrough,
                                //     columnSizes: [auto, auto],
                                //     rowSizes: List<
                                //             IntrinsicContentTrackSize>.generate(
                                //         (value
                                //                     .trainingModel
                                //                     ?.data
                                //                     ?.trainingPrograms
                                //                     ?.length ??
                                //                 0 / 2)
                                //             .round(),
                                //         (int index) => auto),
                                //     children: value
                                //         .trainingModel!.data!.trainingPrograms!
                                //         .map(
                                //       (trainingPrograms) {
                                //         return TrainingItem(
                                //           trainingPrograms: trainingPrograms,
                                //           onTap: () {
                                //             Get.toNamed(
                                //                 RoutesConst.trainingDetails);
                                //           },
                                //         );
                                //       },
                                //     ).toList(),
                                //   ),
                                // ),
                              ),
                            ),
            ],
          )),
    ));
  }
}
