import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/notification/notification_cnt.dart';
import 'package:katon/screens/notification/widgets/notification_item.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/pdf_view/pdf_view_page.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/dropdown.dart';
import 'package:katon/widgets/loader.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

import '../../widgets/no_internet.dart';

class NotificationPage extends StatefulWidget {
  final Arguments arguments;

  const NotificationPage({Key? key, required this.arguments}) : super(key: key);

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  final cnt = Get.put(NotificationCnt());

  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    // });
    super.initState();
    getNotification();
    log("---${cnt.notification?.length.toString()}");
  }

  Future<void> getNotification() async {
    await cnt.getAllNotification();
  }

  String? path;
  Directory? dir;
  RxBool isLoading = false.obs;

  // Future<String> init(String fileName) async {

  // }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Container(
          decoration: BoxContainer.boxDeco,
          child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: Responsive.isMobile(context)
                ? CommonAppbarMobile(title: widget.arguments.title)
                : commonAppBar(
                    title: widget.arguments.title,
                    description: widget.arguments.description),
            drawer: Responsive.isMobile(context)
                ? AppPreference().isTeacherLogin
                    ? TeacherDrawerBox(navKey: navigatorKey)
                    : DrawerBox(navKey: navigatorKey)
                : SizedBox(),
            // endDrawer:
            //     Responsive.isMobile(context) ? endDrawerMobile() : endDrawer(),
            body: Obx(
              () => cnt.isLoading.value
                  ? Loader(message: "loading_wait".tr)
                  : Column(
                      children: [
                        ConnectionWidget.connection,
                        (cnt.connection.value == false)
                            ? Expanded(
                                child: NoInternet(
                                    onTap: () => cnt.getAllNotification()))
                            : Expanded(
                                child: ColorContainer(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: Responsive.isMobile(context)
                                          ? 10
                                          : 20.0,
                                      vertical: 10.0),
                                  color: AppColors.darkPink,
                                  title:
                                      FormatDate.monthYear("${DateTime.now()}"),
                                  textStyle: FontStyleUtilities.h4(
                                      fontColor: AppColors.white,
                                      fontWeight: FWT.semiBold),
                                  // suffixItem: Expanded(
                                  //   child: DropDown(
                                  //     dropDowns: cnt.monthList,
                                  //     selectedValue: cnt.selectedMonth,
                                  //     onChange: (value) {
                                  //       cnt.selectedMonth.value = value ?? "";
                                  //     },
                                  //   ),
                                  // ),
                                  child: Expanded(
                                    child: Container(
                                      padding: v25,
                                      decoration: BoxDecoration(
                                        borderRadius: cr24,
                                        color: AppColors.white,
                                        border: Border.all(
                                          color: AppColors.gray300,
                                        ),
                                      ),
                                      child: cnt.notification?.length == 0 ||
                                              cnt.notification?.length == null
                                          ? NoDataFound()
                                          : ListView.builder(
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              itemCount:
                                                  cnt.notification?.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return NotificationItem(
                                                  downloadOnTap: () async {
                                                    cnt.downloadPdf(index);
                                                  },
                                                  viewPdfOnTap: () async {
                                                    log("-----${cnt.notification?[index].ntFile}");
                                                    // await OpenFile.open(
                                                    //     "/data/user/0/com.katon.student/app_flutter/kt_notification/nt_file/1684912712928.pdf");
                                                    Get.to(() => PDFViewPage(
                                                          filename:
                                                              "${cnt.notification?[index].ntFile}",
                                                          isFrom: true,
                                                        ));
                                                  },
                                                  notificationItem:
                                                      cnt.notification?[index],
                                                );
                                              },
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
