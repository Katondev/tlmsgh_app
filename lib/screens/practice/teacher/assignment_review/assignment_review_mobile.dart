import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:provider/provider.dart';

import '../../../../components/app_text_style.dart';
import '../../../../utils/app_colors.dart';
import '../../../../utils/constants.dart';
import '../../../../widgets/common_appbar.dart';
import '../../../../widgets/loader.dart';
import '../../../../widgets/no_data_found.dart';
import '../../../../widgets/no_internet.dart';
import '../../assignment/test_assignment.dart';
import '../../controller/practice_prv.dart';
import '../widgets/student_result_dialog.dart';

class AssignmentReviewMobile extends StatefulWidget {
  final Arguments arguments;
  const AssignmentReviewMobile({super.key, required this.arguments});

  @override
  State<AssignmentReviewMobile> createState() => _AssignmentReviewMobileState();
}

class _AssignmentReviewMobileState extends State<AssignmentReviewMobile> {
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
    // var args = ModalRoute.of(context)!.settings.arguments;
    // bookId = value.books?.bkId;
    return Scaffold(
      // endDrawer: endDrawer(),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Consumer<PracticePrv>(builder: (c, ePrv, child) {
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
                            description: widget.arguments.description,
                          ),
                          customHeight(15),
                          Expanded(
                            child: (ePrv.assignmentModel?.data?.assignment ==
                                        null ||
                                    ePrv.assignmentModel!.data!.assignment!
                                        .isEmpty)
                                ? NoDataFound(message: "no_book_found".tr)
                                : GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 15,
                                      mainAxisSpacing: 15,
                                      childAspectRatio: 0.8,
                                    ),
                                    itemBuilder: (c, i) {
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
                                                  color: AppColors.primaryBlack
                                                      .withOpacity(.05),
                                                  blurRadius: 12),
                                            ]),
                                        padding:
                                            EdgeInsets.fromLTRB(22, 28, 22, 0),
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
                                            // Container(
                                            //   // height: 30,
                                            //   width: Get.width,
                                            //   padding: EdgeInsets.symmetric(
                                            //       vertical: 8),
                                            //   alignment: Alignment.center,
                                            //   decoration: BoxDecoration(
                                            //     borderRadius:
                                            //         BorderRadius.circular(10),
                                            //     color: AppColors
                                            //         .buttonblueColor
                                            //         .withOpacity(.08),
                                            //   ),
                                            //   child: Text(
                                            //     "Objectives",
                                            //     style: AppTextStyle
                                            //         .normalRegular14
                                            //         .copyWith(
                                            //       fontWeight: FontWeight.w500,
                                            //     ),
                                            //   ),
                                            // ),
                                            // h10,
                                            GestureDetector(
                                              onTap: () async {
                                                // navigatorKey.currentState?.push(
                                                //   MaterialPageRoute(
                                                //       builder: (context) =>
                                                //           TestAssignment(
                                                //             assignment: data,
                                                //           )),
                                                // );
                                                // Get.to(() => TestAssignment(
                                                //     assignment: data!));

                                                await ePrv
                                                    .getAllAssignmentresult(
                                                        context)
                                                    .whenComplete(() {
                                                  studentResultDialog(context);
                                                });
                                              },
                                              child: Container(
                                                // height: 30,
                                                width: Get.width,
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color:
                                                      AppColors.primaryYellow,
                                                ),
                                                child: Text(
                                                  "Check Result",
                                                  style:
                                                      AppTextStyle.normalBold14,
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
    );
  }
}
