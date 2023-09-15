import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/live_class/controller/live_class_prv.dart';
import 'package:katon/screens/live_class/widgets/live_class_widget.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:provider/provider.dart';

import 'live_class_tabbar.dart';

class LiveClassMobilePage extends StatelessWidget {
  final Arguments? arguments;
  const LiveClassMobilePage({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Consumer<LiveClassProvider>(
        builder: (context, lcP, child) {
          return Scaffold(
            backgroundColor: Colors.transparent,
            appBar: CommonAppbarMobile(title: arguments?.title ?? ""),
            // endDrawer: endDrawerMobile(),
            drawer: AppPreference().isTeacherLogin
                ? TeacherDrawerBox(navKey: navigatorKey)
                : DrawerBox(navKey: navigatorKey),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  LiveClassTabbar(),
                  h10,
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
                                          limit: 12))
                                  : lcP.liveClassModel == null ||
                                          lcP.liveClassModel?.data?.liveSession
                                                  ?.length ==
                                              0
                                      ? NoDataFound(message: "no_book_found".tr)
                                      : SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Padding(
                                            padding: h10v5,
                                            child: LayoutGrid(
                                              rowGap: 10,
                                              columnGap: 10,
                                              gridFit: GridFit.passthrough,
                                              columnSizes: [auto, auto],
                                              rowSizes: List<
                                                      IntrinsicContentTrackSize>.generate(
                                                  (lcP
                                                              .liveClassModel!
                                                              .data!
                                                              .liveSession!
                                                              .length /
                                                          2)
                                                      .round(),
                                                  (int index) => auto),
                                              children: lcP.liveClassModel!
                                                  .data!.liveSession!
                                                  .map(
                                                (liveClassItem) {
                                                  return LiveClassList(
                                                    liveSession: liveClassItem,
                                                    onTap: () {
                                                      navigatorKey.currentState
                                                          ?.pushNamed(
                                                        RoutesConst
                                                            .liveClassDetails,
                                                        arguments: [
                                                          liveClassItem,
                                                          StudentRouteArguments()
                                                              .getArgument(
                                                                  RoutesConst
                                                                      .liveClassDetails)
                                                        ],
                                                      );
                                                    },
                                                  );
                                                },
                                              ).toList(),
                                            ),
                                          ),
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
                                          limit: 12))
                                  : lcP.liveClassModel == null ||
                                          lcP.liveClassModel?.data?.liveSession
                                                  ?.length ==
                                              0
                                      ? NoDataFound(message: "no_book_found".tr)
                                      : SingleChildScrollView(
                                          physics: BouncingScrollPhysics(),
                                          child: Padding(
                                            padding: h10v5,
                                            child: LayoutGrid(
                                              rowGap: 10,
                                              columnGap: 10,
                                              gridFit: GridFit.passthrough,
                                              columnSizes: [auto, auto],
                                              rowSizes: List<
                                                      IntrinsicContentTrackSize>.generate(
                                                  (lcP
                                                              .liveClassModel!
                                                              .data!
                                                              .liveSession!
                                                              .length /
                                                          2)
                                                      .round(),
                                                  (int index) => auto),
                                              children: lcP.liveClassModel!
                                                  .data!.liveSession!
                                                  .map(
                                                (liveClassItem) {
                                                  return LiveClassList(
                                                    liveSession: liveClassItem,
                                                    onTap: () {
                                                      navigatorKey.currentState
                                                          ?.pushNamed(
                                                        RoutesConst
                                                            .liveClassDetails,
                                                        arguments: [
                                                          liveClassItem,
                                                          StudentRouteArguments()
                                                              .getArgument(
                                                                  RoutesConst
                                                                      .liveClassDetails)
                                                        ],
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
            ),
          );
        },
      ),
    );
  }
}
