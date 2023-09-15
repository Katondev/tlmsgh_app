import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/screens/library_page/book_detail/widget/simillar_book_list.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:provider/provider.dart';

class SimilarBookModuleTablet extends StatelessWidget {
  final List<BookDetailsM>? bookList;
  final bool? isLibrary;
  final Function? onDetailClick;

  SimilarBookModuleTablet(
      {Key? key, this.bookList, this.isLibrary, this.onDetailClick})
      : super(key: key);

  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: 320,
        decoration:
            BoxDecoration(borderRadius: cr24, color: AppColors.primaryYellow),
        child: Column(
          children: [
            Padding(
              padding: h26v15,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "similar_books".tr,
                    style: FontStyleUtilities.h6(
                      height: 0.0,
                      fontWeight: FWT.semiBold,
                      fontColor: AppColors.white,
                    ),
                  ),
                  // Text(
                  //   "read_all".tr,
                  //   style: FontStyleUtilities.t4(
                  //     height: 0.0,
                  //     fontWeight: FWT.semiBold,
                  //     fontColor: AppColors.white,
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                margin: b10l10r10,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: cr20,
                ),
                child: Consumer<ELearningProvider>(
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: bookList!.length > 5 ? 5 : bookList?.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return SimiLLerBookList(
                          bkIsFree: bookList?[index].bkIsFree,
                          bkPrice: bookList?[index].bkPrice,
                          bookImage:
                              "${ApiRoutes.imageURL}${bookList?[index].bkPreview}",
                          bookName: bookList?[index].bkTitle,
                          onTap: () async {
                            if (onDetailClick != null) {
                              onDetailClick!();
                            }
                            if (isLibrary ?? false) {
                              context.read<BookDetailProvider>().books =
                                  bookList?[index];

                              log(cnt.books.toString());
                              log("........${cnt.similarBookList?.first.toString()}");
                              context
                                  .read<BookDetailProvider>()
                                  .notifyListeners();
                              await cnt.onBookDetailsTap(
                                  bookList: cnt.books,
                                  bookObj: cnt.similarBookList?[index],
                                  isSimilarOrNot: false);
                              value.notifyListeners();
                            } else {
                              context.read<BookDetailProvider>().books =
                                  bookList?[index];

                              context
                                  .read<BookDetailProvider>()
                                  .notifyListeners();
                              await value.onBookDetailsTap(
                                context: context,
                                bookObj: bookList?[index],
                                bookList: value.booksM[0].data?.bookList?.rows,
                              );
                            }
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
