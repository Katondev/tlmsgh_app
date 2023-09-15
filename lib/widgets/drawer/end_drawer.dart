import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../screens/message/message_cnt.dart';
import '../../utils/api_translator.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../utils/font_style.dart';
import '../../utils/prefs/app_preference.dart';
import '../../utils/prefs/preferences_key.dart';
import '../common_appbar.dart';
import '../loader.dart';
import '../no_data_found.dart';

final GlobalKey<ScaffoldState> endDrawerKey = GlobalKey<ScaffoldState>();

class EndDrawer extends StatefulWidget {
  const EndDrawer({super.key});

  @override
  State<EndDrawer> createState() => _EndDrawerState();
}

class _EndDrawerState extends State<EndDrawer> {
  final cnt = Get.put(MessageCnt());
  final appbarCnt = Get.put(AppBarCnt());

  @override
  void initState() {
    cnt.getAllMessage();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: Get.width / 1.2,
      child: Scaffold(
        backgroundColor: AppColors.lightBrown,
        appBar: AppBar(
          leading: SizedBox(),
          toolbarHeight: 45,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "my_messages".tr,
                style: FontStyleUtilities.h5(
                        fontWeight: FWT.semiBold,
                        fontColor: AppColors.primaryColor)
                    .copyWith(
                  fontSize: textSizeLargeMedium,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    setState(() {
                      // Get.back();
                      Navigator.of(context).pop();
                      log("ontapeed...");
                    });
                  },
                  child: Icon(Icons.close)),
            ],
          ),
          leadingWidth: 0.0,
          centerTitle: false,
        ),
        body: Obx(
          () => cnt.isLoading.value
              ? Loader(message: "loading_wait".tr)
              : cnt.messageCount == 0
                  ? NoDataFound()
                  : ListView.builder(
                      itemCount:
                          cnt.messageResponseModel?.data?.sendMessage?.length,
                      itemBuilder: (context, index) {
                        final messageList =
                            cnt.messageResponseModel?.data?.sendMessage?[index];
                        return Padding(
                          padding: all10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: AppColors.primary,
                                child: Image.asset(
                                  Images.circleImage,
                                ),
                              ),
                              w6,
                              Flexible(
                                child: Padding(
                                  padding: t10r10,
                                  child: Container(
                                    padding: l10t10r10b5,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius:
                                          topBottomRightAndBottomLeft20,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        FutureBuilder(
                                          future: Translator().translate(
                                              "${messageList?.smType}"),
                                          builder: (context, snapshot) {
                                            return Text(
                                                snapshot.hasData
                                                    ? "${snapshot.data}"
                                                    : "${messageList?.smType}",
                                                style: FontStyleUtilities.t1(
                                                  fontColor:
                                                      AppColors.primaryColor,
                                                  fontWeight: FWT.semiBold,
                                                ).copyWith(
                                                  overflow: TextOverflow.clip,
                                                ));
                                          },
                                        ),
                                        FutureBuilder(
                                          future: Translator().translate(
                                              "${messageList?.smMsg}"),
                                          builder: (context, snapshot) {
                                            return Text(
                                              snapshot.hasData
                                                  ? "${snapshot.data}"
                                                  : "${messageList?.smMsg}",
                                              style: FontStyleUtilities.t3(
                                                      fontColor: AppColors
                                                          .primaryColor)
                                                  .copyWith(
                                                overflow: TextOverflow.clip,
                                              ),
                                            );
                                          },
                                        ),
                                        h6,
                                        Align(
                                          alignment: Alignment.bottomRight,
                                          child: Text(
                                            "${messageList?.smCreatedAt}",
                                            style: FontStyleUtilities.t5(
                                                    fontColor: AppColors.black
                                                        .withOpacity(0.4))
                                                .copyWith(
                                              overflow: TextOverflow.clip,
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
                        );
                      },
                    ),
        ),
      ),
    );
  }
}
