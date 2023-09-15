import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/blog_page/controller/blog_controller.dart';
import 'package:katon/screens/group_page/widgets/create_group_dialog.dart';
import 'package:katon/utils/config.dart';

import '../../../models/argument_model.dart';
import '../../../teacher/drawer.dart';
import '../../../utils/app_binding.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/prefs/app_preference.dart';
import '../../../widgets/button.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/drawer/drawer.dart';
import '../../../widgets/loader.dart';
import '../controller/group_controller.dart';

class GroupMobile extends StatefulWidget {
  final Arguments arguments;
  const GroupMobile({super.key, required this.arguments});

  @override
  State<GroupMobile> createState() => _GroupMobileState();
}

class _GroupMobileState extends State<GroupMobile> {
  final grpCnt = Get.find<GroupController>();
  final blgCnt = Get.put(BlogController());
  @override
  void initState() {
    super.initState();
    init();
  }

  Future init() async {
    await grpCnt.getGroupList();
    await grpCnt.getClassmateList();
    await grpCnt.getRelatedGroup();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbarMobile(title: widget.arguments.title),
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      // endDrawer: endDrawerMobile(),
      body: Obx(
        () => grpCnt.isLoading.value
            ? Loader(message: "loading".tr)
            : ListView(
                padding: EdgeInsets.all(20),
                physics: BouncingScrollPhysics(),
                children: [
                  Container(
                    width: Get.width,
                    // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),

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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "My Groups",
                                style: FontStyleUtilities.t1(
                                    fontWeight: FWT.medium),
                              ),
                              LargeButton(
                                onPressed: () async {
                                  await showCreateGroupDialog(context);
                                },
                                height: 30,
                                width: 60,
                                borderColor: AppColors.primary,
                                borderWidth: 1,
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.white,
                                child: Text(
                                  "New",
                                  style: FontStyleUtilities.t3(
                                      fontWeight: FWT.medium,
                                      fontColor: AppColors.primary),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: AppColors.grey, thickness: 2, height: 0),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
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
                                            onTap: () {
                                              grpCnt.groupId.value =
                                                  data.grpId!;
                                              grpCnt.isshowGroup.value = false;
                                              blgCnt.selectedComment.value =
                                                  1000;
                                              setState(() {});
                                              grpCnt.commentload.value = true;
                                              navigatorKey.currentState!
                                                  .pushNamed(
                                                      RoutesConst.groupdetails);
                                            },
                                            visualDensity: VisualDensity(
                                                horizontal: -4, vertical: -4),
                                            contentPadding: EdgeInsets.zero,
                                            leading: Text(
                                              "${data?.grpName}",
                                              style: FontStyleUtilities.t3(
                                                  fontWeight: FWT.medium,
                                                  fontColor:
                                                      (grpCnt.groupId.value ==
                                                              data!.grpId)
                                                          ? AppColors.primary
                                                          : AppColors.black),
                                            ),
                                            trailing:
                                                Icon(Icons.account_circle),
                                          );
                                        },
                                        itemCount: grpCnt.groupList.value.data
                                            ?.group?.length,
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
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Groups",
                                style: FontStyleUtilities.t1(
                                    fontWeight: FWT.medium),
                              ),
                            ],
                          ),
                        ),
                        Divider(color: AppColors.grey, thickness: 2, height: 0),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: (grpCnt.isloadingrelatedGrp.value)
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : (grpCnt.relatedGroupData.value.data != null &&
                                      grpCnt.relatedGroupData.value.data!.group!
                                          .isNotEmpty)
                                  ? ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        var data = grpCnt.relatedGroupData.value
                                            .data!.group![i];
                                        return ListTile(
                                          onTap: () async {
                                            grpCnt.groupId.value = data.grpId!;
                                            grpCnt.isshowGroup.value = true;
                                            blgCnt.selectedComment.value = -1;
                                            setState(() {});
                                            grpCnt.commentload.value = true;
                                            await grpCnt.getGroupDetailsbyId();
                                            navigatorKey.currentState!
                                                .pushNamed(
                                                    RoutesConst.groupdetails);
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
                                        // return Padding(
                                        //   padding:
                                        //       const EdgeInsets.only(right: 10),
                                        //   child: Column(
                                        //     mainAxisSize: MainAxisSize.min,
                                        //     children: [
                                        //       Text(
                                        //         "${data.grpName}",
                                        //         style: FontStyleUtilities.t2(
                                        //             fontWeight: FWT.medium,
                                        //             fontColor: AppColors.black),
                                        //       ),
                                        //       // h6,
                                        //       Text(
                                        //         "${data.grpDesc}",
                                        //         style: FontStyleUtilities.t3(
                                        //             fontWeight: FWT.regular,
                                        //             fontColor: AppColors.black),
                                        //       ),
                                        //     ],
                                        //   ),
                                        // );
                                      },
                                      itemCount: grpCnt.relatedGroupData.value
                                          .data!.group!.length,
                                    )
                                  : Text(
                                      "no_data_found".tr,
                                      style: FontStyleUtilities.t1(
                                          fontWeight: FWT.medium),
                                    ),
                        ),
                      ],
                    ),
                  ),
                  // h20,
                  // Container(
                  //   width: Get.width,
                  //   // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),

                  //   decoration: BoxDecoration(
                  //     color: AppColors.white,
                  //     // borderRadius: BorderRadius.circular(10),
                  //     boxShadow: [
                  //       BoxShadow(
                  //           color: AppColors.grey,
                  //           blurRadius: 4,
                  //           spreadRadius: 2),
                  //     ],
                  //   ),
                  //   child: Column(
                  //     children: [
                  //       Padding(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 15, vertical: 15),
                  //         child: Row(
                  //           mainAxisAlignment: MainAxisAlignment.start,
                  //           children: [
                  //             Text(
                  //               "Classmates",
                  //               style: FontStyleUtilities.t1(
                  //                   fontWeight: FWT.medium),
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //       Divider(color: AppColors.grey, thickness: 2, height: 0),
                  //       Padding(
                  //         padding: EdgeInsets.symmetric(
                  //             horizontal: 15, vertical: 15),
                  //         child: (grpCnt.isloadingclassmate.value)
                  //             ? Center(
                  //                 child: CircularProgressIndicator(),
                  //               )
                  //             : (grpCnt.classmateData.value.data != null &&
                  //                     grpCnt.classmateData.value.data!.student!
                  //                         .isNotEmpty)
                  //                 ? ListView.builder(
                  //                     shrinkWrap: true,
                  //                     physics: NeverScrollableScrollPhysics(),
                  //                     itemBuilder: (context, i) {
                  //                       var data = grpCnt.classmateData.value
                  //                           .data?.student?[i];
                  //                       return ListTile(
                  //                         onTap: () {},
                  //                         visualDensity: VisualDensity(
                  //                             horizontal: -4, vertical: -4),
                  //                         contentPadding: EdgeInsets.zero,
                  //                         leading: CircleAvatar(
                  //                           radius: 16,
                  //                           backgroundImage: NetworkImage(
                  //                               "${ApiRoutes.imageURL}${data?.stProfilePic}"),
                  //                         ),
                  //                         title: Text(
                  //                           "${data?.stFullName}",
                  //                           style: FontStyleUtilities.t3(
                  //                               fontWeight: FWT.medium,
                  //                               fontColor: AppColors.black),
                  //                         ),
                  //                       );
                  //                     },
                  //                     itemCount: grpCnt.classmateData.value.data
                  //                         ?.student?.length,
                  //                   )
                  //                 : Text(
                  //                     "no_data_found".tr,
                  //                     style: FontStyleUtilities.t1(
                  //                         fontWeight: FWT.medium),
                  //                   ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
      ),
    );
  }
}
