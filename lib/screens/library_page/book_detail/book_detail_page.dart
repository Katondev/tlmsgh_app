import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/library_page/book_detail/book_detail_page_mobile.dart';
import 'package:katon/screens/library_page/book_detail/book_details_page_tablet.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/connection_manager.dart';
import 'package:provider/provider.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({Key? key}) : super(key: key);

  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  BookDetailProvider? bookDetailProvider;
  final cnt = Get.put(ConnectionManagerController());

  // int? bookId;

  @override
  void initState() {
    bookDetailProvider =
        Provider.of<BookDetailProvider>(context, listen: false);
    Future.delayed(
      Duration(milliseconds: 100),
      () {
        // bookDetailProvider
        //     ?.init(ModalRoute.of(context)!.settings.arguments as List);
        // log(Get.arguments.toString());
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  final args = ModalRoute.of(context)!.settings.arguments as List;

    return Container(
      // decoration: BoxContainer.boxDeco,
      child: Consumer<BookDetailProvider>(
        builder: (context, value, child) {
          // bookId = value.books?.bkId;
          // return Text("data");
          return Responsive.isMobile(context)
              ? BookDetailPageMobile()
              : BookDetailPageTablet(
                  args: [],
                );
        },
      ),
    );
  }
}
