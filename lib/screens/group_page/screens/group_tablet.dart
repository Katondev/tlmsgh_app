import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:katon/screens/blog_page/controller/blog_controller.dart';
import 'package:katon/screens/group_page/widgets/create_group_dialog.dart';
import 'package:katon/utils/Routes/student_route_arguments.dart';

import '../../../models/argument_model.dart';
import '../../../network/api_constants.dart';
import '../../../utils/app_binding.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/config.dart';
import '../../../utils/font_style.dart';
import '../../../widgets/button.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../controller/group_controller.dart';
import '../widgets/create_group_blog_dialog.dart';
import '../widgets/delete_group_dialog.dart';
import '../widgets/group_widget.dart';

class GroupTablet extends StatefulWidget {
  final Arguments arguments;
  const GroupTablet({super.key, required this.arguments});

  @override
  State<GroupTablet> createState() => _GroupTabletState();
}

class _GroupTabletState extends State<GroupTablet> {
  final grpCnt = Get.find<GroupController>();
  final blgCnt = Get.put(BlogController());

  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    await grpCnt.getClassmateList();
    await grpCnt.getRelatedGroup();
    await grpCnt.getGroupList().then((value) => grpCnt.getGroupDetailsbyId());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppBar(
          title: widget.arguments.title.toString(),
          description: widget.arguments.description),
      // endDrawer: endDrawer(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 300,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.white,
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
                            EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "My Groups",
                              style:
                                  FontStyleUtilities.h6(fontWeight: FWT.medium),
                            ),
                            LargeButton(
                              onPressed: () async {
                                await showCreateGroupDialog(context);
                              },
                              height: 40,
                              width: 80,
                              borderColor: AppColors.primary,
                              borderWidth: 1,
                              borderRadius: BorderRadius.circular(5),
                              color: AppColors.white,
                              child: Text(
                                "New",
                                style: FontStyleUtilities.t2(
                                    fontWeight: FWT.medium,
                                    fontColor: AppColors.primary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: AppColors.grey, thickness: 2, height: 0),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Obx(
                          () => (grpCnt.isloadinggroups.value)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : (grpCnt.groupList.value.data != null &&
                                      grpCnt.groupList.value.data!.group!
                                          .isNotEmpty)
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        var data = grpCnt
                                            .groupList.value.data?.group?[i];
                                        return ListTile(
                                          onTap: () async {
                                            grpCnt.commentload.value = true;
                                            grpCnt.groupId.value = data!.grpId!;
                                            grpCnt.isshowGroup.value = false;
                                            blgCnt.selectedComment.value = -1;
                                            // setState(() {});
                                            await grpCnt.getGroupDetailsbyId();
                                          },
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          contentPadding: EdgeInsets.zero,
                                          leading: Obx(
                                            () => Text(
                                              "${data?.grpName}",
                                              style: FontStyleUtilities.t2(
                                                  fontWeight: FWT.medium,
                                                  fontColor:
                                                      (grpCnt.groupId.value ==
                                                              data!.grpId!)
                                                          ? AppColors.primary
                                                          : AppColors.black),
                                            ),
                                          ),
                                          trailing: Icon(
                                            Icons.account_circle,
                                            size: 28,
                                          ),
                                        );
                                      },
                                      itemCount: grpCnt
                                          .groupList.value.data?.group?.length,
                                    )
                                  : Text(
                                      "no_data_found".tr,
                                      style: FontStyleUtilities.t1(
                                          fontWeight: FWT.medium),
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
                h20,
                Container(
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: AppColors.white,
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
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Groups",
                              style:
                                  FontStyleUtilities.h6(fontWeight: FWT.medium),
                            ),
                          ],
                        ),
                      ),
                      Divider(color: AppColors.grey, thickness: 2, height: 0),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Obx(
                          () => (grpCnt.isloadingrelatedGrp.value)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : (grpCnt.relatedGroupData.value.data != null &&
                                      grpCnt.relatedGroupData.value.data!.group!
                                          .isNotEmpty)
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      // scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, i) {
                                        var data = grpCnt.relatedGroupData.value
                                            .data!.group![i];
                                        return ListTile(
                                          onTap: () async {
                                            grpCnt.commentload.value = true;
                                            grpCnt.groupId.value = data.grpId!;
                                            grpCnt.isshowGroup.value = true;
                                            blgCnt.selectedComment.value = -1;
                                            // setState(() {});
                                            await grpCnt.getGroupDetailsbyId();
                                          },
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          contentPadding: EdgeInsets.zero,
                                          leading: Obx(
                                            () => Text(
                                              "${data.grpName}",
                                              style: FontStyleUtilities.t2(
                                                  fontWeight: FWT.medium,
                                                  fontColor:
                                                      (grpCnt.groupId.value ==
                                                              data.grpId!)
                                                          ? AppColors.primary
                                                          : AppColors.black),
                                            ),
                                          ),
                                          trailing: Icon(
                                            Icons.account_circle,
                                            size: 28,
                                          ),
                                        );
                                      },
                                      itemCount: grpCnt.relatedGroupData.value
                                          .data!.group?.length,
                                    )
                                  : Text(
                                      "no_data_found".tr,
                                      style: FontStyleUtilities.t1(
                                          fontWeight: FWT.medium),
                                    ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // w30,
          Expanded(
            child: Obx(
              () => grpCnt.isLoading.value && grpCnt.commentload.value
                  ? Loader(message: "loading".tr)
                  : ListView(
                      physics: BouncingScrollPhysics(),
                      shrinkWrap: true,
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      children: [
                        Container(
                          width: Get.width,
                          // margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(
                                () => (grpCnt.isshowGroup.value)
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${grpCnt.groupDetail.value.data?.group?.grpName}",
                                            style: FontStyleUtilities.t1(
                                                fontWeight: FWT.medium),
                                          ),
                                          LargeButton(
                                            onPressed: () async {
                                              await grpCnt.joinGroup();
                                            },
                                            height: 30,
                                            width: 100,
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
                                        ],
                                      )
                                    : (grpCnt.groupDetail.value.data?.group
                                                ?.grpParticipants
                                                ?.contains(AppPreference()
                                                    .getInt(
                                                        PreferencesKey.uId)) ??
                                            false)
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${grpCnt.groupDetail.value.data?.group?.grpName}",
                                                style: FontStyleUtilities.h6(
                                                    fontWeight: FWT.medium),
                                              ),
                                              Spacer(),
                                              LargeButton(
                                                onPressed: () async {
                                                  await showDeleteGroupDialog(
                                                      context);
                                                },
                                                height: 40,
                                                width: 70,
                                                color: AppColors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Text(
                                                  "Delete Group",
                                                  style: FontStyleUtilities.t2(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.white),
                                                ),
                                              ),
                                              w10,
                                              LargeButton(
                                                onPressed: () async {
                                                  await showCreateGroupBlogDialog(
                                                      context);
                                                },
                                                height: 40,
                                                width: 60,
                                                color: AppColors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Text(
                                                  "Create Group Blog",
                                                  style: FontStyleUtilities.t2(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.white),
                                                ),
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "${grpCnt.groupDetail.value.data?.group?.grpName}",
                                                style: FontStyleUtilities.h6(
                                                    fontWeight: FWT.medium),
                                              ),
                                              Spacer(),
                                              LargeButton(
                                                onPressed: () async {
                                                  await grpCnt.exitGroup();
                                                },
                                                height: 40,
                                                width: 70,
                                                color: AppColors.red,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Text(
                                                  "Exit Group",
                                                  style: FontStyleUtilities.t2(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.white),
                                                ),
                                              ),
                                              w10,
                                              LargeButton(
                                                onPressed: () async {
                                                  await showCreateGroupBlogDialog(
                                                      context);
                                                },
                                                height: 40,
                                                width: 60,
                                                color: AppColors.primary,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                child: Text(
                                                  "Create Group Blog",
                                                  style: FontStyleUtilities.t2(
                                                      fontWeight: FWT.medium,
                                                      fontColor:
                                                          AppColors.white),
                                                ),
                                              ),
                                            ],
                                          ),
                              ),
                              Divider(
                                  color: AppColors.grey,
                                  thickness: 2,
                                  height: 0),
                              if (grpCnt.groupDetail.value.data != null)
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 20),
                                  child: Obx(
                                    () => (grpCnt.isloadingrelatedGrp.value)
                                        ? Center(
                                            child: CircularProgressIndicator(),
                                          )
                                        : (grpCnt
                                                .groupDetail
                                                .value
                                                .data!
                                                .group!
                                                .grpParticipantsDetails!
                                                .isEmpty)
                                            ? Text(
                                                "no_data_found".tr,
                                                style: FontStyleUtilities.t1(
                                                    fontWeight: FWT.medium),
                                              )
                                            : SizedBox(
                                                height: 60,
                                                child: ListView.builder(
                                                  shrinkWrap: true,
                                                  physics:
                                                      NeverScrollableScrollPhysics(),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemBuilder: (context, i) {
                                                    var data = grpCnt
                                                        .groupDetail
                                                        .value
                                                        .data!
                                                        .group!
                                                        .grpParticipantsDetails?[i];
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 10),
                                                      child: Column(
                                                        mainAxisSize:
                                                            MainAxisSize.min,
                                                        children: [
                                                          CircleAvatar(
                                                              radius: 20,
                                                              backgroundImage:
                                                                  NetworkImage(
                                                                      "${ApiRoutes.imageURL}${data?.stProfilePic}")),
                                                          // h6,
                                                          Text(
                                                            "${data?.stFullName}",
                                                            style: FontStyleUtilities.t3(
                                                                fontWeight:
                                                                    FWT.medium,
                                                                fontColor:
                                                                    AppColors
                                                                        .black),
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
                                ),
                            ],
                          ),
                        ),
                        Obx(
                          () => (grpCnt.groupDetail.value.data != null &&
                                  grpCnt.groupDetail.value.data!.group!
                                      .grpBlogs!.isNotEmpty)
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  itemBuilder: (context, i) {
                                    var data = grpCnt.groupDetail.value.data
                                        ?.group?.grpBlogs?[i];
                                    return GroupWidget(
                                      blogData: data,
                                      cardindex: i,
                                      ontapComment: () async {
                                        blgCnt.commentDataList.clear();
                                        blgCnt.selectedComment.value =
                                            (blgCnt.selectedComment.value == i)
                                                ? -1
                                                : i;

                                        setState(() {});
                                        grpCnt.commentload.value = false;
                                        // data!.isshowComments =
                                        //     !data.isshowComments!;
                                        if (blgCnt.selectedComment.value == i) {
                                          blgCnt.blogId.value = data!.blId!;
                                          Future.delayed(
                                              Duration(milliseconds: 100), () {
                                            blgCnt.isLoadingComments.value =
                                                true;
                                          });
                                          await blgCnt.getAllCommentsbyId();
                                        }
                                        // log("${blgCnt.selectedComment.value.toString()}====${data.isshowComments}");
                                      },
                                      ontapLike: () async {
                                        if (!data!.isLike!) {
                                          data.isLike = true;
                                          data.blLikeCount =
                                              data.blLikeCount! + 1;
                                          setState(() {});
                                          blgCnt.blogId.value = data.blId!;

                                          await blgCnt.likeBlog();
                                        }
                                      },
                                    );
                                  },
                                  itemCount: grpCnt.groupDetail.value.data
                                      ?.group?.grpBlogs?.length,
                                )
                              : Container(
                                  height: Get.height / 1.5,
                                  width: Get.width,
                                  alignment: Alignment.center,
                                  child: Text(
                                    "no_data_found".tr,
                                    style: FontStyleUtilities.h4(
                                        fontWeight: FWT.medium),
                                  ),
                                ),
                        ),
                      ],
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
