import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/screens/library_page/book_detail/widget/book_item_module/book_item_module.dart';
import 'package:katon/screens/library_page/book_detail/widget/similar_book_module/similar_book_module.dart';
import 'package:katon/screens/library_page/controller/cnt_prv.dart';
import 'package:katon/screens/my_library/widgets/library_book_module.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class BookAndSimilarBooksModule extends StatelessWidget {
  final BookDetailsM books;

  /// Books details and similar books for use this widgets

  BookAndSimilarBooksModule({Key? key, required this.books}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: all10,
      child: SafeArea(
        child: ListView(
          controller: _scrollController,
          scrollDirection:
              Responsive.isMobile(context) ? Axis.vertical : Axis.horizontal,
          children: [
            Consumer<BookDetailProvider>(
              builder: (context, state, _) {
                return Container(
                  decoration: BoxDecoration(
                    color: AppColors.primaryYellow,
                    borderRadius: cr24,
                  ),
                  width: Responsive.isMobile(context) ? Get.width : 690,
                  child: BookItemModule(book: state.books!),
                );
              },
            ),
            Responsive.isMobile(context) ? h10 : w10,
            Consumer<ELearningProvider>(
              builder: (context, value, child) {
                return value.similarBookList.isEmpty
                    ? const SizedBox.shrink()
                    : SimilarBookModule(
                        bookList: value.similarBookList,
                        onDetailClick: () {
                          _scrollController.animateTo(
                              _scrollController.position.minScrollExtent,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.fastOutSlowIn);
                        },
                      );
              },
            )
          ],
        ),
      ),
    );
  }
}
