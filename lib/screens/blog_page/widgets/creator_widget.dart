import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/blog_page/controller/blog_controller.dart';
import 'package:katon/screens/home_page.dart';

import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';

import '../../../widgets/responsive.dart';
import 'create_blog_dialog.dart';

class CreatorWidget extends StatefulWidget {
  CreatorWidget({super.key});

  @override
  State<CreatorWidget> createState() => _CreatorWidgetState();
}

class _CreatorWidgetState extends State<CreatorWidget> {
  final blgCnt = Get.find<BlogController>();

  @override
  Widget build(BuildContext context) {
    return (Responsive.isMobilenew(context))
        ? Container(
            width: Get.width,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            // margin: EdgeInsets.only(top: 15),
            // color: AppColors.grey,
            decoration: BoxDecoration(
              color: AppColors.white,
              // borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    color: AppColors.grey, blurRadius: 4, spreadRadius: 2),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Creator : ",
                //   style: FontStyleUtilities.h5(fontWeight: FWT.semiBold),
                // ),
                // w10,
                Obx(
                  () => Expanded(
                    child: Wrap(
                      runSpacing: 0,
                      spacing: 10,
                      children: List.generate(
                        blgCnt.creatorList.length,
                        (index) => GestureDetector(
                          onTap: () {},
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Radio<String>(
                                value: "${index + 1}",
                                groupValue: blgCnt.creatorgroupVal.value,
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                onChanged: (String? val) async {
                                  blgCnt.creatorgroupVal.value = val!;
                                  log("type---${blgCnt.creatorgroupVal.value.runtimeType}");
                                  if (blgCnt.creatorgroupVal.value == "1") {
                                    log("-------dsdsdsdd");
                                    blgCnt.blogType.value = "";
                                  } else if (blgCnt.creatorgroupVal.value ==
                                      "2") {
                                    blgCnt.blogType.value = "Teacher";
                                  } else if (blgCnt.creatorgroupVal.value ==
                                      "3") {
                                    blgCnt.blogType.value = "Student";
                                  } else if (blgCnt.creatorgroupVal.value ==
                                      "4") {
                                    blgCnt.blogType.value = "Expert";
                                  }
                                  blgCnt.selectedComment.value = -1;
                                  // blgCnt.selectedComment.value = -1;
                                  blgCnt.blogPage.value = 1;
                                  blgCnt.blogdataList.clear();
                                  await blgCnt.getBlogListwithpagination();
                                },
                              ),
                              w6,
                              Text(
                                "${blgCnt.creatorList[index]}",
                                style: FontStyleUtilities.t2(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container(
            width: 250,
            child: Column(
              children: [
                Container(
                  // height: 50,
                  // width: Get.width,
                  width: 250,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  margin: EdgeInsets.only(top: 30),
                  // color: AppColors.grey,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.grey,
                          blurRadius: 4,
                          spreadRadius: 2),
                    ],
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Creator : ",
                        style: FontStyleUtilities.h5(fontWeight: FWT.semiBold),
                      ),
                      w10,
                      Obx(
                        () => Expanded(
                          child: Wrap(
                            runSpacing: 0,
                            spacing: 10,
                            children: List.generate(
                              blgCnt.creatorList.length,
                              (index) => Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Radio<String>(
                                    value: "${index + 1}",
                                    groupValue: blgCnt.creatorgroupVal.value,
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    onChanged: (String? val) async {
                                      blgCnt.creatorgroupVal.value = val!;
                                      if (blgCnt.creatorgroupVal.value == "1") {
                                        blgCnt.blogType.value = "";
                                      } else if (blgCnt.creatorgroupVal.value ==
                                          "2") {
                                        blgCnt.blogType.value = "Teacher";
                                      } else if (blgCnt.creatorgroupVal.value ==
                                          "3") {
                                        blgCnt.blogType.value = "Student";
                                      } else if (blgCnt.creatorgroupVal.value ==
                                          "4") {
                                        blgCnt.blogType.value = "Expert";
                                      }
                                      blgCnt.selectedComment.value = 1000;
                                      setState(() {});
                                      blgCnt.blogPage.value = 1;
                                      blgCnt.blogdataList.clear();
                                      await blgCnt.getBlogListwithpagination();
                                    },
                                  ),
                                  w6,
                                  Text(
                                    "${blgCnt.creatorList[index]}",
                                    style: FontStyleUtilities.t2(),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                h20,
                LargeButton(
                  height: 50,
                  width: 250,
                  onPressed: () async {
                    // navigatorKey.currentState!.pushNamed(RoutesConst.createblog);
                    // Get.toNamed(RoutesConst.createblog);
                    await showCreateBlogDialog(context);
                  },
                  child: Text(
                    "Create Blog",
                    style: FontStyleUtilities.h6(
                      fontColor: AppColors.white,
                      fontWeight: FWT.medium,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
