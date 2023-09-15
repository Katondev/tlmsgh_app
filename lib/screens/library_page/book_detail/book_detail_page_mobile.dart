import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/screens/library_page/book_detail/phn_tab_common_widgets/phn_tab_widgets.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/loader.dart';
import 'package:provider/provider.dart';

class BookDetailPageMobile extends StatefulWidget {
  const BookDetailPageMobile({Key? key}) : super(key: key);

  @override
  State<BookDetailPageMobile> createState() => _BookDetailPageMobileState();
}

class _BookDetailPageMobileState extends State<BookDetailPageMobile> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailProvider>(builder: (context, value, child) {
      // bookId = value.books?.bkId;
      return Scaffold(
        appBar: CommonAppbarMobile(title: value.arg?.title ?? ""),
        // endDrawer: endDrawerMobile(),
        body: value.isLoading
            ? Center(child: Loader(message: "loading_wait".tr))
            : Stack(
                children: [
                  BookAndSimilarBooksModule(books: value.books!),
                  ConnectionWidget.connection
                ],
              ),
      );
    });
  }
}
