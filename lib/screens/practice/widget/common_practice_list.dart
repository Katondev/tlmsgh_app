import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/practice/assignment/model/assignment_result.dart';
import 'package:katon/screens/practice/assignment/test_assignment.dart';
import 'package:katon/screens/practice/controller/practice_prv.dart';
import 'package:katon/screens/practice/widget/ass_result_screen.dart';
import 'package:katon/screens/practice/widget/practice_widget.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

class CommonPracticeList extends StatelessWidget {
  CommonPracticeList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PracticePrv>(
      builder: (context, asP, child) => ListView.builder(
        padding: hz10,
        itemCount: asP.assignmentModel?.data?.assignment?.length,
        physics: Responsive.isMobile(context)
            ? NeverScrollableScrollPhysics()
            : BouncingScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return PracticeWidget(
            assignment: asP.assignmentModel?.data?.assignment![index],
            onPressed: () {
              if (asP.assignmentModel!.data!.assignment![index]
                      .asn_isCheckResult ==
                  true) {
                Get.to(() => AssResultScreen(),arguments:[ asP.assignmentModel!.data!.assignment![index].asnId!,asP.assignmentModel!.data!.assignment![index].asnTitle!]);
              } else {
                Get.to(() => TestAssignment(
                      assignment: asP.assignmentModel!.data!.assignment![index],
                    ));
              }
              // Get.to(() => AppWebView(
              //       arguments: StudentRouteArguments().getArgument(RoutesConst.assignment),
              //       url:
              //           "${ApiRoutes.mcqTest}${asP.assignmentModel?.data?.assignment![index].asnId}",
              //     ));
            },
          );
        },
      ),
    );
  }
}
