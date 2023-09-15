import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/screens/training/pdf_viewer/pdf_viewer.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/screens/past_paper/past_paper_item.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';

import '../../widgets/pdf_view/pdf_view_page.dart';

class PastPaperPageMobile extends StatelessWidget {
  final Arguments? arguments;
  const PastPaperPageMobile({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PastPaperProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CommonAppbarMobile(title: arguments?.title ?? ""),
        // endDrawer: endDrawerMobile(),
        drawer: AppPreference().isTeacherLogin
            ? TeacherDrawerBox(navKey: navigatorKey)
            : DrawerBox(navKey: navigatorKey),
        body: SafeArea(
          child: Column(
            children: [
              ConnectionWidget.connection,
              value.value
                  ? Expanded(
                      child: Loader(
                        message: "loading_wait".tr,
                      ),
                    )
                  : value.connection
                      ? Expanded(
                          child: NoInternet(
                            onTap: () => value.getAllPastPaperList(),
                          ),
                        )
                      : Expanded(
                          child: value.pastPaperList == null ||
                                  value.pastPaperList?.length == 0
                              ? NoDataFound(message: "no_data_found".tr)
                              : ListView.builder(
                                  itemCount: value.pastPaperList?.length,
                                  itemBuilder: (context, index) =>
                                      PastPaperItem(
                                    paperItem: value.pastPaperList![index],
                                    downloadOnTap: () {
                                      value.downloadPdf(index);
                                    },
                                    viewPdfOnTap: () {
                                      Get.to(() => PdfViewerScreen(
                                            filename:
                                                "${value.pastPaperList?[index].ppPdf}",
                                            // isFrom: true,
                                            filetype: "Past Paper",
                                            isdownloadicon: true,
                                          ));
                                    },
                                  ),
                                ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
