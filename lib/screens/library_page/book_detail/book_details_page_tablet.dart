import 'package:flutter/material.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/screens/library_page/book_detail/widget/library_ebook_widget.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import '../../../components/app_text_style.dart';
import '../../../utils/constants.dart';
import '../controller/cnt_prv.dart';

class BookDetailPageTablet extends StatefulWidget {
  final List<dynamic> args;
  const BookDetailPageTablet({Key? key, required this.args}) : super(key: key);

  @override
  State<BookDetailPageTablet> createState() => _BookDetailPageTabletState();
}

class _BookDetailPageTabletState extends State<BookDetailPageTablet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<BookDetailProvider>(builder: (context, value, child) {
      // bookId = value.books?.bkId;
      return Scaffold(
        // endDrawer: endDrawer(),
        backgroundColor: AppColors.white,
        // appBar: commonAppBar(
        //     onPressed: () => Navigator.pop(context),
        //     backIcon: true,
        //     title: value.arg?.title ?? "",
        //     description:
        //     value.arg?.description ?? ""),
        // body: Stack(
        //   children: [
        //     BookAndSimilarBooksModule(books: value.books!),
        //     ConnectionWidget.connection,
        //   ],
        // ),
        body: SafeArea(
          child: Consumer<ELearningProvider>(builder: (context, ePrv, child) {
            return Container(
              padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // log("message");
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 40,
                          width: 20,
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.arrow_back_ios_new_rounded,
                            size: 18,
                          ),
                        ),
                      ),
                      customWidth(15),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${widget.args[0]["title"]}",
                            style: AppTextStyle.normalBold28.copyWith(
                              color: AppColors.black,
                            ),
                          ),
                          // h4,
                          Text(
                            "${widget.args[1]}",
                            style: AppTextStyle.normalRegular16.copyWith(
                              color: AppColors.textgrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  customHeight(15),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.boxgreyColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.fromLTRB(31, 42, 31, 38),
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 8,
                          childAspectRatio: 0.82,
                        ),
                        itemBuilder: (context, i) {
                          return LibraryEbookWidget(
                            onTapShare: () {},
                            // book: ,
                          );
                        },
                        itemCount: 9,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
        ),
      );
    });
  }
}
