import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/blog_page/widgets/blog_widget.dart';
import 'package:katon/screens/blog_page/widgets/creator_widget.dart';
import 'package:katon/widgets/button.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/common_container.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../controller/blog_controller.dart';

class BlogTablet extends StatefulWidget {
  final Arguments arguments;
  const BlogTablet({super.key, required this.arguments});

  @override
  State<BlogTablet> createState() => _BlogTabletState();
}

class _BlogTabletState extends State<BlogTablet> {
  final blgCnt = Get.find<BlogController>();
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
      appBar: commonAppBar(
          title: widget.arguments.title.toString(),
          description: widget.arguments.description),
      // endDrawer: endDrawer(),
      body: Obx(
        () => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CreatorWidget(),
            // w30,
            blgCnt.isLoading.value
                ? Expanded(
                    child: SizedBox(
                        height: Get.height / 1.3,
                        child: Loader(message: "loading".tr)))
                : (blgCnt.blogdataList.isEmpty)
                    ? Expanded(
                        child: SizedBox(
                            height: Get.height / 1.3,
                            child: NoDataFound(message: "no_book_found".tr)))
                    : Expanded(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                              horizontal: 30, vertical: 15),
                          itemBuilder: (context, i) {
                            if (i == blgCnt.blogdataList.length) {
                              return (blgCnt.blogdataList.length <
                                      blgCnt.blogData.value.data!.blog!.count!)
                                  ? Column(
                                      children: [
                                        LargeButton(
                                          onPressed: () {
                                            blgCnt.blogPage.value++;
                                            blgCnt.getBlogListwithpagination();
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
                              },
                            );
                          },
                          itemCount: blgCnt.blogdataList.length + 1,
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
