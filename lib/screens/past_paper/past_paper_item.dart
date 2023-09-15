import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/past_paper_model.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/svgIcon.dart';
import 'package:provider/provider.dart';

class PastPaperItem extends StatelessWidget {
  final PastPaperList paperItem;
  final void Function()? downloadOnTap;
  final void Function()? viewPdfOnTap;
  const PastPaperItem(
      {Key? key,
      required this.paperItem,
      this.downloadOnTap,
      this.viewPdfOnTap})
      : super(key: key);

  // final cnt = Get.put(ELearningCnt());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: context.width / 2.5 - 20,
        decoration: BoxDecoration(
            color: AppColors.white,
            border: Border.all(color: AppColors.borderColor),
            borderRadius: cr20),
        padding: all14,
        margin: Responsive.isMobile(context) ? h10v5 : t10l18,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder(
                future: Translator().translate("${paperItem.ppTitle}"),
                builder: (context, snapshot) {
                  return Text(
                    snapshot.hasData
                        ? "${snapshot.data}"
                        : "${paperItem.ppTitle}",
                    style: FontStyleUtilities.h4(
                        fontWeight: FWT.bold,
                        fontColor: AppColors.primaryColor),
                  );
                }),
            h10,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder(
                    future: Translator().translate(
                        "${paperItem.ppCategory}, ${paperItem.ppSubCategory}, ${paperItem.ppTopic}"),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.hasData
                            ? "${snapshot.data}"
                            : "${paperItem.ppCategory}, ${paperItem.ppSubCategory}, ${paperItem.ppTopic}",
                        style: FontStyleUtilities.t3(),
                      );
                    }),
                FutureBuilder(
                    future: Translator().translate("${paperItem.ppBody}"),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.hasData
                            ? "${snapshot.data}"
                            : "${paperItem.ppBody}",
                        style: FontStyleUtilities.t2(),
                      );
                    }),
              ],
            ),
            h10,
            Row(
              children: [
                SvgIcon(Images.calendarSvg, color: AppColors.black, height: 20),
                w8,
                FutureBuilder(
                    future: Translator()
                        .translate("${"year".tr}-${paperItem.ppYear}"),
                    builder: (context, snapshot) {
                      return Text(
                        snapshot.hasData
                            ? "${snapshot.data}"
                            : "${"year".tr}-${paperItem.ppYear}",
                        style: FontStyleUtilities.t2(),
                      );
                    }),
                Spacer(),
                SizedBox(
                  height: 25,
                  width: 25,
                  child: paperItem.ppinProgress?.value == true
                      ? const CircularProgressIndicator()
                      : InkWell(
                          onTap: paperItem.ppisDownloading?.value == true
                              ? viewPdfOnTap
                              : downloadOnTap,
                          // () async {
                          //   value.paperId = widget.paperItem.ppId ?? 0;
                          //   // _launchUrl();
                          //   String pdfUrl =
                          //       "${ApiRoutes.imageURL}${widget.paperItem.ppPdf}";
                          //   // Get.to(() => PDFViewPage(filename: pdfUrl));

                          //   // navigatorKey.currentState
                          //   //     ?.pushNamed(RoutesConst.pastPaperDetails);
                          // },
                          child: paperItem.ppisDownloading?.value == true
                              ? Image.asset(
                                  Images.img,
                                  height: 32.0,
                                  width: 32.0,
                                )
                              : SvgIcon(
                                  Images.download,
                                  color: AppColors.primaryColor,
                                ),
                          // Text(
                          //   "show_paper".tr,
                          //   style: FontStyleUtilities.t2(
                          //       fontWeight: FWT.medium,
                          //       fontColor: AppColors.primaryColor),
                          // ),
                          // color: Colors.transparent,
                          // borderColor: AppColors.borderColor,
                          // borderWidth: 1,
                          // height: 30,
                          // borderRadius: cr8,
                          // width: 130,
                        ),
                ),
                w6,
              ],
            )
          ],
        ),
      ),
    );
  }
}
