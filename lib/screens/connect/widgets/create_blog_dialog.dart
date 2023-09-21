import 'dart:developer';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/res.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/text_field.dart';
import 'package:provider/provider.dart';
import '../../../network/api_constants.dart';
import '../../../utils/validators.dart';
import '../../../widgets/network_image/cached_network_image.dart';
import '../../../widgets/responsive.dart';
import '../../blog_page/controller/blog_controller.dart';
import 'package:flutter/foundation.dart' as foundation;

import '../../training/controller/training_prv.dart';

Future showAddBlogDialog(BuildContext context) {
  // final createBlogKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return AddBlogDialog();
    },
  );
}

class AddBlogDialog extends StatefulWidget {
  const AddBlogDialog({super.key});

  @override
  State<AddBlogDialog> createState() => _AddBlogDialogState();
}

class _AddBlogDialogState extends State<AddBlogDialog> {
  final blgCnt = Get.find<BlogController>();
  ScrollController scrollcontroller = ScrollController();
  final GlobalKey<FormState> createBlogKey = GlobalKey<FormState>();
  RxBool emojiShowing = false.obs;
  RxBool isKeyboardShow = false.obs;
  FocusNode _myNode = FocusNode();

  _listener() {
    if (_myNode.hasFocus) {
      isKeyboardShow.value = true;
      // emojiShowing.value = false;
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
        child: StatefulBuilder(
            builder: (context, setState) => Container(
                  width: 500,
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
                                  "Create a Post",
                                  style: FontStyleUtilities.h5(
                                      fontWeight: FWT.medium),
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
                          // Divider(thickness: 1, height: 0),
                        ],
                      ),
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          controller: scrollcontroller,
                          padding: (Responsive.isMobilenew(context))
                              ? EdgeInsets.fromLTRB(20, 10, 20, 20)
                              : EdgeInsets.fromLTRB(30, 10, 30, 30),
                          physics: BouncingScrollPhysics(),
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                NetworkImageWidget(
                                  height: 42,
                                  width: 42,
                                  borderRadius: BorderRadius.circular(100),
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${ApiRoutes.imageURL}${AppPreference().getString(PreferencesKey.profilePic)}",
                                ),
                                w12,
                                Text(
                                  "${AppPreference().getString(PreferencesKey.uName)}",
                                  style: AppTextStyle.normalBold14
                                      .copyWith(color: AppColors.primaryBlack),
                                ),
                              ],
                            ),
                            h14,
                            Form(
                              key: createBlogKey,
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
                                        controller: blgCnt.blogDesc.value,
                                        hintText: "What’s on your mind?",
                                        validator: (val) =>
                                            Validators.validaterequired(
                                                val, "please_add_comment".tr),
                                        filledColor: AppColors.boxgrey,
                                        suffixIcon: GestureDetector(
                                          onTap: () {
                                            primaryFocus?.unfocus();
                                            emojiShowing.value =
                                                !emojiShowing.value;
                                          },
                                          child: Obx(
                                            () => Padding(
                                              padding:
                                                  const EdgeInsets.all(14.0),
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
                                        maxLines: 4,
                                        onFieldSubmitted: (val) async {
                                          // if (blgCnt.blogcommenttabKey.currentState!
                                          //     .validate()) {
                                          //   widget.blogData.blCommentCount =
                                          //       widget.blogData.blCommentCount! + 1;
                                          //   await blgCnt.addComment();
                                          //   primaryFocus?.unfocus();
                                          // }
                                        }),
                                  ),
                                ],
                              ),
                            ),
                            h14,
                            Obx(() => emojiShowing.value
                                ? buildEmoji()
                                : Container()),
                            h8,
                            GestureDetector(
                              onTap: () {
                                blgCnt.pickImage();
                              },
                              child: Container(
                                height: 48,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.primaryBlack),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 30),
                                child: Row(
                                  children: [
                                    Text("Add your pictures here."),
                                    Spacer(),
                                    Image.asset(
                                      AppAssets.ic_gallary,
                                      height: 18,
                                      color: AppColors.primaryBlack
                                          .withOpacity(.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            h14,
                            LargeButton(
                              onPressed: () async {
                                if (createBlogKey.currentState!.validate()) {
                                  await blgCnt.addBlog();
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              height: 48,
                              width: Get.width,
                              child: Text("Create"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
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
              textEditingController: blgCnt.blogDesc.value,
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

Future uploadAddBlogDialog(BuildContext context) {
  // final createBlogKey = GlobalKey<FormState>();
  return showDialog(
    context: context,
    builder: (context) {
      return UploadBlogDialog();
    },
  );
}

class UploadBlogDialog extends StatefulWidget {
  const UploadBlogDialog({super.key});

  @override
  State<UploadBlogDialog> createState() => _UploadBlogDialogState();
}

class _UploadBlogDialogState extends State<UploadBlogDialog> {
  final Upload = Get.find<BlogController>();

  ScrollController scrollcontroller = ScrollController();
  final GlobalKey<FormState> createBlogKey = GlobalKey<FormState>();
  RxBool emojiShowing = false.obs;
  RxBool isKeyboardShow = false.obs;
  FocusNode _myNode = FocusNode();

  _listener() {
    if (_myNode.hasFocus) {
      isKeyboardShow.value = true;
      // emojiShowing.value = false;
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
    await Upload.getAllCommentsbyId();
  }

  @override
  Widget build(BuildContext context) {
    final tranningProvider = Provider.of<TrainingProvider>(context);
    return Dialog(
        insetPadding: (Responsive.isMobilenew(context))
            ? EdgeInsets.symmetric(horizontal: 30)
            : EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: StatefulBuilder(
            builder: (context, setState) => Container(
                  width: 500,
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
                                  "Upload Attestation",
                                  style: FontStyleUtilities.h5(
                                      fontWeight: FWT.medium),
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
                          // Divider(thickness: 1, height: 0),
                        ],
                      ),
                      Flexible(
                        child: ListView(
                          shrinkWrap: true,
                          controller: scrollcontroller,
                          padding: (Responsive.isMobilenew(context))
                              ? EdgeInsets.fromLTRB(20, 10, 20, 20)
                              : EdgeInsets.fromLTRB(30, 10, 30, 30),
                          physics: BouncingScrollPhysics(),
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Form(
                              key: createBlogKey,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                tranningProvider.pickFile();
                              },
                              child: Container(
                                height: 48,
                                width: Get.width,
                                decoration: BoxDecoration(
                                  border:
                                      Border.all(color: AppColors.primaryBlack),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 25),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    tranningProvider.selectedFile != null
                                        ? Expanded(
                                            child: Text(
                                                overflow: TextOverflow.ellipsis,
                                                'Selected File:${tranningProvider.selectedFile!.name}'),
                                          )
                                        : Text("Choose File"),
                                    Icon(Icons.upload_file)
                                  ],
                                ),
                              ),
                            ),
                            h14,
                            LargeButton(
                              onPressed: () async {
                                if (tranningProvider.selectedFile != null) {
                                  await tranningProvider.uploadFile(context);
                                  Navigator.pop(context);
                                } else {
                                  var snackBar = SnackBar( backgroundColor: AppColors.appbarRed, content: Text("Please Select a File"));
                                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                }
                              },
                              borderRadius: BorderRadius.circular(10),
                              height: 48,
                              width: Get.width,
                              child: Text("Submit"),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )));
  }
}
