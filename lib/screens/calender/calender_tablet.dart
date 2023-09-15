import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/calender/controller/event_cnt.dart';
import 'package:katon/screens/calender/widget/event_common_widget.dart';
import 'package:katon/screens/calender/widget/event_list.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/connection_manager.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_internet.dart';

class CalenderTabletPage extends StatelessWidget {
  final Arguments? arguments;
  CalenderTabletPage({Key? key, this.arguments}) : super(key: key);
  final cnt = Get.put(EventsCnt());
  final connection = Get.put(ConnectionManagerController());

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: CommonContainer(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            // endDrawer: endDrawer(),
            appBar: commonAppBar(
                title: arguments?.title ?? "",
                description: arguments?.description ?? ""),
            body: Obx(
              () => cnt.isLoading.value
                  ? Loader(message: "loading_wait".tr)
                  : Stack(
                      children: [
                        cnt.noInternet.value
                            ? NoInternet(onTap: () => cnt.getAllEvents())
                            : ColorContainer(
                                svgImage: Images.calendarSvg,
                                title: "events_news".tr,
                                textStyle: FontStyleUtilities.h4(
                                    fontColor: AppColors.white,
                                    fontWeight: FWT.semiBold),
                                color: AppColors.lightGreen,
                                margin: l20r20b20t5,
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          EventCalender(
                                              height: 550.h, width: 680.w),
                                          Padding(
                                            padding: EdgeInsets.only(
                                              left: 24.w,
                                              right: 15.w,
                                            ),
                                            child: SizedBox(
                                              height: 550.h,
                                              width: 250.w,
                                              child: SingleChildScrollView(
                                                physics:
                                                    BouncingScrollPhysics(),
                                                child: EventList(),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
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
      ),
    );
  }
}
