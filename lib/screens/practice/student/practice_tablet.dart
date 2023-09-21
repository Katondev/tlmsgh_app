// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/utils/global_singlton.dart';
import 'package:provider/provider.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/no_data_found.dart';
import '../../training/pdf_viewer/pdf_viewer.dart';
import '../controller/practice_prv.dart';

class PracticePageTablet extends StatefulWidget {
  final Arguments arguments;

  const PracticePageTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticePageTablet> createState() => _PracticePageTabletState();
}

class _PracticePageTabletState extends State<PracticePageTablet> {
  @override
  void initState() {
    super.initState();
    print(
        "ll---------${GlobalSingleton().globalVideolabelData.map((element) => element.toJson())}");
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Container(
          // decoration: BoxContainer.boxDeco,
          child: Consumer<PracticePrv>(
            builder: (context, ePrv, child) {
              return Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                // endDrawer: endDrawer(),
                body: Container(
                  padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonAppBar2(
                          title: widget.arguments.title,
                          description: widget.arguments.description),
                      customHeight(15),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.boxgreyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.fromLTRB(40, 42, 60, 38),
                          child: (ePrv.practiceStudentList.isEmpty)
                              ? NoDataFound(message: "no_book_found".tr)
                              : GridView.builder(
                                  physics: const BouncingScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithMaxCrossAxisExtent(
                                    // crossAxisCount: 4,
                                    maxCrossAxisExtent: 300,
                                    mainAxisExtent: 250,
                                    crossAxisSpacing: 30,
                                    mainAxisSpacing: 30,
                                    childAspectRatio: 1.3,
                                  ),
                                  itemBuilder: (context, i) {
                                    var data = ePrv.practiceStudentList[i];
                                    return GestureDetector(
                                      onTap: () {
                                        ePrv.selectedPractice = i;
                                        navigatorKey.currentState!.pushNamed(
                                            RoutesConst.practiceSubject,
                                            arguments: data["title"]);
                                      },
                                      child: Container(
                                        // height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            color: AppColors.primaryWhite,
                                            boxShadow: [
                                              BoxShadow(
                                                  color: AppColors.primaryBlack
                                                      .withOpacity(.05),
                                                  blurRadius: 12),
                                            ]),

                                        child: Column(
                                          children: [
                                            // Text(
                                            //   "${data.ppTitle}",
                                            //   textAlign: TextAlign.center,
                                            //   maxLines: 2,
                                            //   overflow: TextOverflow.ellipsis,
                                            //   style: AppTextStyle.normalBold20
                                            //       .copyWith(
                                            //     color: AppColors.primaryBlack,
                                            //   ),
                                            // ),
                                            // h20,
                                            Expanded(
                                              child: Container(
                                                width: Get.width,
                                                height: 100,
                                                padding:
                                                    const EdgeInsets.all(40),
                                                child: Image.asset(
                                                  data["image"],
                                                  // height: 100,
                                                ),
                                              ),
                                            ),
                                            // h22,
                                            // const Spacer(),
                                            Container(
                                              width: Get.width,
                                              height: 50,
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(15),
                                                  bottomRight:
                                                      Radius.circular(15),
                                                ),
                                                color: AppColors.boxgreyColor
                                                    .withOpacity(.7),
                                              ),
                                              child: Text(
                                                data["title"],
                                                style: AppTextStyle
                                                    .normalRegular16
                                                    .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  itemCount: ePrv.practiceStudentList.length,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
