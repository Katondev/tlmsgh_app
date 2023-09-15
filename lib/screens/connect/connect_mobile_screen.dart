// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/components/image/image_widget.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/connect/widgets/connect_widget.dart';
import 'package:katon/screens/connect/widgets/create_blog_dialog.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/text_field.dart';
import '../../teacher/drawer.dart';
import '../../utils/app_colors.dart';
import '../../utils/constants.dart';
import '../../widgets/common_appbar.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/loader.dart';
import '../../widgets/no_data_found.dart';
import '../../widgets/no_internet.dart';
import '../blog_page/controller/blog_controller.dart';
import '../home_page.dart';

class ConnectMobileScreen extends StatefulWidget {
  final Arguments arguments;

  const ConnectMobileScreen({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<ConnectMobileScreen> createState() => _ConnectMobileScreenState();
}

class _ConnectMobileScreenState extends State<ConnectMobileScreen> {
  final blgCnt = Get.put(BlogController());
  // final editprofilecnt = Get.put(EditProfileCnt());
  final GlobalKey<FormState> createBlogKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), () {
      // blgCnt.selectedComment.value = -1;
      init();
    });
  }

  Future init() async {
    blgCnt.blogdataList.clear();
    blgCnt.blogPage.value = 1;
    await blgCnt.getBlogListwithpagination();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.boxgreyColor,
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      // endDrawer: endDrawer(),
      appBar: CommonAppbarMobile(title: widget.arguments.title),
      body: Obx(
        () => Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text(
                  //   "Connect",
                  //   style: AppTextStyle.normalBold28.copyWith(
                  //     color: AppColors.black,
                  //   ),
                  // ),
                  // h4,
                  Text(
                    "communicate and connect with friends and teachers",
                    style: AppTextStyle.normalRegular14.copyWith(
                      color: AppColors.textgrey,
                    ),
                  ),
                ],
              ),
              customHeight(15),
              Expanded(
                child: blgCnt.isLoading.value
                    ? Loader(message: "loading_wait".tr)
                    : blgCnt.connection
                        ? NoInternet(
                            // onTap: () => ePrv.resetOnTap(),
                            )
                        : (blgCnt.blogdataList.isEmpty)
                            ? NoDataFound(message: "no_book_found".tr)
                            : Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 3,
                                    child: SingleChildScrollView(
                                      physics: BouncingScrollPhysics(),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            // height: 200,
                                            width: Get.width,
                                            padding: EdgeInsets.all(15),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              color: AppColors.primaryWhite,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: AppColors
                                                        .boxShadowColor
                                                        .withOpacity(.15),
                                                    spreadRadius: 2,
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2))
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    // NetworkImageWidget(
                                                    //   height: 42,
                                                    //   width: 42,
                                                    //   imageUrl:
                                                    //       "${ApiRoutes.imageURL}${AppPreference().getString(PreferencesKey.profilePic)}",
                                                    //   borderRadius:
                                                    //       BorderRadius
                                                    //           .circular(100),
                                                    //   fit: BoxFit.cover,
                                                    // ),
                                                    // w10,
                                                    Expanded(
                                                      child: Column(
                                                        children: [
                                                          textFormField(
                                                            onTap: () async {
                                                              primaryFocus
                                                                  ?.unfocus();
                                                              await showAddBlogDialog(
                                                                  context);
                                                            },
                                                            controller: blgCnt
                                                                .blogDesc.value,
                                                            maxLines: 4,
                                                            hintText:
                                                                "Type here...",
                                                            borderRaduis: 5,
                                                            filledColor: AppColors
                                                                .textFieldColor2,
                                                          ),
                                                          h8,
                                                          Row(
                                                            children: [
                                                              w10,
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await showAddBlogDialog(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              5),
                                                                  child: Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        AppAssets
                                                                            .ic_gallary,
                                                                        height:
                                                                            18,
                                                                      ),
                                                                      w8,
                                                                      Text(
                                                                        "Pictures/videos",
                                                                        style: AppTextStyle
                                                                            .normalBold10
                                                                            .copyWith(
                                                                          // fontSize: 8,
                                                                          color:
                                                                              AppColors.textgreyColor,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              w20,
                                                              GestureDetector(
                                                                onTap:
                                                                    () async {
                                                                  await showAddBlogDialog(
                                                                      context);
                                                                },
                                                                child:
                                                                    Container(
                                                                  padding: EdgeInsets
                                                                      .symmetric(
                                                                          horizontal:
                                                                              5,
                                                                          vertical:
                                                                              5),
                                                                  child: Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        AppAssets
                                                                            .ic_smile_emoji,
                                                                        height:
                                                                            20,
                                                                      ),
                                                                      w8,
                                                                      Text(
                                                                        "Feelings/activity",
                                                                        style: AppTextStyle
                                                                            .normalBold10
                                                                            .copyWith(
                                                                          // fontSize: 8,
                                                                          color:
                                                                              AppColors.textgreyColor,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          //  Spacer(),
                                                          h16,
                                                          LargeButton(
                                                            onPressed:
                                                                () async {
                                                              await showAddBlogDialog(
                                                                  context);
                                                            },
                                                            height: 37,
                                                            width: Get.width,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        8),
                                                            child: Text(
                                                              "Create",
                                                              style: AppTextStyle
                                                                  .normalBold10
                                                                  .copyWith(
                                                                      fontSize:
                                                                          11),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          h22,
                                          Text(
                                            "New connects",
                                            style: AppTextStyle.normalBold14
                                                .copyWith(
                                                    color: AppColors
                                                        .textgreyColor),
                                          ),
                                          h8,
                                          Obx(
                                            () => ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, i) {
                                                if (i ==
                                                    blgCnt
                                                        .blogdataList.length) {
                                                  return (blgCnt.blogdataList
                                                              .length <
                                                          blgCnt
                                                              .blogData
                                                              .value
                                                              .data!
                                                              .blog!
                                                              .count!)
                                                      ? Column(
                                                          children: [
                                                            LargeButton(
                                                              onPressed: () {
                                                                blgCnt.blogPage
                                                                    .value++;
                                                                blgCnt
                                                                    .getBlogListwithpagination();
                                                              },
                                                              height: 40,
                                                              width: 120,
                                                              child: Text(
                                                                  "Load More"),
                                                            ),
                                                          ],
                                                        )
                                                      : SizedBox();
                                                }
                                                var data =
                                                    blgCnt.blogdataList[i];
                                                return ConnectWidget(
                                                  blogData: data,
                                                );
                                              },
                                              itemCount:
                                                  blgCnt.blogdataList.length +
                                                      1,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // w16,
                                  // Expanded(
                                  //   child: TrendingNowWidget(),
                                  // ),
                                ],
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
