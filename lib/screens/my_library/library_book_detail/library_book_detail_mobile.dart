import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/screens/library_page/book_detail/widget/similar_book_module/similar_book_module.dart';
import 'package:katon/screens/my_library/widgets/library_book_module.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';

class LibraryBookDetailPageMobile extends StatelessWidget {
  LibraryBookDetailPageMobile({Key? key}) : super(key: key);
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List;
    BookDetailsM books = args[0];
    Arguments title = args[1];
    List<BookDetailsM> bookList = args[2];
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CommonAppbarMobile(title: title.title),
      // endDrawer: endDrawerMobile(),
      body: Padding(
        padding: l10t5r10b14,
        child: ListView(
          controller: _scrollController,
          shrinkWrap: true,
          children: [
            Consumer<BookDetailProvider>(
              builder: (context, state, _) {
                return LibraryBookModule(book: state.books ?? books);
              },
            ),
            h10,
            bookList.isEmpty
                ? const SizedBox.shrink()
                : SimilarBookModule(
                    bookList: bookList,
                    isLibrary: true,
                    onDetailClick: () {
                      _scrollController.animateTo(
                          _scrollController.position.minScrollExtent,
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.fastOutSlowIn);
                    },
                  )
          ],
        ),
      ),
    );
  }
}
