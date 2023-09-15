import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/live_class_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/live_class/controller/live_class_prv.dart';
import 'package:katon/screens/my_library/widgets/video_player.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/app_webview/app_webview.dart';
import 'package:provider/provider.dart';

class LiveClassDetailsTablet extends StatelessWidget {
  final LiveSession liveSession;
  final Arguments? arg;
  const LiveClassDetailsTablet({Key? key, required this.liveSession, this.arg})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // endDrawer: endDrawer(),
      backgroundColor: AppColors.backGroundColor,
      appBar: commonAppBar(
          onPressed: () => Navigator.pop(context),
          backIcon: true,
          title: arg?.title ?? "",
          description: arg?.description ?? ""),
      body: SafeArea(
        child: Row(
          children: [
            ColorContainer(
              margin: t20l20r10b20,
              width: Get.width / 2,
              child: Expanded(
                child: Container(
                  padding: all12,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: cr20,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          children: [
                            Container(
                              height: 400,
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
                              builder: (context, snapshot) => Text(
                                snapshot.hasData
                                    ? "${snapshot.data}"
                                    : "${liveSession.lsDesc}",
                                style: FontStyleUtilities.t3(
                                  fontWeight: FWT.medium,
                                  fontColor: AppColors.grey500,
                                ).copyWith(
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              title: "${liveSession.lsTitle}",
              color: AppColors.orangeAccent,
            ),
            Expanded(
              child: Container(
                padding: all14,
                margin: t20r20b20,
                decoration: BoxDecoration(
                  color: AppColors.primaryYellow,
                  borderRadius: cr24,
                ),
                child: Container(
                  padding: l12t12b12r12,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: cr20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (liveSession.lsTeacher?.tcProfilePic != null)
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: CachedNetworkImageProvider(
                            '${ApiRoutes.imageURL}${liveSession.lsTeacher?.tcProfilePic}',
                          ),
                        ),
                      h30,
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
                                "${liveSession.lsTeacher?.tcFullName}",
                              ),
                              builder: (context, snapshot) => Text(
                                snapshot.hasData
                                    ? "${snapshot.data}"
                                    : "${liveSession.lsTeacher?.tcFullName}",
                                textAlign: TextAlign.end,
                                style: FontStyleUtilities.t3(
                                  fontWeight: FWT.medium,
                                  fontColor: AppColors.grey500,
                                ).copyWith(
                                  overflow: TextOverflow.visible,
                                ),
                              ),
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
                                            overflow: TextOverflow.visible));
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
                      Spacer(),
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
              ),
            )
          ],
        ),
      ),
    );
  }
}
