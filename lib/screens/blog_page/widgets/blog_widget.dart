import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/blog_page/controller/blog_controller.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/widgets/text_field.dart';
import 'package:katon/utils/config.dart';

import '../../../models/blog_model/blog_model.dart';
import '../../../models/comment_model/comment_detail_model.dart';
import '../../../utils/validators.dart';
import '../../../widgets/expandable_text.dart';
import '../../../widgets/network_image/cached_network_image.dart';
import '../../../widgets/responsive.dart';

class BlogWidget extends StatefulWidget {
  final int cardindex;
  final BlogRow? blogData;
  final void Function()? ontapComment;
  final void Function()? ontapLike;
  const BlogWidget({
    super.key,
    required this.cardindex,
    this.blogData,
    this.ontapComment,
    this.ontapLike,
  });

  @override
  State<BlogWidget> createState() => _BlogWidgetState();
}

class _BlogWidgetState extends State<BlogWidget> {
  final blgCnt = Get.find<BlogController>();
  final blogcommentKey = GlobalKey<FormState>();
  final blogcommenttabKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return (Responsive.isMobilenew(context))
        ? Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: AppColors.grey, blurRadius: 4, spreadRadius: 2),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.blogData!.blImage != null)
                  // Container(
                  //   width: Get.width,
                  //   height: 160,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //         image: NetworkImage(
                  //             "${ApiRoutes.imageURL}${blogData!.blImage}"),
                  //         fit: BoxFit.cover),
                  //   ),
                  // ),
                  NetworkImageWidget(
                    height: 150,
                    width: Get.width,
                    fit: BoxFit.cover,
                    imageUrl:
                        "${ApiRoutes.imageURL}${widget.blogData!.blImage}",
                  ),
                h10,
                Text(
                  "${widget.blogData!.blTitle}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyleUtilities.h6(fontWeight: FWT.medium),
                ),
                // h6,
                ExpandableText(
                  "${widget.blogData!.blDesc}",
                  trimLines: 1,
                ),
                // Text(
                //   "$description",
                //   maxLines: 1,
                //   style: FontStyleUtilities.t2(fontWeight: FWT.regular),
                // ),
                h10,
                Divider(),
                h10,
                SizedBox(
                  width: 150,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 13,
                        backgroundImage: NetworkImage(
                          "${ApiRoutes.imageURL}${widget.blogData!.blCreatorPic}",
                        ),
                      ),
                      w4,
                      Expanded(
                        child: Text(
                          "${widget.blogData!.blCreatorName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: FontStyleUtilities.t3(fontWeight: FWT.medium),
                        ),
                      ),
                    ],
                  ),
                ),
                h20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 110,
                      // color: AppColors.blue,
                      child: iconwithText(
                        context: context,
                        icon: Icons.calendar_month_rounded,
                        title:
                            "${intl.DateFormat('MMM d, yyyy').format(DateTime.parse(widget.blogData!.blCreatedAt.toString())).toString()}",
                        ontap: () {},
                      ),
                    ),
                    w20,
                    SizedBox(
                      width: 80,
                      // color: AppColors.blue,
                      child: iconwithText(
                        context: context,
                        icon: Icons.thumb_up,
                        title: "Like",
                        blogData: widget.blogData!,
                        selectedIndex: widget.blogData!.isLike ?? false,
                        ontap: widget.ontapLike,
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      // color: AppColors.blue,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          iconwithText(
                            context: context,
                            selectedIndex: blgCnt.selectedComment.value ==
                                widget.cardindex,
                            icon: Icons.message_rounded,
                            title: widget.blogData!.blCommentCount == 0
                                ? "Comment"
                                : "${widget.blogData!.blCommentCount}",
                            ontap: widget.ontapComment,
                          ),
                        ],
                      ),
                    ),
                    // h10,
                  ],
                ),
                if (blgCnt.selectedComment.value == widget.cardindex) h20,
                if (blgCnt.selectedComment.value == widget.cardindex)
                  Column(
                    children: [
                      Form(
                        key: blogcommentKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: TextBox(
                              hint: "Add Comment",
                              controller: blgCnt.comment.value,
                              validator: (val) => Validators.validaterequired(
                                  val, "please_add_comment".tr),
                              fillColor: AppColors.boxgrey,
                            )),
                            w10,
                            LargeButton(
                              onPressed: () async {
                                if (blogcommentKey.currentState!.validate()) {
                                  widget.blogData!.blCommentCount =
                                      widget.blogData!.blCommentCount! + 1;
                                  setState(() {});
                                  await blgCnt.addComment();
                                  primaryFocus?.unfocus();
                                }
                              },
                              child: Text("Post"),
                              height: 50,
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                      h20,
                      Obx(
                        () => (blgCnt.isLoadingComments.value)
                            ? Center(
                                child: CircularProgressIndicator(),
                              )
                            : (blgCnt.commentDataList.isNotEmpty)
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, i) {
                                      var data = blgCnt.commentDataList[i];
                                      return commentWidget(context, data: data);
                                    },
                                    itemCount: blgCnt.commentDataList.length,
                                  )
                                : Center(
                                    child: Text("no_comments".tr),
                                  ),
                      )
                    ],
                  ),
              ],
            ),
          )
        : Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            margin: EdgeInsets.symmetric(vertical: 15),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: AppColors.grey, blurRadius: 4, spreadRadius: 2),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (widget.blogData!.blImage != null)
                  NetworkImageWidget(
                    height: 250,
                    width: Get.width,
                    fit: BoxFit.cover,
                    imageUrl:
                        "${ApiRoutes.imageURL}${widget.blogData!.blImage}",
                  ),
                h10,
                Text(
                  "${widget.blogData!.blTitle}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: FontStyleUtilities.h6(fontWeight: FWT.medium),
                ),
                // h6,
                ExpandableText(
                  "${widget.blogData!.blDesc}",
                  trimLines: 1,
                ),
                // Text(
                //   "$description",
                //   maxLines: 1,
                //   style: FontStyleUtilities.t2(fontWeight: FWT.regular),
                // ),
                h10,
                Divider(),
                h10,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      width: 130,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundImage: NetworkImage(
                              "${ApiRoutes.imageURL}${widget.blogData!.blCreatorPic}",
                            ),
                          ),
                          w6,
                          Expanded(
                            child: Text(
                              "${widget.blogData!.blCreatorName}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style:
                                  FontStyleUtilities.t2(fontWeight: FWT.medium),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: iconwithText(
                        context: context,
                        icon: Icons.calendar_month_rounded,
                        title:
                            "${intl.DateFormat('MMM d, yyyy').format(DateTime.parse(widget.blogData!.blCreatedAt.toString())).toString()}",
                        ontap: () {},
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: iconwithText(
                        context: context,
                        icon: Icons.thumb_up,
                        title: "Like",
                        blogData: widget.blogData!,
                        selectedIndex: widget.blogData!.isLike ?? false,
                        ontap: widget.ontapLike,
                      ),
                    ),
                    SizedBox(
                      width: 130,
                      child: iconwithText(
                        context: context,
                        selectedIndex:
                            blgCnt.selectedComment.value == widget.cardindex,
                        icon: Icons.message_rounded,
                        title: widget.blogData!.blCommentCount == 0
                            ? "Comment"
                            : "${widget.blogData!.blCommentCount}",
                        ontap: widget.ontapComment,
                      ),
                    ),
                    // h10,
                  ],
                ),
                if (blgCnt.selectedComment.value == widget.cardindex) h20,
                if (blgCnt.selectedComment.value == widget.cardindex)
                  Column(
                    children: [
                      Form(
                        key: blogcommenttabKey,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                child: TextBox(
                              controller: blgCnt.comment.value,
                              hint: "Add Comment",
                              validator: (val) => Validators.validaterequired(
                                  val, "please_add_comment".tr),
                              fillColor: AppColors.boxgrey,
                            )),
                            w10,
                            LargeButton(
                              onPressed: () async {
                                if (blogcommenttabKey.currentState!
                                    .validate()) {
                                  widget.blogData!.blCommentCount =
                                      widget.blogData!.blCommentCount! + 1;
                                  await blgCnt.addComment();
                                  primaryFocus?.unfocus();
                                }
                              },
                              child: Text("Post"),
                              height: 50,
                              width: 50,
                            ),
                          ],
                        ),
                      ),
                      h20,
                      Obx(
                        () => (blgCnt.isLoadingComments.value)
                            ? Center(
                                key: ValueKey("${widget.cardindex}"),
                                child: CircularProgressIndicator(),
                              )
                            : (blgCnt.commentDataList.isNotEmpty &&
                                    blgCnt.commentData.value.data != null)
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, i) {
                                      var data = blgCnt.commentDataList[i];
                                      return commentWidget(context, data: data);
                                    },
                                    itemCount: blgCnt.commentDataList.length,
                                  )
                                : Center(
                                    child: Text("no_comments".tr),
                                  ),
                      ),
                    ],
                  ),
              ],
            ),
          );
  }
}

Widget iconwithText(
    {required BuildContext context,
    IconData? icon,
    String? title,
    BlogRow? blogData,
    void Function()? ontap,
    bool selectedIndex = false}) {
  return GestureDetector(
    onTap: ontap,
    child: Container(
      // color: AppColors.appbarRed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon,
              size: (Responsive.isMobilenew(context)) ? 18 : 22,
              color: (selectedIndex) ? AppColors.blue : AppColors.gray400),
          w6,
          Column(
            children: [
              Row(
                children: [
                  if (title == "Like" && blogData!.blLikeCount != 0)
                    Text("${blogData.blLikeCount}",
                        style: FontStyleUtilities.t1(
                            fontWeight: FWT.medium,
                            fontColor: (selectedIndex)
                                ? AppColors.blue
                                : AppColors.gray400)),
                  if (title == "Like") w2,
                  Text(
                    "${title}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: (Responsive.isMobilenew(context))
                        ? FontStyleUtilities.t3(
                            fontWeight: FWT.medium,
                            fontColor: (selectedIndex)
                                ? AppColors.blue
                                : AppColors.gray400)
                        : FontStyleUtilities.t2(
                            fontWeight: FWT.medium,
                            fontColor: (selectedIndex)
                                ? AppColors.blue
                                : AppColors.gray400),
                  ),
                ],
              ),
              h2,
            ],
          ),
        ],
      ),
    ),
  );
}

Widget commentWidget(BuildContext context, {required Comment data}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child: Row(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundImage: NetworkImage(
            "${ApiRoutes.imageURL}${data.cmnProfilePic}",
          ),
        ),
        w10,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${data.cmnFullName}",
              style: (Responsive.isMobilenew(context))
                  ? FontStyleUtilities.t4(fontWeight: FWT.medium)
                  : FontStyleUtilities.t2(fontWeight: FWT.medium),
            ),
            Text(
              "${intl.DateFormat('yMMMMd').format(DateTime.parse(data.cmnCreatedAt.toString())).toString()}",
              style: (Responsive.isMobilenew(context))
                  ? FontStyleUtilities.t5(fontWeight: FWT.regular)
                  : FontStyleUtilities.t3(fontWeight: FWT.regular),
            ),
            // h4,
            Text(
              "${data.cmnComment}",
              style: (Responsive.isMobilenew(context))
                  ? FontStyleUtilities.t5(fontWeight: FWT.regular)
                  : FontStyleUtilities.t3(fontWeight: FWT.regular),
            ),
          ],
        ),
      ],
    ),
  );
}
