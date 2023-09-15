// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../network/api_constants.dart';
// import '../../../../utils/app_colors.dart';
// import '../../../../utils/constants.dart';
// import '../../../../utils/font_style.dart';
// import '../../../../widgets/button.dart';
// import '../../../blog_page/controller/blog_controller.dart';
// import '../../controller/group_controller.dart';
// import '../../widgets/create_group_blog_dialog.dart';
// import '../../widgets/group_widget.dart';

// class GroupDetailsTablet extends StatefulWidget {
//   const GroupDetailsTablet({super.key});

//   @override
//   State<GroupDetailsTablet> createState() => _GroupDetailsTabletState();
// }

// class _GroupDetailsTabletState extends State<GroupDetailsTablet> {
//   final blgCnt = Get.put(BlogController());
//   final grpCnt = Get.find<GroupController>();

//   @override
//   void initState() {
//     super.initState();
//     // Future.delayed(Duration(milliseconds: 10), () {
//     // init();
//     // });
//   }

//   Future init() async {
//     await grpCnt.getGroupDetailsbyId();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           width: Get.width,
//           // margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
//           decoration: BoxDecoration(
//             color: AppColors.white,
//             // borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(color: AppColors.grey, blurRadius: 4, spreadRadius: 2),
//             ],
//           ),
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       "${grpCnt.groupDetail.value.data?.group?.grpName}",
//                       style: FontStyleUtilities.h6(fontWeight: FWT.medium),
//                     ),
//                     Spacer(),
//                     LargeButton(
//                       onPressed: () async {
//                         await grpCnt.deleteGroup();
//                       },
//                       height: 40,
//                       width: 70,
//                       color: AppColors.red,
//                       borderRadius: BorderRadius.circular(5),
//                       child: Text(
//                         "Delete Group",
//                         style: FontStyleUtilities.t2(
//                             fontWeight: FWT.medium, fontColor: AppColors.white),
//                       ),
//                     ),
//                     w10,
//                     LargeButton(
//                       onPressed: () async {
//                         await showCreateGroupBlogDialog(context);
//                       },
//                       height: 40,
//                       width: 60,
//                       color: AppColors.primary,
//                       borderRadius: BorderRadius.circular(5),
//                       child: Text(
//                         "Create Group Blog",
//                         style: FontStyleUtilities.t2(
//                             fontWeight: FWT.medium, fontColor: AppColors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Divider(color: AppColors.grey, thickness: 2, height: 0),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//                 child: SizedBox(
//                   height: 60,
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     physics: BouncingScrollPhysics(),
//                     scrollDirection: Axis.horizontal,
//                     itemBuilder: (context, i) {
//                       var data = grpCnt.groupDetail.value.data!.group!
//                           .grpParticipantsDetails?[i];
//                       return Padding(
//                         padding: const EdgeInsets.only(right: 10),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             CircleAvatar(
//                                 radius: 20,
//                                 backgroundImage: NetworkImage(
//                                     "${ApiRoutes.imageURL}${data?.stProfilePic}")),
//                             // h6,
//                             Text(
//                               "${data?.stFullName}",
//                               style: FontStyleUtilities.t3(
//                                   fontWeight: FWT.medium,
//                                   fontColor: AppColors.black),
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     itemCount: grpCnt.groupDetail.value.data!.group!
//                         .grpParticipantsDetails?.length,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         // h20,
//         (grpCnt.groupDetail.value.data!.group!.grpBlogs!.isNotEmpty)
//             ? ListView.builder(
//                 shrinkWrap: true,
//                 padding: EdgeInsets.symmetric(vertical: 10),
//                 physics: BouncingScrollPhysics(),
//                 itemBuilder: (context, i) {
//                   var data = grpCnt.groupDetail.value.data?.group?.grpBlogs?[i];
//                   return GroupWidget(
//                     blogData: grpCnt.groupDetail.value.data!.group!.grpBlogs!,
//                     cardindex: i,
//                     commentData: (blgCnt.commentData.value.data == null)
//                         ? null
//                         : blgCnt.commentData.value.data!.comment,
//                     ontapComment: () async {
//                       blgCnt.selectedComment.value = i;
//                       if (blgCnt.selectedComment.value == i) {
//                         blgCnt.blogId.value = data!.blId!;
//                         await blgCnt.getAllCommentsbyId();
//                       }
//                       log(blgCnt.selectedComment.value.toString());
//                       setState(() {});
//                     },
//                     ontapLike: () async {
//                       data!.isLike = true;
//                       blgCnt.blogId.value = data.blId!;
//                       await blgCnt.likeBlog();
//                       setState(() {});
//                     },
//                   );
//                 },
//                 itemCount:
//                     grpCnt.groupDetail.value.data?.group?.grpBlogs?.length,
//               )
//             : Container(
//                 height: Get.height / 1.5,
//                 width: Get.width,
//                 alignment: Alignment.center,
//                 child: Text(
//                   "no_data_found".tr,
//                   style: FontStyleUtilities.h4(fontWeight: FWT.medium),
//                 ),
//               ),
//       ],
//     );
//   }
// }
