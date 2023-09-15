// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

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

class SimilarBookModuleMobile extends StatelessWidget {
  final List<BookDetailsM>? bookList;
  final bool? isLibrary;
  final Function? onDetailClick;

  SimilarBookModuleMobile(
      {Key? key, this.bookList, this.isLibrary, this.onDetailClick})
      : super(key: key);

  final cnt = Get.put(ELearningCnt());

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Container(
            margin: b10l10r10,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: cr20,
            ),
            child: Consumer<ELearningProvider>(
              builder: (context, value, child) {
                return ListView.builder(
                    itemCount: bookList!.length > 5 ? 5 : bookList!.length,
                    shrinkWrap: true,
                    primary: false,
                    itemBuilder: (c, i) {
                      BookDetailsM bookItem = bookList![i];
                      return SimiLLerBookList(
                        bkIsFree: bookItem.bkIsFree,
                        bkPrice: bookItem.bkPrice,
                        bookImage: "${ApiRoutes.imageURL}${bookItem.bkPreview}",
                        bookName: bookItem.bkTitle,
                        onTap: () async {
                          if (onDetailClick != null) {
                            onDetailClick!();
                          }
                          if (isLibrary ?? false) {
                            context.read<BookDetailProvider>().books = bookItem;
                            context
                                .read<BookDetailProvider>()
                                .notifyListeners();
                            await cnt.onBookDetailsTap(
                              bookList: cnt.books,
                              bookObj: bookItem,
                              navigation: false,
                            );
                            value.notifyListeners();
                            if (onDetailClick != null) {
                              onDetailClick!();
                            }
                          } else {
                            context.read<BookDetailProvider>().books = bookItem;

                            context
                                .read<BookDetailProvider>()
                                .notifyListeners();
                            await value.onBookDetailsTap(
                              context: context,
                              bookObj: bookItem,
                              navigation: false,
                              bookList: value.booksM[0].data?.bookList?.rows,
                            );
                          }
                        },
                      );
                    });
              },
            ),
          ),
        ],
      ),
    );
  }
}
