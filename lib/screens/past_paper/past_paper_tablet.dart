import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:katon/screens/past_paper/past_paper_item.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';

import '../../widgets/pdf_view/pdf_view_page.dart';
import '../training/pdf_viewer/pdf_viewer.dart';

class PastPaperPageTablet extends StatelessWidget {
  final Arguments? arguments;
  const PastPaperPageTablet({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PastPaperProvider>(
      builder: (context, value, child) => Scaffold(
          backgroundColor: Colors.transparent,
          appBar: commonAppBar(
              title: arguments?.title ?? "",
              description: arguments?.description ?? ""),
          // endDrawer: endDrawer(),
          body: Column(
            children: [
              ConnectionWidget.connection,
              value.value
                  ? Expanded(child: Loader(message: "loading_wait".tr))
                  : value.connection
                      ? Expanded(
                          child: NoInternet(
                              onTap: () => value.getAllPastPaperList()))
                      : value.pastPaperList == null ||
                              value.pastPaperList?.length == 0
                          ? Expanded(
                              child: NoDataFound(message: "no_data_found".tr))
                          : Expanded(
                              child: Wrap(
                                  runSpacing: 20,
                                  children:
                                      value.pastPaperList?.map((paperItem) {
                                            return PastPaperItem(
                                              paperItem: paperItem,
                                              downloadOnTap: () {
                                                value.downloadPdf(value
                                                    .pastPaperList!
                                                    .indexOf(paperItem));
                                              },
                                              viewPdfOnTap: () {
                                                Get.to(() => PdfViewerScreen(
                                                      filename:
                                                          "${value.pastPaperList?[value.pastPaperList!.indexOf(paperItem)].ppPdf}",
                                                      // isFrom: true,
                                                      filetype: "Past Paper",
                                                      isdownloadicon: true,
                                                    ));
                                              },
                                            );
                                          }).toList() ??
                                          []),
                            ),
            ],
          )),
    );
  }
}
