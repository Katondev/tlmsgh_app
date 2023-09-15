import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/screens/library_page/book_detail/widget/library_ebook_widget.dart';
import 'package:katon/screens/practice/assignment/widget/assignment_widget.dart';
import 'package:katon/screens/training/pdf_viewer/pdf_viewer.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import '../../../components/app_text_style.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';
import '../controller/practice_prv.dart';

class PastQuestionsTablet extends StatefulWidget {
  final Arguments arguments;
  const PastQuestionsTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PastQuestionsTablet> createState() => _PastQuestionsTabletState();
}

class _PastQuestionsTabletState extends State<PastQuestionsTablet> {
  @override
  Widget build(BuildContext context) {
    // bookId = value.books?.bkId;
    var args = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      // endDrawer: endDrawer(),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Consumer<PracticePrv>(
          builder: (context, ePrv, child) {
            return Container(
              padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
              child: ePrv.value
                  ? Loader(message: "loading_wait".tr)
                  : ePrv.connection
                      ? NoInternet(
                          onTap: () {},
                          // onTap: () => ePrv.resetOnTap(),
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonAppBar2(
                                isshowback: true,
                                title: widget.arguments.title,
                                description: "${args.toString()} Language"),
                            customHeight(15),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.boxgreyColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                padding: EdgeInsets.fromLTRB(40, 42, 60, 38),
                                child: (ePrv.pastPaperModel?.data?.pastPaper ==
                                            null ||
                                        ePrv.pastPaperModel!.data!.pastPaper!
                                            .isEmpty)
                                    ? NoDataFound(message: "no_book_found".tr)
                                    : GridView.builder(
                                        physics: BouncingScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithMaxCrossAxisExtent(
                                          // crossAxisCount: 4,
                                          maxCrossAxisExtent: 200,
                                          mainAxisExtent: 200,
                                          crossAxisSpacing: 15,
                                          mainAxisSpacing: 15,
                                          childAspectRatio: 0.95,
                                        ),
                                        itemBuilder: (context, i) {
                                          var data = ePrv.pastPaperModel!.data!
                                              .pastPaper![i];
                                          return Container(
                                            // height: 200,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: AppColors.primaryWhite,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: AppColors
                                                          .primaryBlack
                                                          .withOpacity(.05),
                                                      blurRadius: 12),
                                                ]),
                                            padding: EdgeInsets.fromLTRB(
                                                15, 28, 15, 0),
                                            child: Column(
                                              children: [
                                                Text(
                                                  "${data.ppTitle}",
                                                  textAlign: TextAlign.center,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: AppTextStyle
                                                      .normalBold20
                                                      .copyWith(
                                                    color:
                                                        AppColors.primaryBlack,
                                                  ),
                                                ),
                                                h22,
                                                if (data.ppPdf != null)
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(
                                                          () => PdfViewerScreen(
                                                                filename:
                                                                    data.ppPdf!,
                                                                filetype: "Pdf",
                                                              ));
                                                    },
                                                    child: Container(
                                                      // height: 30,
                                                      width: Get.width,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors
                                                            .primaryYellow
                                                            .withOpacity(.2),
                                                      ),
                                                      child: Text(
                                                        "Objectives - Paper 1",
                                                        style: AppTextStyle
                                                            .normalRegular14
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                                if (data.ppPdf != null) h10,
                                                if (data.ppWrittenPdf != null)
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.to(
                                                          () => PdfViewerScreen(
                                                                filename: data
                                                                    .ppWrittenPdf!,
                                                                filetype: "Pdf",
                                                              ));
                                                    },
                                                    child: Container(
                                                      // height: 30,
                                                      width: Get.width,
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              vertical: 8),
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        color: AppColors
                                                            .primaryYellow
                                                            .withOpacity(.2),
                                                      ),
                                                      child: Text(
                                                        "Essay - Paper 2",
                                                        style: AppTextStyle
                                                            .normalRegular14
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500),
                                                      ),
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          );
                                        },
                                        itemCount: ePrv.pastPaperModel!.data!
                                            .pastPaper!.length,
                                      ),
                              ),
                            ),
                          ],
                        ),
            );
          },
        ),
      ),
    );
  }
}
