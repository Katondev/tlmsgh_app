import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class InformationContainer extends StatelessWidget {
  const InformationContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PastPaperProvider>(builder: (context, value, child) {
      final paperInformation = value.pastPaperDetailModel?.data?.pastPaperData;
      return Container(
          width: Responsive.isMobile(context) ? Get.width : Get.width / 4.5,
          height: 200,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: cr12,
              boxShadow: [
                BoxShadow(
                    blurRadius: 08,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                    color: Colors.blueGrey.withOpacity(0.2))
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              h14,
              Center(
                  child: Text("information".tr,
                      style: FontStyleUtilities.h4(
                          fontWeight: FWT.medium, fontColor: AppColors.black))),
             h12,
              Divider(thickness: 1, height: 0),
              Padding(
                padding:
                    h15v10,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FutureBuilder(
                        future: Translator()
                            .translate("${paperInformation?.ppTitle}"),
                        builder: (context, snapshot) {
                          return Text(
                              snapshot.hasData
                                  ? "${snapshot.data}"
                                  : "${paperInformation?.ppTitle}",
                              style: FontStyleUtilities.h5());
                        }),
                    h6,
                    FutureBuilder(
                        future: Translator().translate(
                            "${paperInformation?.ppCategory}, ${paperInformation?.ppSubCategory}"),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.hasData
                                ? "${snapshot.data}"
                                : "${paperInformation?.ppCategory}, ${paperInformation?.ppSubCategory}",
                            style: FontStyleUtilities.h5(),
                          );
                        }),
                    h6,
                    FutureBuilder(
                        future: Translator().translate(
                            "${paperInformation?.ppYear}, ${paperInformation?.ppBody}"),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.hasData
                                ? "${snapshot.data}"
                                : "${paperInformation?.ppYear}, ${paperInformation?.ppBody}",
                            style: FontStyleUtilities.h5(),
                          );
                        }),
                    h6,
                    FutureBuilder(
                        future: Translator().translate(
                            "${"total_marks".tr} ${paperInformation?.ppTotalMarks}"),
                        builder: (context, snapshot) {
                          return Text(
                            snapshot.hasData
                                ? "${snapshot.data}"
                                : "${"total_marks".tr} ${paperInformation?.ppTotalMarks}",
                            style: FontStyleUtilities.h5(),
                          );
                        }),
                  ],
                ),
              ),
            ],
          ));
    });
  }
}
