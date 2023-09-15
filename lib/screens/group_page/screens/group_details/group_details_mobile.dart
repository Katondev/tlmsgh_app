import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/group_page/widgets/delete_group_dialog.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/utils/config.dart';

import '../../../../models/argument_model.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/font_style.dart';
import '../../../../widgets/button.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/loader.dart';
import '../../../blog_page/controller/blog_controller.dart';
import '../../../blog_page/widgets/blog_widget.dart';
import '../../controller/group_controller.dart';
import '../../widgets/group_widget.dart';

class GroupDetailsMobile extends StatefulWidget {
  final Arguments arguments;

  GroupDetailsMobile({super.key, required this.arguments});

  @override
  State<GroupDetailsMobile> createState() => _GroupDetailsMobileState();
}

class _GroupDetailsMobileState extends State<GroupDetailsMobile> {
  final blgCnt = Get.put(BlogController());
  final grpCnt = Get.find<GroupController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.arguments.title,
          style: FontStyleUtilities.h4(fontWeight: FWT.medium),
        ),
      ),
      body: Obx(
        () => grpCnt.isloadinggroupDetails.value && grpCnt.commentload.value
            ? Loader(message: "loading".tr)
            : ListView(
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    width: Get.width,
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      // borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: AppColors.grey,
                            blurRadius: 4,
                            spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${grpCnt.groupDetail.value.data?.group?.grpName}",
                                style: FontStyleUtilities.t1(
                                    fontWeight: FWT.medium),
                              ),
                              (grpCnt.isshowGroup.value)
                                  ? Row(
                                      children: [
                                        Expanded(
                                          child: LargeButton(
                                            onPressed: () async {
                                              await grpCnt.joinGroup();
                                            },
                                            height: 30,
                                            width: 60,
                                            color: AppColors.primary,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            child: Text(
                                              "Join group",
                                              style: FontStyleUtilities.t3(
                                                  fontWeight: FWT.medium,
                                                  fontColor: AppColors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : (grpCnt.groupDetail.value.data?.group
                                              ?.grpParticipants
                                              ?.contains(AppPreference().getInt(
                                                  PreferencesKey.uId)) ??
                                          false)
                                      ? Row(
                                          children: [
                                            Expanded(
                                              child: LargeButton(
                                                onPressed: () async {
                                                  await showDeleteGroupDialog(
                                                      context);
                                                },
                                                height: 30,
                                                width: 60,
                                                color: AppColors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Text(
                                                  "Delete Group",
                                                  style: FontStyleUtilities.t3(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.white),
                                                ),
                                              ),
                                            ),
                                            w10,
                                            Expanded(
                                              child: LargeButton(
                                                onPressed: () {
                                                  // navigatorKey.currentState!
                                                  //     .pushNamed(RoutesConst.createblog);
                                                  Get.toNamed(RoutesConst
                                                      .creategroupblog);
                                                },
                                                height: 30,
                                                width: 60,
                                                color: AppColors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Text(
                                                  "Create Group Blog",
                                                  style: FontStyleUtilities.t3(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Expanded(
                                              child: LargeButton(
                                                onPressed: () async {
                                                  // await showDeleteGroupDialog(
                                                  //     context);
                                                  await grpCnt.exitGroup();
                                                },
                                                height: 30,
                                                width: 60,
                                                color: AppColors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Text(
                                                  "Exit Group",
                                                  style: FontStyleUtilities.t3(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.white),
                                                ),
                                              ),
                                            ),
                                            w10,
                                            Expanded(
                                              child: LargeButton(
                                                onPressed: () {
                                                  // navigatorKey.currentState!
                                                  //     .pushNamed(RoutesConst.createblog);
                                                  Get.toNamed(RoutesConst
                                                      .creategroupblog);
                                                },
                                                height: 30,
                                                width: 60,
                                                color: AppColors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Text(
                                                  "Create Group Blog",
                                                  style: FontStyleUtilities.t3(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.white),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                            ],
                          ),
                        ),
                        Divider(color: AppColors.grey, thickness: 2, height: 0),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: (grpCnt.isloadingrelatedGrp.value)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : (grpCnt.groupDetail.value.data != null &&
                                      grpCnt.groupDetail.value.data!.group!
                                          .grpParticipantsDetails!.isEmpty)
                                  ? Text(
                                      "no_data_found".tr,
                                      style: FontStyleUtilities.t1(
                                          fontWeight: FWT.medium),
                                    )
                                  : SizedBox(
                                      height: 60,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, i) {
                                          var data = grpCnt
                                              .groupDetail
                                              .value
                                              .data!
                                              .group!
                                              .grpParticipantsDetails?[i];
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage: NetworkImage(
                                                        "${ApiRoutes.imageURL}${data?.stProfilePic}")),
                                                // h6,
                                                Text(
                                                  "${data?.stFullName}",
                                                  style: FontStyleUtilities.t3(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.black),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount: grpCnt
                                            .groupDetail
                                            .value
                                            .data!
                                            .group!
                                            .grpParticipantsDetails
                                            ?.length,
                                      ),
                                    ),
                        ),
                      ],
                    ),
                  ),
                  // h20,
                  (grpCnt.groupDetail.value.data!.group!.grpBlogs!.isNotEmpty)
                      ? ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, i) {
                            var data = grpCnt
                                .groupDetail.value.data?.group?.grpBlogs?[i];
                            return GroupWidget(
                              blogData: grpCnt
                                  .groupDetail.value.data!.group!.grpBlogs![i],
                              cardindex: i,
                              ontapComment: () async {
                                blgCnt.commentDataList.clear();
                                blgCnt.selectedComment.value =
                                    (blgCnt.selectedComment.value == i)
                                        ? -1
                                        : i;

                                setState(() {});
                                grpCnt.commentload.value = false;
                                if (blgCnt.selectedComment.value == i) {
                                  blgCnt.blogId.value = data!.blId!;
                                  Future.delayed(Duration(milliseconds: 100),
                                      () {
                                    blgCnt.isLoadingComments.value = true;
                                  });
                                  await blgCnt.getAllCommentsbyId();
                                }
                                // log("${blgCnt.selectedComment.value.toString()}====${data.isshowComments}");
                              },
                              ontapLike: () async {
                                if (!data!.isLike!) {
                                  data.isLike = true;
                                  data.blLikeCount = data.blLikeCount! + 1;
                                  setState(() {});
                                  blgCnt.blogId.value = data.blId!;

                                  await blgCnt.likeBlog();
                                }
                              },
                            );
                          },
                          itemCount: grpCnt
                              .groupDetail.value.data?.group?.grpBlogs?.length,
                        )
                      : Container(
                          height: Get.height / 1.5,
                          width: Get.width,
                          alignment: Alignment.center,
                          child: Text(
                            "no_data_found".tr,
                            style:
                                FontStyleUtilities.h6(fontWeight: FWT.medium),
                          ),
                        ),
                ],
              ),
      ),
    );
  }
}
