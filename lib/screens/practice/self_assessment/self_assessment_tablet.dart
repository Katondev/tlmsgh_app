import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:provider/provider.dart';
import '../../../components/app_text_style.dart';
import '../../../utils/constants.dart';
import '../../../widgets/common_appbar.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/no_data_found.dart';
import '../../../widgets/no_internet.dart';
import '../../self_assessment/self_assesment_controller.dart';

class SelfAssessmentTablet extends StatefulWidget {
  final Arguments arguments;
  const SelfAssessmentTablet({Key? key, required this.arguments})
      : super(key: key);

  @override
  State<SelfAssessmentTablet> createState() => _SelfAssessmentTabletState();
}

class _SelfAssessmentTabletState extends State<SelfAssessmentTablet> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    return
        // bookId = value.books?.bkId;
        Scaffold(
      // endDrawer: endDrawer(),
      backgroundColor: AppColors.white,
      body: SafeArea(
        child:
            Consumer<SelfAssessmentController>(builder: (context, ePrv, child) {
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
                              padding: EdgeInsets.fromLTRB(80, 42, 80, 38),
                              child: (ePrv.selfAssessmentList!.data!
                                      .selfAssessment!.isEmpty)
                                  ? NoDataFound(message: "no_book_found".tr)
                                  : ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemBuilder: (context, i) {
                                        var data = ePrv.selfAssessmentList!
                                            .data!.selfAssessment![i];
                                        return Container(
                                          height: 57,
                                          width: Get.width,
                                          margin: EdgeInsets.only(
                                              bottom: i + 1 ==
                                                      ePrv
                                                          .selfAssessmentList!
                                                          .data!
                                                          .selfAssessment!
                                                          .length
                                                  ? 0
                                                  : 16),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              color: AppColors.primaryWhite,
                                              boxShadow: [
                                                BoxShadow(
                                                    color: AppColors
                                                        .primaryBlack
                                                        .withOpacity(.05),
                                                    blurRadius: 12),
                                              ]),
                                          // padding:
                                          //     EdgeInsets.fromLTRB(15, 28, 15, 0),
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 8,
                                                height: 57,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(10),
                                                    bottomLeft:
                                                        Radius.circular(10),
                                                  ),
                                                  color:
                                                      AppColors.primaryYellow,
                                                ),
                                              ),
                                              w20,
                                              Text(
                                                "${data.saTitle == "" ? "--" : data.saTitle}",
                                                style: AppTextStyle
                                                    .normalRegular16
                                                    .copyWith(
                                                  fontWeight: FontWeight.w400,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                      itemCount: ePrv.selfAssessmentList!.data!
                                          .selfAssessment!.length,
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
