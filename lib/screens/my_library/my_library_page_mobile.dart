import 'package:flutter/material.dart';
import 'package:flutter_layout_grid/flutter_layout_grid.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/library_page/widget/book_list_widget.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:number_paginator/number_paginator.dart';
import 'package:provider/provider.dart';

import '../home_page.dart';

class MyLibraryPageMobile extends StatefulWidget {
  final Arguments? arguments;
  const MyLibraryPageMobile({Key? key, this.arguments}) : super(key: key);

  @override
  State<MyLibraryPageMobile> createState() => _MyLibraryPageMobileState();
}

class _MyLibraryPageMobileState extends State<MyLibraryPageMobile> {
  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CommonAppbarMobile(title: widget.arguments?.title ?? ""),
      // endDrawer: endDrawerMobile(),
      drawer: AppPreference().isTeacherLogin
          ? TeacherDrawerBox(navKey: navigatorKey)
          : DrawerBox(navKey: navigatorKey),
      bottomNavigationBar: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                width: Get.width,
                decoration:
                    const BoxDecoration(color: AppColors.backGroundColor),
                padding: all10,
                height: 70,
                child: NumberPaginator(
                    numberPages: cnt.totalNumberOfPages,
                    onPageChange: (index) async {
                      setState(() {
                        cnt.pageNo = index * 12;
                      });
                    })),
          ],
        ),
      ),
      body: Obx(
        () => cnt.books.isEmpty
            ? NoDataFound(message: "no_book_found".tr)
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: hz5,
                  child: LayoutGrid(
                    rowGap: 10,
                    columnGap: 10,
                    gridFit: GridFit.passthrough,
                    columnSizes: [auto, auto],
                    rowSizes: List<IntrinsicContentTrackSize>.generate(
                        (cnt.books.length / 2).round(), (int index) => auto),
                    children: cnt.books.skip(cnt.pageNo).take(12).map(
                      (bookItem) {
                        return BookListItem(
                            book: bookItem,
                            onTap: () {
                              context.read<BookDetailProvider>().books =
                                  bookItem;
                              context
                                  .read<BookDetailProvider>()
                                  .notifyListeners();
                              cnt.onBookDetailsTap(
                                  bookObj: bookItem,
                                  bookList: cnt.books,
                                  navigation: true,
                                  isSimilarOrNot: true);
                            });
                      },
                    ).toList(),
                  ),
                ),
              ),
      ),
    );
  }
}
