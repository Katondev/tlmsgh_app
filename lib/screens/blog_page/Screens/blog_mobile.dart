import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/blog_page/controller/blog_controller.dart';
import 'package:katon/screens/blog_page/widgets/blog_widget.dart';
import 'package:katon/screens/blog_page/widgets/creator_widget.dart';
import 'package:katon/utils/config.dart';

import '../../../teacher/drawer.dart';
import '../../../utils/app_binding.dart';
import '../../../utils/prefs/app_preference.dart';
import '../../../widgets/button.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/drawer/drawer.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';

class BlogMobile extends StatefulWidget {
  final Arguments arguments;
  const BlogMobile({super.key, required this.arguments});

  @override
  State<BlogMobile> createState() => _BlogMobileState();
}

class _BlogMobileState extends State<BlogMobile> {
  final blgCnt = Get.find<BlogController>();
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 10), () {
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
      appBar: CommonAppbarMobile(title: widget.arguments.title),
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      // endDrawer: endDrawerMobile(),
      body: Obx(
        () => Column(
          children: [
            CreatorWidget(),
            blgCnt.isLoading.value
                ? Expanded(child: Loader(message: "loading".tr))
                : (blgCnt.blogdataList.isEmpty)
                    ? Expanded(
                        child: Center(
                            child: NoDataFound(message: "no_book_found".tr)))
                    : Expanded(
                        child: Obx(
                          () => ListView.builder(
                            shrinkWrap: true,
                            padding: EdgeInsets.symmetric(vertical: 10),
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, i) {
                              if (i == blgCnt.blogdataList.length) {
                                return (blgCnt.blogdataList.length <
                                        blgCnt
                                            .blogData.value.data!.blog!.count!)
                                    ? Column(
                                        children: [
                                          LargeButton(
                                            onPressed: () async {
                                              blgCnt.blogPage.value++;
                                              await blgCnt
                                                  .getBlogListwithpagination();
                                            },
                                            height: 40,
                                            width: 120,
                                            child: Text("Load More"),
                                          ),
                                        ],
                                      )
                                    : SizedBox();
                              }
                              var data = blgCnt.blogdataList[i];
                              return BlogWidget(
                                blogData: blgCnt.blogdataList[i],
                                cardindex: i,
                                ontapComment: () async {
                                  blgCnt.commentDataList.clear();
                                  blgCnt.selectedComment.value =
                                      (blgCnt.selectedComment.value == i)
                                          ? -1
                                          : i;
                                  setState(() {});

                                  // data.isshowComments = !data.isshowComments!;
                                  if (blgCnt.selectedComment.value == i) {
                                    blgCnt.blogId.value = data.blId!;
                                    Future.delayed(Duration(milliseconds: 100),
                                        () {
                                      blgCnt.isLoadingComments.value = true;
                                    });
                                    await blgCnt.getAllCommentsbyId();
                                  }

                                  log("${blgCnt.selectedComment.value.toString()}====${data.isshowComments}");
                                },
                                ontapLike: () async {
                                  if (!data.isLike!) {
                                    data.isLike = true;
                                    data.blLikeCount = data.blLikeCount! + 1;
                                    setState(() {});
                                    blgCnt.blogId.value = data.blId!;

                                    await blgCnt.likeBlog();
                                  }
                                  // setState(() {});
                                },
                              );
                            },
                            itemCount: blgCnt.blogdataList.length + 1,
                          ),
                        ),
                      ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigatorKey.currentState!.pushNamed(RoutesConst.createblog);
        },
        backgroundColor: AppColors.primaryYellow,
        child: Icon(
          Icons.add_to_photos_rounded,
          color: AppColors.white,
        ),
      ),
    );
  }
}
