import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/live_class_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/live_class/controller/live_class_prv.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/app_webview/app_webview.dart';
import 'package:provider/provider.dart';

import '../../my_library/widgets/video_player.dart';

class LiveClassDetailsMobile extends StatelessWidget {
  final LiveSession liveSession;
  final Arguments? arg;
  const LiveClassDetailsMobile({Key? key, required this.liveSession, this.arg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: CommonAppbarMobile(title: arg?.title ?? ""),
      // endDrawer: endDrawerMobile(),
      body: SafeArea(
        child: Container(
          padding: all10,
          margin: all10,
          decoration: BoxDecoration(
            color: AppColors.primaryYellow,
            borderRadius: cr24,
          ),
          child: Column(
            children: [
              Padding(
                padding: l10,
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FutureBuilder(
                    future: Translator().translate("${liveSession.lsTitle}"),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.hasData
                            ? "${snapshot.data}"
                            : "${liveSession.lsTitle}",
                        maxLines: 2,
                        style: FontStyleUtilities.h6(
                                fontWeight: FWT.semiBold,
                                fontColor: AppColors.white)
                            .copyWith(
                          overflow: TextOverflow.ellipsis,
                        ),
                      );
                    },
                  ),
                ),
              ),
              h10,
              Expanded(
                child: Container(
                  padding: all10,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: cr20,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: cr12,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(
                                    '${ApiRoutes.imageURL}${liveSession.lsImage}',
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            h10,
                            Text(
                              "description".tr,
                              style: FontStyleUtilities.h4(
                                fontWeight: FWT.semiBold,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            FutureBuilder(
                              future: Translator()
                                  .translate("${liveSession.lsDesc}"),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.hasData
                                      ? "${snapshot.data}"
                                      : "${liveSession.lsDesc}",
                                  style: FontStyleUtilities.t3(
                                          fontWeight: FWT.medium,
                                          fontColor: AppColors.grey500)
                                      .copyWith(
                                    overflow: TextOverflow.visible,
                                  ),
                                );
                              },
                            ),
                            h10,
                            liveSession.lsTeacher?.tcProfilePic == null
                                ? SizedBox.shrink()
                                : Align(
                                    alignment: Alignment.centerLeft,
                                    child: CircleAvatar(
                                      radius: 25,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        '${ApiRoutes.imageURL}${liveSession.lsTeacher?.tcProfilePic}',
                                      ),
                                    ),
                                  ),
                            h10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "teacher_name".tr,
                                  style: FontStyleUtilities.t2(
                                      fontWeight: FWT.bold,
                                      fontColor: AppColors.primaryColor),
                                  overflow: TextOverflow.visible,
                                ),
                                Flexible(
                                  child: FutureBuilder(
                                    future: Translator().translate(
                                        "${liveSession.lsTeacher?.tcFullName}"),
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.hasData
                                            ? "${snapshot.data}"
                                            : "${liveSession.lsTeacher?.tcFullName}",
                                        textAlign: TextAlign.end,
                                        style: FontStyleUtilities.t3(
                                                fontWeight: FWT.medium,
                                                fontColor: AppColors.grey500)
                                            .copyWith(
                                          overflow: TextOverflow.visible,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            h10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "live_class:".tr,
                                  style: FontStyleUtilities.t2(
                                      fontWeight: FWT.bold,
                                      fontColor: AppColors.primaryColor),
                                  overflow: TextOverflow.visible,
                                ),
                                Flexible(
                                  child: FutureBuilder(
                                    future: Translator()
                                        .translate("${liveSession.lsTitle}"),
                                    builder: (context, snapshot) {
                                      return Text(
                                        snapshot.hasData
                                            ? "${snapshot.data}"
                                            : "${liveSession.lsTitle}",
                                        textAlign: TextAlign.end,
                                        style: FontStyleUtilities.t3(
                                                fontWeight: FWT.medium,
                                                fontColor: AppColors.grey500)
                                            .copyWith(
                                          overflow: TextOverflow.visible,
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            h10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "date".tr,
                                  style: FontStyleUtilities.t2(
                                      fontWeight: FWT.bold,
                                      fontColor: AppColors.primaryColor),
                                  overflow: TextOverflow.visible,
                                ),
                                Text(
                                  "${liveSession.lsDate}",
                                  style: FontStyleUtilities.t3(
                                      fontWeight: FWT.medium,
                                      fontColor: AppColors.grey500),
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                            h10,
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "time".tr,
                                  style: FontStyleUtilities.t2(
                                      fontWeight: FWT.bold,
                                      fontColor: AppColors.primaryColor),
                                  overflow: TextOverflow.visible,
                                ),
                                Text(
                                  "${liveSession.lsTime}",
                                  style: FontStyleUtilities.t3(
                                      fontWeight: FWT.medium,
                                      fontColor: AppColors.grey500),
                                  overflow: TextOverflow.visible,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Consumer<LiveClassProvider>(
                        builder: (context, prv, _) => (prv.isScheduled)
                            ? Center(
                                child: LargeButton(
                                  height: 40,
                                  onPressed: () {
                                    log("1");
                                    Get.to(() => AppWebView(
                                        arguments: StudentRouteArguments()
                                            .getArgument(RoutesConst.liveClass),
                                        url: ApiRoutes().liveClassUrl(
                                            liveSession.lsRoomURL)));
                                  },
                                  width: double.maxFinite,
                                  color: AppColors.primary,
                                  child: Text(
                                    (AppPreference().getString(
                                                PreferencesKey.uType) ==
                                            "Teacher")
                                        ? 'start_class'.tr
                                        : 'join_class'.tr,
                                    style: FontStyleUtilities.h6(
                                      fontWeight: FWT.medium,
                                      fontColor: AppColors.white,
                                    ),
                                  ),
                                ),
                              )
                            : (liveSession.lsVideoURL == "" ||
                                    liveSession.lsVideoURL == null)
                                ? SizedBox()
                                : Center(
                                    child: LargeButton(
                                      height: 40,
                                      onPressed: () {
                                        log("2");
                                        Get.to(() => Video(
                                              title: liveSession.lsVideoURL,
                                            ));
                                      },
                                      width: double.maxFinite,
                                      color: AppColors.primary,
                                      child: Text(
                                        'watch_recorded_video'.tr,
                                        style: FontStyleUtilities.h6(
                                          fontWeight: FWT.medium,
                                          fontColor: AppColors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
