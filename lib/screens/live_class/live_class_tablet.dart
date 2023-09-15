import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/live_class/controller/live_class_prv.dart';
import 'package:katon/screens/live_class/widgets/live_class_widget.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import 'package:katon/utils/config.dart';

import '../library_page/widget/library_common_widget.dart';
import 'live_class_tabbar.dart';

class LiveClassTabletPage extends StatefulWidget {
  final Arguments arguments;

  const LiveClassTabletPage({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<LiveClassTabletPage> createState() => _LiveClassTabletPageState();
}

class _LiveClassTabletPageState extends State<LiveClassTabletPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: CommonContainer(child: Consumer<LiveClassProvider>(
        builder: (context, lcP, child) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            // endDrawer: endDrawer(),
            appBar: commonAppBar(
                title: widget.arguments.title.toString(),
                description: widget.arguments.description),
            body: SafeArea(
              child: Column(
                children: [
                  LiveClassTabbar(),
                  ConnectionWidget.connection,
                  (lcP.tabbarIndex == 0)
                      ? Expanded(
                          child: lcP.value
                              ? Loader(message: "loading_wait".tr)
                              : lcP.connection
                                  ? NoInternet(
                                      onTap: () => lcP.getAllLiveClass(
                                        bkSubCategory: "",
                                        bkCategory: "",
                                        page: 1,
                                        limit: 12,
                                      ),
                                    )
                                  : lcP.liveClassModel == null ||
                                          lcP.liveClassModel?.data?.liveSession
                                                  ?.length ==
                                              0
                                      ? NoDataFound(message: "no_book_found".tr)
                                      : Padding(
                                          padding: h30v20,
                                          child: GridView.builder(
                                              itemCount: lcP.liveClassModel
                                                  ?.data?.liveSession?.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 310,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      mainAxisExtent: 330),
                                              itemBuilder: (context, i) {
                                                return LiveClassList(
                                                  liveSession: lcP
                                                      .liveClassModel
                                                      ?.data
                                                      ?.liveSession?[i],
                                                  onTap: () {
                                                    navigatorKey.currentState
                                                        ?.pushNamed(
                                                            RoutesConst
                                                                .liveClassDetails,
                                                            arguments: [
                                                          lcP
                                                              .liveClassModel
                                                              ?.data
                                                              ?.liveSession?[i],
                                                          StudentRouteArguments()
                                                              .getArgument(
                                                                  RoutesConst
                                                                      .liveClassDetails)
                                                        ]);
                                                  },
                                                );
                                              }),
                                          // child: LayoutGrid(
                                          //   rowGap: 10,
                                          //   columnGap: 10,
                                          //   gridFit: GridFit.passthrough,
                                          //   columnSizes: [auto, auto, auto, auto],
                                          //   rowSizes: List<
                                          //           IntrinsicContentTrackSize>.generate(
                                          //       (lcP
                                          //                       .liveClassModel!
                                          //                       .data!
                                          //                       .liveSession!
                                          //                       .length ==
                                          //                   1
                                          //               ? lcP.liveClassModel!.data!
                                          //                   .liveSession!.length
                                          //               : lcP
                                          //                       .liveClassModel!
                                          //                       .data!
                                          //                       .liveSession!
                                          //                       .length /
                                          //                   3)
                                          //           .round(),
                                          //       (int index) => auto),
                                          //   children: lcP
                                          //       .liveClassModel!.data!.liveSession!
                                          //       .skip(lcP.pageNo)
                                          //       .take(12)
                                          //       .map(
                                          //     (liveClassItem) {
                                          //       return LiveClassList(
                                          //         liveSession: liveClassItem,
                                          //         onTap: () {
                                          //           navigatorKey.currentState
                                          //               ?.pushNamed(
                                          //                   RoutesConst
                                          //                       .liveClassDetails,
                                          //                   arguments: [
                                          //                 liveClassItem,
                                          //                 StudentRouteArguments()
                                          //                     .getArgument(RoutesConst
                                          //                         .liveClassDetails)
                                          //               ]);
                                          //         },
                                          //       );
                                          //     },
                                          //   ).toList(),
                                          // ),
                                        ),
                        )
                      : Expanded(
                          child: lcP.value
                              ? Loader(message: "loading_wait".tr)
                              : lcP.connection
                                  ? NoInternet(
                                      onTap: () => lcP.getAllLiveClass(
                                        bkSubCategory: "",
                                        bkCategory: "",
                                        page: 1,
                                        limit: 12,
                                      ),
                                    )
                                  : lcP.liveClassModel == null ||
                                          lcP.liveClassModel?.data?.liveSession
                                                  ?.length ==
                                              0
                                      ? NoDataFound(message: "no_book_found".tr)
                                      : Padding(
                                          padding: h30v20,
                                          child: GridView.builder(
                                              itemCount: lcP.liveClassModel
                                                  ?.data?.liveSession?.length,
                                              gridDelegate:
                                                  SliverGridDelegateWithMaxCrossAxisExtent(
                                                      maxCrossAxisExtent: 310,
                                                      crossAxisSpacing: 10,
                                                      mainAxisSpacing: 10,
                                                      mainAxisExtent: 330),
                                              itemBuilder: (context, i) {
                                                return LiveClassList(
                                                  liveSession: lcP
                                                      .liveClassModel
                                                      ?.data
                                                      ?.liveSession?[i],
                                                  onTap: () {
                                                    navigatorKey.currentState
                                                        ?.pushNamed(
                                                            RoutesConst
                                                                .liveClassDetails,
                                                            arguments: [
                                                          lcP
                                                              .liveClassModel
                                                              ?.data
                                                              ?.liveSession?[i],
                                                          StudentRouteArguments()
                                                              .getArgument(
                                                                  RoutesConst
                                                                      .liveClassDetails)
                                                        ]);
                                                  },
                                                );
                                              }),
                                        ),
                        ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
