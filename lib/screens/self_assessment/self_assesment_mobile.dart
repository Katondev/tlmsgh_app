import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/past_paper/controller/past_paper_prv.dart';
import 'package:katon/screens/self_assessment/self_assesment_controller.dart';
import 'package:katon/screens/self_assessment/self_assesment_item.dart';
import 'package:katon/screens/self_assessment/self_assessment_paper.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/app_colors.dart';
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

import '../../utils/constants.dart';

class SelfAssessmentMobile extends StatelessWidget {
  final Arguments arguments;

  const SelfAssessmentMobile({Key? key, required this.arguments})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments;
    return Material(
      color: AppColors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.boxgreyColor,

          // appBar: CommonAppbarMobile(title: arguments?.title ?? ""),

          drawer: AppPreference().isTeacherLogin
              ? TeacherDrawerBox(navKey: navigatorKey)
              : DrawerBox(navKey: navigatorKey),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Get.to(() => GeneratePaper());
            },
            backgroundColor: AppColors.primaryYellow,
            tooltip: 'Generate Paper',
            child: Icon(
              Icons.my_library_books_outlined,
              color: Colors.white,
            ),
          ),
          body: Consumer<SelfAssessmentController>(
            builder: (context, ePrv, child) => Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: CommonAppBar2(
                    isshowback: true,
                    title: arguments.title.toString(),
                    description: "${args.toString()} Language",
                  ),
                ),
                // customHeight(15),
                ConnectionWidget.connection,
                ePrv.value
                    ? Expanded(
                        child: Loader(
                          message: "loading_wait".tr,
                        ),
                      )
                    : ePrv.connection
                        ? Expanded(
                            child: NoInternet(
                              onTap: () => ePrv.getAllSelfAssessmentList(),
                            ),
                          )
                        : ePrv.selfAssessmentList == null ||
                                ePrv.selfAssessmentList!.data!.selfAssessment
                                        ?.length ==
                                    0
                            ? NoDataFound(message: "no_record".tr)
                            : Expanded(
                                child: GridView.builder(
                                  physics: BouncingScrollPhysics(),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisExtent: 200,
                                    crossAxisSpacing: 15,
                                    mainAxisSpacing: 15,
                                    childAspectRatio: 0.95,
                                  ),
                                  itemBuilder: (context, index) {
                                    var data = ePrv.selfAssessmentList!.data!
                                        .selfAssessment![index];
                                    return SelfAssessmentItem(
                                      selfassesment_item: ePrv
                                          .selfAssessmentList!
                                          .data!
                                          .selfAssessment![index],
                                    );
                                  },
                                  itemCount: ePrv.selfAssessmentList!.data!
                                      .selfAssessment!.length,
                                ),
                              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
