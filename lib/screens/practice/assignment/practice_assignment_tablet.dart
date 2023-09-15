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

class PracticeAssignmentTablet extends StatefulWidget {
  final Arguments arguments;

  const PracticeAssignmentTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<PracticeAssignmentTablet> createState() =>
      _PracticeAssignmentTabletState();
}

class _PracticeAssignmentTabletState extends State<PracticeAssignmentTablet> {
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
    return Scaffold(
      // endDrawer: endDrawer(),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Consumer<PracticePrv>(builder: (context, ePrv, child) {
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
                              child: (ePrv.assignmentModel?.data?.assignment ==
                                          null ||
                                      ePrv.assignmentModel!.data!.assignment!
                                          .isEmpty)
                                  ? NoDataFound(message: "no_book_found".tr)
                                  : GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15,
                                        childAspectRatio: 1.4,
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
                                              22, 22, 22, 0),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${data?.asnTitle}",
                                                style: AppTextStyle.normalBold24
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
                          ),
                        ],
                      ),
          );
        }),
      ),
    );
  }
}
