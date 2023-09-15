import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/blog_model/blog_model.dart';
import 'package:katon/res.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/text_field.dart';
import '../../../models/comment_model/comment_detail_model.dart';
import '../../../network/api_constants.dart';
import '../../../utils/validators.dart';
import '../../../widgets/network_image/cached_network_image.dart';
import '../../../widgets/responsive.dart';
import '../../blog_page/controller/blog_controller.dart';
import 'package:flutter/foundation.dart' as foundation;

Future addCommentDialog(BuildContext context, {required BlogRow blogData}) {
  // final createBlogKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return AddCommentDialog(
        blogData: blogData,
      );
    },
  );
}

class AddCommentDialog extends StatefulWidget {
  final BlogRow blogData;
  const AddCommentDialog({super.key, required this.blogData});

  @override
  State<AddCommentDialog> createState() => _AddCommentDialogState();
}

class _AddCommentDialogState extends State<AddCommentDialog> {
  final blgCnt = Get.find<BlogController>();
  ScrollController scrollcontroller = new ScrollController();
  RxBool emojiShowing = false.obs;
  RxBool isKeyboardShow = false.obs;
  FocusNode _myNode = FocusNode();

  _listener() {
    if (_myNode.hasFocus) {
      isKeyboardShow.value = true;
      // emojiShowing.value = false;
      // Future.delayed(Duration(milliseconds: 10), () {
      //   scrollcontroller
      //     ..addListener(() {
      //       log("listner call----");
      //       scrollcontroller.jumpTo(
      //         scrollcontroller.position.maxScrollExtent,
      //       );
      //     });
      // });
      print("keyboard-------${isKeyboardShow.value}");
      // keyboard appeared
    } else {
      isKeyboardShow.value = false;
      print("keyboard-------${isKeyboardShow.value}");
      // keyboard dismissed
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
      log("call ----");
      _myNode..addListener(_listener);
    });
  }

  init() async {
    await blgCnt.getAllCommentsbyId();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: (Responsive.isMobilenew(context))
          ? EdgeInsets.symmetric(horizontal: 30)
          : EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: (Responsive.isMobilenew(context))
          ? Container(
              width: 600,
              // height: 350,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              // padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            // color: AppColors.primaryBlack,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Spacer(),
                            Text(
                              "${widget.blogData.blCreatorName}'s Post",
                              style:
                                  FontStyleUtilities.h5(fontWeight: FWT.medium),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.close,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1, height: 0),
                    ],
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      controller: scrollcontroller,
                      padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      physics: BouncingScrollPhysics(),
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NetworkImageWidget(
                                height: 42,
                                width: 42,
                                borderRadius: BorderRadius.circular(100),
                                fit: BoxFit.cover,
                                imageUrl:
                                    "${ApiRoutes.imageURL}${widget.blogData.blCreatorPic}"),
                            w8,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h12,
                                  Text(
                                    "${widget.blogData.blCreatorName}",
                                    style: AppTextStyle.normalBold10.copyWith(
                                      color: AppColors.primaryBlack,
                                    ),
                                  ),
                                  h2,
                                  Text(
                                    "${widget.blogData.blDesc}",
                                    style:
                                        AppTextStyle.normalRegular10.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  h4,
                                  Row(
                                    children: [
                                      Text(
                                        "#Katon",
                                        style: AppTextStyle.normalRegular10
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.blueColor),
                                      ),
                                      w4,
                                      Text(
                                        "#360 Knowledge",
                                        style: AppTextStyle.normalRegular10
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.blueColor),
                                      ),
                                    ],
                                  ),
                                  if (widget.blogData.blImage != null) h5,
                                  if (widget.blogData.blImage != null)
                                    NetworkImageWidget(
                                      height: 180,
                                      width: Get.width,
                                      fit: BoxFit.fill,
                                      imageUrl:
                                          "${ApiRoutes.imageURL}${widget.blogData.blImage}",
                                    ),
                                  h10,
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${DateFormat('MMMM d, HH:mm a').format(DateTime.parse(widget.blogData!.blCreatedAt.toString())).toString()}",
                                      style:
                                          AppTextStyle.normalRegular10.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textgreyColor,
                                      ),
                                    ),
                                  ),
                                  h10,
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            widget.blogData.isLike!
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: AppColors.red,
                                                  )
                                                : Icon(Icons.favorite_outline),
                                            w6,
                                            Text(
                                              "${widget.blogData.blLikeCount} Like",
                                              style: AppTextStyle
                                                  .normalRegular10
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textgreyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      w10,
                                      GestureDetector(
                                        onTap: () async {},
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 5,
                                            vertical: 5,
                                          ),
                                          child: Row(
                                            children: [
                                              Image.asset(
                                                AppAssets.ic_message,
                                                height: 16,
                                              ),
                                              w6,
                                              Text(
                                                "${widget.blogData.blCommentCount}",
                                                style: AppTextStyle
                                                    .normalRegular10
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.textgreyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      w10,
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 5,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AppAssets.ic_share_connect,
                                              height: 16,
                                            ),
                                            w6,
                                            Text(
                                              "Share",
                                              style: AppTextStyle
                                                  .normalRegular10
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textgreyColor,
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
                            w14,
                          ],
                        ),
                        h10,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          // color: AppColors.backGroundColor,
                          height:
                              blgCnt.commentDataList.length >= 4 ? 200 : null,
                          child: Obx(
                            () => (blgCnt.isLoadingComments.value)
                                ? Center(
                                    // key: ValueKey("${widget.cardindex}"),
                                    child: CircularProgressIndicator(),
                                  )
                                : (blgCnt.commentDataList.isNotEmpty &&
                                        blgCnt.commentData.value.data != null)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          var data = blgCnt.commentDataList[i];
                                          return commentWidget(context,
                                              data: data);
                                        },
                                        itemCount:
                                            blgCnt.commentDataList.length,
                                      )
                                    : Center(
                                        child: Text("no_comments".tr),
                                      ),
                          ),
                        ),
                        // h10,
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Form(
                      key: blgCnt.blogcommenttabKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: textFormField(
                                focusNode: _myNode,
                                scropadding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        30),
                                controller: blgCnt.comment.value,
                                hintText: "What’s on your mind?",
                                validator: (val) => Validators.validaterequired(
                                    val, "please_add_comment".tr),
                                filledColor: AppColors.boxgrey,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    primaryFocus?.unfocus();
                                    emojiShowing.value = !emojiShowing.value;
                                  },
                                  child: Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Image.asset(
                                        AppAssets.ic_smile_emoji,
                                        height: 8,
                                        color: emojiShowing.value
                                            ? AppColors.primaryBlack
                                            : AppColors.gray909090,
                                      ),
                                    ),
                                  ),
                                ),
                                maxLines: 1,
                                onChanged: (val) {
                                  scrollcontroller.animateTo(
                                    duration: Duration(milliseconds: 10),
                                    curve: Curves.linear,
                                    scrollcontroller.position.maxScrollExtent,
                                  );
                                },
                                onFieldSubmitted: (val) {}),
                          ),
                          w10,
                          GestureDetector(
                            onTap: () async {
                              if (blgCnt.blogcommenttabKey.currentState!
                                  .validate()) {
                                widget.blogData.blCommentCount =
                                    widget.blogData.blCommentCount! + 1;

                                setState(() {});
                                await blgCnt.addComment();
                                primaryFocus?.unfocus();
                              }
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.all(15),
                              color: AppColors.primaryBlack,
                              child: Image.asset(AppAssets.ic_send,
                                  color: AppColors.primaryWhite, height: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() => emojiShowing.value
                      ? Padding(
                          padding:
                              EdgeInsets.only(left: 20, right: 20, bottom: 20),
                          child: buildEmoji(),
                        )
                      : Container()),
                ],
              ),
            )
          : Container(
              width: 600,
              // height: 350,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              // padding: EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20.0),
                        decoration: BoxDecoration(
                            // color: AppColors.primaryBlack,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Spacer(),
                            Text(
                              "${widget.blogData.blCreatorName}'s Post",
                              style:
                                  FontStyleUtilities.h5(fontWeight: FWT.medium),
                            ),
                            Spacer(),
                            GestureDetector(
                              onTap: () {
                                Get.back();
                              },
                              child: Icon(
                                Icons.close,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider(thickness: 1, height: 0),
                    ],
                  ),
                  Flexible(
                    child: ListView(
                      shrinkWrap: true,
                      controller: scrollcontroller,
                      padding: EdgeInsets.fromLTRB(35, 20, 35, 0),
                      physics: BouncingScrollPhysics(),
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NetworkImageWidget(
                                height: 42,
                                width: 42,
                                borderRadius: BorderRadius.circular(100),
                                fit: BoxFit.cover,
                                imageUrl:
                                    "${ApiRoutes.imageURL}${widget.blogData.blCreatorPic}"),
                            w8,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  h12,
                                  Text(
                                    "${widget.blogData.blCreatorName}",
                                    style: AppTextStyle.normalBold10.copyWith(
                                      color: AppColors.primaryBlack,
                                    ),
                                  ),
                                  h2,
                                  Text(
                                    "${widget.blogData.blDesc}",
                                    style:
                                        AppTextStyle.normalRegular10.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  h4,
                                  Row(
                                    children: [
                                      Text(
                                        "#Katon",
                                        style: AppTextStyle.normalRegular10
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.blueColor),
                                      ),
                                      w4,
                                      Text(
                                        "#360 Knowledge",
                                        style: AppTextStyle.normalRegular10
                                            .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.blueColor),
                                      ),
                                    ],
                                  ),
                                  if (widget.blogData.blImage != null) h5,
                                  if (widget.blogData.blImage != null)
                                    NetworkImageWidget(
                                      height: 180,
                                      width: Get.width,
                                      fit: BoxFit.fill,
                                      imageUrl:
                                          "${ApiRoutes.imageURL}${widget.blogData.blImage}",
                                    ),
                                  h10,
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      "${DateFormat('MMMM d, HH:mm a').format(DateTime.parse(widget.blogData!.blCreatedAt.toString())).toString()}",
                                      style:
                                          AppTextStyle.normalRegular10.copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.textgreyColor,
                                      ),
                                    ),
                                  ),
                                  h10,
                                  Row(
                                    children: [
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            widget.blogData.isLike!
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: AppColors.red,
                                                  )
                                                : Icon(Icons.favorite_outline),
                                            w6,
                                            Text(
                                              "${widget.blogData.blLikeCount} Like",
                                              style: AppTextStyle
                                                  .normalRegular10
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textgreyColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      w20,
                                      GestureDetector(
                                        onTap: () async {},
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
                                              w6,
                                              Text(
                                                "${widget.blogData.blCommentCount} Comment",
                                                style: AppTextStyle
                                                    .normalRegular10
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      AppColors.textgreyColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      w20,
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 5,
                                        ),
                                        child: Row(
                                          children: [
                                            Image.asset(
                                              AppAssets.ic_share_connect,
                                              height: 16,
                                            ),
                                            w6,
                                            Text(
                                              "Share",
                                              style: AppTextStyle
                                                  .normalRegular10
                                                  .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.textgreyColor,
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
                            w14,
                          ],
                        ),
                        h10,
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 35),
                          // color: AppColors.backGroundColor,
                          // height: 200,
                          child: Obx(
                            () => (blgCnt.isLoadingComments.value)
                                ? Center(
                                    // key: ValueKey("${widget.cardindex}"),
                                    child: CircularProgressIndicator(),
                                  )
                                : (blgCnt.commentDataList.isNotEmpty &&
                                        blgCnt.commentData.value.data != null)
                                    ? ListView.builder(
                                        shrinkWrap: true,
                                        physics: BouncingScrollPhysics(),
                                        itemBuilder: (context, i) {
                                          var data = blgCnt.commentDataList[i];
                                          return commentWidget(context,
                                              data: data);
                                        },
                                        itemCount:
                                            blgCnt.commentDataList.length,
                                      )
                                    : Center(
                                        child: Text("no_comments".tr),
                                      ),
                          ),
                        ),
                        // h10,
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    child: Form(
                      key: blgCnt.blogcommenttabKey,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: textFormField(
                                focusNode: _myNode,
                                scropadding: EdgeInsets.only(
                                    bottom: MediaQuery.of(context)
                                            .viewInsets
                                            .bottom +
                                        30),
                                controller: blgCnt.comment.value,
                                hintText: "What’s on your mind?",
                                validator: (val) => Validators.validaterequired(
                                    val, "please_add_comment".tr),
                                filledColor: AppColors.boxgrey,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    primaryFocus?.unfocus();
                                    emojiShowing.value = !emojiShowing.value;
                                  },
                                  child: Obx(
                                    () => Padding(
                                      padding: const EdgeInsets.all(14.0),
                                      child: Image.asset(
                                        AppAssets.ic_smile_emoji,
                                        height: 8,
                                        color: emojiShowing.value
                                            ? AppColors.primaryBlack
                                            : AppColors.gray909090,
                                      ),
                                    ),
                                  ),
                                ),
                                maxLines: 1,
                                onChanged: (val) {
                                  scrollcontroller.animateTo(
                                    duration: Duration(milliseconds: 10),
                                    curve: Curves.linear,
                                    scrollcontroller.position.maxScrollExtent,
                                  );
                                },
                                onFieldSubmitted: (val) {}),
                          ),
                          w10,
                          GestureDetector(
                            onTap: () async {
                              if (blgCnt.blogcommenttabKey.currentState!
                                  .validate()) {
                                widget.blogData.blCommentCount =
                                    widget.blogData.blCommentCount! + 1;
                                await blgCnt.addComment();
                                primaryFocus?.unfocus();
                              }
                            },
                            child: Container(
                              height: 50,
                              padding: EdgeInsets.all(15),
                              color: AppColors.primaryBlack,
                              child: Image.asset(AppAssets.ic_send,
                                  color: AppColors.primaryWhite, height: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Obx(() => emojiShowing.value
                      ? Padding(
                          padding:
                              EdgeInsets.only(left: 30, right: 30, bottom: 20),
                          child: buildEmoji())
                      : Container()),
                ],
              ),
            ),
    );
  }

  Widget buildEmoji() {
    return (Responsive.isMobilenew(context))
        ? SizedBox(
            height: 250,
            child: Material(
                // height: 250,

                child: EmojiPicker(
              textEditingController: blgCnt.blogDesc.value,
              onBackspacePressed: () {
                // emojiShowing.value = false;
              },
              config: Config(
                columns: 7,
                emojiSizeMax: 32 *
                    (foundation.defaultTargetPlatform == TargetPlatform.iOS
                        ? 1.30
                        : 0.6),
                verticalSpacing: 0,
                horizontalSpacing: 0,
                gridPadding: EdgeInsets.zero,
                initCategory: Category.RECENT,
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                recentTabBehavior: RecentTabBehavior.RECENT,
                recentsLimit: 28,
                replaceEmojiOnLimitExceed: false,
                noRecents: const Text(
                  'No Recents',
                  style: TextStyle(fontSize: 16, color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
                loadingIndicator: const SizedBox.shrink(),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
                checkPlatformCompatibility: true,
              ),
            )),
          )
        : SizedBox(
            height: 250,
            child: Material(
                // height: 250,

                child: EmojiPicker(
              textEditingController: blgCnt.comment.value,
              onBackspacePressed: () {
                // emojiShowing.value = false;
              },
              config: Config(
                columns: 7,
                emojiSizeMax: 32 *
                    (foundation.defaultTargetPlatform == TargetPlatform.iOS
                        ? 1.30
                        : 1.0),
                verticalSpacing: 0,
                horizontalSpacing: 0,
                gridPadding: EdgeInsets.zero,
                initCategory: Category.RECENT,
                bgColor: const Color(0xFFF2F2F2),
                indicatorColor: Colors.blue,
                iconColor: Colors.grey,
                iconColorSelected: Colors.blue,
                backspaceColor: Colors.blue,
                skinToneDialogBgColor: Colors.white,
                skinToneIndicatorColor: Colors.grey,
                enableSkinTones: true,
                recentTabBehavior: RecentTabBehavior.RECENT,
                recentsLimit: 28,
                replaceEmojiOnLimitExceed: false,
                noRecents: const Text(
                  'No Recents',
                  style: TextStyle(fontSize: 20, color: Colors.black26),
                  textAlign: TextAlign.center,
                ),
                loadingIndicator: const SizedBox.shrink(),
                tabIndicatorAnimDuration: kTabScrollDuration,
                categoryIcons: const CategoryIcons(),
                buttonMode: ButtonMode.MATERIAL,
                checkPlatformCompatibility: true,
              ),
            )),
          );
  }
}

Widget commentWidget(BuildContext context, {required Comment data}) {
  return (Responsive.isMobilenew(context))
      ? Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetworkImageWidget(
                  height: 42,
                  width: 42,
                  borderRadius: BorderRadius.circular(100),
                  fit: BoxFit.cover,
                  imageUrl: "${ApiRoutes.imageURL}${data.cmnProfilePic}"),
              w10,
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.gray200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data.cmnFullName}",
                        style: (Responsive.isMobilenew(context))
                            ? AppTextStyle.normalBold12
                                .copyWith(color: AppColors.primaryBlack)
                            : AppTextStyle.normalBold12
                                .copyWith(color: AppColors.primaryBlack),
                      ),
                      // Text(
                      //   "${DateFormat('yMMMMd').format(DateTime.parse(data.cmnCreatedAt.toString())).toString()}",
                      //   style: (Responsive.isMobilenew(context))
                      //       ? AppTextStyle.normalRegular12
                      //           .copyWith(color: AppColors.primaryBlack)
                      //       : AppTextStyle.normalRegular12
                      //           .copyWith(color: AppColors.primaryBlack),
                      // ),
                      // h4,
                      Text(
                        "${data.cmnComment}",
                        style: (Responsive.isMobilenew(context))
                            ? AppTextStyle.normalRegular10
                                .copyWith(color: AppColors.primaryBlack)
                            : AppTextStyle.normalRegular10
                                .copyWith(color: AppColors.primaryBlack),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        )
      : Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NetworkImageWidget(
                  height: 42,
                  width: 42,
                  borderRadius: BorderRadius.circular(100),
                  fit: BoxFit.cover,
                  imageUrl: "${ApiRoutes.imageURL}${data.cmnProfilePic}"),
              w10,
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.gray200),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${data.cmnFullName}",
                        style: (Responsive.isMobilenew(context))
                            ? AppTextStyle.normalBold14
                                .copyWith(color: AppColors.primaryBlack)
                            : AppTextStyle.normalBold14
                                .copyWith(color: AppColors.primaryBlack),
                      ),
                      // Text(
                      //   "${DateFormat('yMMMMd').format(DateTime.parse(data.cmnCreatedAt.toString())).toString()}",
                      //   style: (Responsive.isMobilenew(context))
                      //       ? AppTextStyle.normalRegular12
                      //           .copyWith(color: AppColors.primaryBlack)
                      //       : AppTextStyle.normalRegular12
                      //           .copyWith(color: AppColors.primaryBlack),
                      // ),
                      // h4,
                      Text(
                        "${data.cmnComment}",
                        style: (Responsive.isMobilenew(context))
                            ? AppTextStyle.normalRegular12
                                .copyWith(color: AppColors.primaryBlack)
                            : AppTextStyle.normalRegular12
                                .copyWith(color: AppColors.primaryBlack),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
}
