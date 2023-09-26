import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/library_page/book_detail/book_details_provider.dart';
import 'package:katon/screens/library_page/book_detail/widget/library_ebook_widget.dart';
import 'package:katon/screens/practice/assignment/test_assignment.dart';
import 'package:katon/screens/practice/assignment/widget/assignment_widget.dart';
import 'package:katon/screens/practice/assignment_test_screen.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import '../../../components/app_text_style.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';
import '../../home_page.dart';
import '../controller/practice_prv.dart';

class PracticeAssignmentMobile extends StatefulWidget {
  final Arguments arguments;

  const PracticeAssignmentMobile({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeAssignmentMobile> createState() =>
      _PracticeAssignmentMobileState();
}

class _PracticeAssignmentMobileState extends State<PracticeAssignmentMobile> {
  PracticePrv? assignmentPrv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      assignmentPrv = Provider.of<PracticePrv>(context, listen: false);
      init();
    });
  }

  init() async {
    await assignmentPrv?.getAllAssignment();
  }

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    // bookId = value.books?.bkId;
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.boxgreyColor,
          body: Consumer<PracticePrv>(builder: (context, ePrv, child) {
            return Container(
              padding: EdgeInsets.all(20),
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
                              description: "${args.toString()}",
                            ),
                            customHeight(15),
                            Expanded(
                              child: (ePrv.assignmentModel?.data?.assignment ==
                                          null ||
                                      ePrv.assignmentModel!.data!.assignment!
                                          .isEmpty)
                                  ? NoDataFound(message: "no_book_found".tr)
                                  : GridView.builder(
                                      physics: BouncingScrollPhysics(),
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 0.7,
                                      ),
                                      itemBuilder: (context, i) {
                                        var data = ePrv.assignmentModel?.data
                                            ?.assignment?[i];
                                          
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
                                              15, 24, 15, 0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${data?.asnTitle}",
                                                style: AppTextStyle.normalBold20
                                                    .copyWith(
                                                  color: AppColors.primaryBlack,
                                                ),
                                              ),
                                              h22,
                                              Container(
                                                // height: 30,
                                                width: Get.width,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: AppColors
                                                      .buttonblueColor
                                                      .withOpacity(.08),
                                                ),
                                                child: Text(
                                                  "Objectives",
                                                  style: AppTextStyle
                                                      .normalRegular14
                                                      .copyWith(
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              h10,
                                              GestureDetector(
                                                onTap: () {
                                                  // navigatorKey.currentState?.push(
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           TestAssignment(
                                                  //             assignment: data,
                                                  //           )),
                                                  // );
                                                  Get.to(() => TestAssignment(
                                                      assignment: data!));
                                                },
                                                child: Container(
                                                  // height: 30,
                                                  width: Get.width,
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 8),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        AppColors.primaryYellow,
                                                  ),
                                                  child: Text(
                                                    (data?.asn_isCheckResult !=
                                                            null)
                                                        ? "Check Result"
                                                        : "Try",
                                                    style: AppTextStyle
                                                        .normalBold14,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: ePrv.assignmentModel?.data
                                          ?.assignment?.length,
                                    ),
                            ),
                          ],
                        ),
            );
          }),
        ),
      ),
    );
  }
}
