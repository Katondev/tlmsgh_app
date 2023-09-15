import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:get/get.dart';
import 'package:katon/screens/calender/controller/event_cnt.dart';
import 'package:katon/screens/calender/widget/event_common_widget.dart';
import 'package:katon/screens/calender/widget/event_list.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/connection_manager.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_internet.dart';

import '../home_page.dart';

class CalenderMobilePage extends StatelessWidget {
  final Arguments? arguments;
  CalenderMobilePage({Key? key, this.arguments}) : super(key: key);
  final cnt = Get.put(EventsCnt());
  final connection = Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return CommonContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppbarMobile(title: arguments?.title ?? ""),
        // endDrawer: endDrawerMobile(),
        drawer: AppPreference().isTeacherLogin
            ? TeacherDrawerBox(navKey: navigatorKey)
            : DrawerBox(navKey: navigatorKey),
        body: SafeArea(
          child: Obx(
            () => cnt.isLoading.value
                ? Loader(message: "loading_wait".tr)
                : Stack(
                    children: [
                      cnt.noInternet.value
                          ? NoInternet(onTap: () => cnt.getAllEvents())
                          : SingleChildScrollView(
                              physics: const BouncingScrollPhysics(),
                              child: ColorContainer(
                                margin: l10r10b20t5,
                                color: AppColors.lightGreen,
                                svgImage: Images.calendarSvg,
                                title: "events_news".tr,
                                textStyle: FontStyleUtilities.h4(
                                    fontColor: AppColors.white,
                                    fontWeight: FWT.semiBold),
                                child: Column(
                                  children: [
                                    EventCalender(
                                        height: 545, width: Get.width),
                                    h20,
                                    EventList()
                                  ],
                                ),
                              ),
                            ),
                      ConnectionWidget.connection
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
