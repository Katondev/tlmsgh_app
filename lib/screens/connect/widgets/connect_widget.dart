import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/blog_page/controller/blog_controller.dart';
import 'package:katon/screens/connect/widgets/add_comment_dialog.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';
import 'package:katon/widgets/network_image/cached_network_image.dart';

import '../../../components/app_text_style.dart';
import '../../../models/blog_model/blog_model.dart';
import '../../../res.dart';
import '../../../utils/app_colors.dart';
import '../../../utils/constants.dart';
import '../../../widgets/custom_dialog.dart';

class ConnectWidget extends StatefulWidget {
  final BlogRow? blogData;
  const ConnectWidget({super.key, this.blogData});

  @override
  State<ConnectWidget> createState() => _ConnectWidgetState();
}

class _ConnectWidgetState extends State<ConnectWidget> {
  final BlogController blgCnt = Get.find<BlogController>();
  showDeleteBlogDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return CustomDialog(
            message: "Are you sure you want to delete?",
            title1: "Yes".tr,
            title2: "No",
            onSecButtonTap: () => Navigator.of(context).pop(),
            onFirstButtonTap: () async {
              blgCnt.blogId.value = widget.blogData!.blId!;
              print("tapping--------${widget.blogData?.blId}");
              await blgCnt.deleteBlog();
              Get.back();
            },
            // child: Container(
            //   height: 100,
            //   width: 300,
            //   decoration: BoxDecoration(color: AppColors.white),
            // ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: AppColors.primaryWhite,
        boxShadow: [
          BoxShadow(
              color: AppColors.boxShadowColor.withOpacity(.15),
              spreadRadius: 4,
              blurRadius: 2,
              offset: Offset(0, 2))
        ],
      ),
      child: Column(
        children: [
          if (widget.blogData?.blCreatorId ==
              AppPreference().getInt(PreferencesKey.uId))
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () async {
                  await showDeleteBlogDialog(context);
                },
                child: Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Icon(Icons.close, size: 18),
                ),
              ),
            ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Container(
                  //   height: 42,
                  //   width: 42,
                  //   alignment: Alignment.center,
                  //   decoration: BoxDecoration(
                  //     shape: BoxShape.circle,
                  //     color: AppColors.avatarColor,
                  //   ),
                  //   child: Text(
                  //     "JK",
                  //     style: AppTextStyle.normalBold14.copyWith(
                  //       color: AppColors.primaryBlack,
                  //     ),
                  //   ),
                  // ),
                  NetworkImageWidget(
                      height: 42,
                      width: 42,
                      borderRadius: BorderRadius.circular(100),
                      fit: BoxFit.cover,
                      imageUrl:
                          "${ApiRoutes.imageURL}${widget.blogData?.blCreatorPic}"),
                  w8,
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        h12,
                        Text(
                          "${widget.blogData?.blCreatorName}",
                          style: AppTextStyle.normalBold10.copyWith(
                            color: AppColors.primaryBlack,
                          ),
                        ),
                        h2,
                        Text(
                          "${widget.blogData?.blDesc}",
                          style: AppTextStyle.normalRegular10.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        h4,
                        Row(
                          children: [
                            Text(
                              "#Katon",
                              style: AppTextStyle.normalRegular10.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blueColor),
                            ),
                            w4,
                            Text(
                              "#360 Knowledge",
                              style: AppTextStyle.normalRegular10.copyWith(
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blueColor),
                            ),
                          ],
                        ),
                        if (widget.blogData!.blImage != null) h5,
                        if (widget.blogData!.blImage != null)
                          NetworkImageWidget(
                            height: 180,
                            width: Get.width,
                            fit: BoxFit.fill,
                            imageUrl:
                                "${ApiRoutes.imageURL}${widget.blogData?.blImage}",
                          ),
                      ],
                    ),
                  ),
                  w14,
                ],
              ),
              h10,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (!widget.blogData!.isLike!) {
                          widget.blogData!.isLike = true;
                          widget.blogData!.blLikeCount =
                              widget.blogData!.blLikeCount! + 1;
                          setState(() {});
                          blgCnt.blogId.value = widget.blogData!.blId!;

                          await blgCnt.likeBlog();
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            widget.blogData!.isLike!
                                ? Icon(
                                    Icons.favorite,
                                    color: AppColors.red,
                                  )
                                : Icon(Icons.favorite_outline),
                            w4,
                            Text(
                              "${widget.blogData?.blLikeCount}",
                              style: AppTextStyle.normalRegular10.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textgreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // w4,
                    GestureDetector(
                      onTap: () async {
                        blgCnt.blogId.value = widget.blogData!.blId!;
                        await addCommentDialog(context,
                            blogData: widget.blogData!);
                        setState(() {});
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 5,
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              AppAssets.ic_message,
                              height: 16,
                            ),
                            w4,
                            Text(
                              "${widget.blogData?.blCommentCount}",
                              style: AppTextStyle.normalRegular10.copyWith(
                                fontWeight: FontWeight.w500,
                                color: AppColors.textgreyColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // w4,
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 5,
                      ),
                      child: Image.asset(
                        AppAssets.ic_share_connect,
                        height: 16,
                      ),
                    ),
                    Spacer(),
                    Text(
                      "${DateFormat('MMMM d, HH:mm a').format(DateTime.parse(widget.blogData!.blCreatedAt.toString())).toString()}",
                      style: AppTextStyle.normalRegular10.copyWith(
                        fontWeight: FontWeight.w500,
                        color: AppColors.textgreyColor,
                      ),
                    ),
                    // Text(
                    //   "Today 08:41 AM",
                    //   style: AppTextStyle.normalRegular10.copyWith(
                    //     fontWeight: FontWeight.w500,
                    //     color: AppColors.textgreyColor,
                    //   ),
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
