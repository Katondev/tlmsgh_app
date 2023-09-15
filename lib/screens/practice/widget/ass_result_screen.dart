import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/practice/assignment/model/answer_submit_model.dart';
import 'package:katon/screens/practice/controller/practice_prv.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/loader.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/no_internet.dart';
import 'package:provider/provider.dart';

import '../../home_page.dart';

class AssResultScreen extends StatefulWidget {
  AssResultScreen({Key? key}) : super(key: key);

  @override
  State<AssResultScreen> createState() => _AssResultScreenState();
}

class _AssResultScreenState extends State<AssResultScreen> {
  PracticePrv? practiceController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      practiceController = Provider.of<PracticePrv>(context, listen: false);
      // getData();
    });
  }

  // getData() async {
  //   await practiceController!.getResult(ass_id: Get.arguments[0]);
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<PracticePrv>(
      builder: (context, asn, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: CommonAppbarMobile(title: Get.arguments[1] ?? ""),
        body: Container(
          margin: v10,
          padding: h10v20,
          decoration: BoxDecoration(
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 5,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
              borderRadius: cr20),
          child: Column(
            children: [
              ConnectionWidget.connection,
              // value.value
              //     ? Expanded(
              //         child: Loader(
              //           message: "loading_wait".tr,
              //         ),
              //       )
              //     : value.connection
              //         ? Expanded(
              //             child: NoInternet(
              //               onTap: () => value.getAllPastPaperList(),
              //             ),
              //           )
              //         :
              Expanded(
                child: asn.value
                    ? Loader(message: "loading_wait".tr)
                    : asn.connection
                        ? NoInternet(
                            // onTap: () =>
                            // asn.getResult(ass_id: Get.arguments[0])
                            )
                        : asn.map.isEmpty
                            ? NoDataFound(message: "no_record".tr)
                            : ListView.builder(
                                itemCount: asn.map.length,
                                itemBuilder: (context, index) {
                                  List<dynamic> mapOption =
                                      asn.map[index]['option'];
                                  String selected =
                                      asn.map[index]['selectedOption'];
                                  String answer = asn.map[index]['answer'];
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            FutureBuilder(
                                                future: Translator().translate(
                                                    "${asn.map[index]['question']}"),
                                                builder: (context, snapshot) {
                                                  return Text(
                                                    snapshot.hasData
                                                        ? "${index + 1}. ${snapshot.data}"
                                                        : "${index + 1}. ${asn.map[index]['question']}",
                                                    style:
                                                        FontStyleUtilities.h6(
                                                            fontWeight:
                                                                FWT.bold,
                                                            fontColor: AppColors
                                                                .black),
                                                  );
                                                }),
                                            h12,
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              itemCount: mapOption.length,
                                              itemBuilder: (context, i) {
                                                Color? colorSelected;
                                                Color? colorSelectedText;
                                                if (selected == answer &&
                                                        selected ==
                                                            mapOption[i] ||
                                                    selected.isEmpty &&
                                                        answer ==
                                                            mapOption[i]) {
                                                  colorSelected =
                                                      AppColors.green;
                                                  colorSelectedText =
                                                      AppColors.white;
                                                } else if (selected != answer &&
                                                    selected != mapOption[i] &&
                                                    selected.isNotEmpty) {
                                                  colorSelected = AppColors.red;
                                                  colorSelectedText =
                                                      AppColors.white;
                                                } else {
                                                  colorSelected =
                                                      AppColors.grey;
                                                  colorSelectedText =
                                                      AppColors.black;
                                                }
                                                return mapOption[i].isEmpty
                                                    ? SizedBox.shrink()
                                                    : Container(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        height: 40,
                                                        width: Get.width,
                                                        padding: l10,
                                                        margin: b10,
                                                        decoration: BoxDecoration(
                                                            color:
                                                                colorSelected,
                                                            borderRadius: cr16,
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .borderColor,
                                                                width: 1)),
                                                        child: Text(
                                                            mapOption[i],
                                                            style: FontStyleUtilities.t3(
                                                                fontWeight:
                                                                    FWT.bold,
                                                                fontColor:
                                                                    colorSelectedText)),
                                                      );
                                              },
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
