import 'package:flutter/material.dart';
import 'package:katon/screens/practice/practice_details/controller/mcq_test_prv.dart';
import 'package:katon/screens/practice/practice_details/widgets/answer_or_notanswer_widget.dart';
import 'package:katon/screens/practice/practice_details/widgets/pageview_container.dart';
import 'package:katon/teacher/drawer.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';
import 'package:katon/widgets/drawer/drawer.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:provider/provider.dart';

import '../../home_page.dart';

class McqTest extends StatefulWidget {
  const McqTest({Key? key}) : super(key: key);

  @override
  State<McqTest> createState() => _McqTestState();
}

class _McqTestState extends State<McqTest> {
  McqTestPrv? mcqTestPrv;

  @override
  void initState() {
    mcqTestPrv = Provider.of<McqTestPrv>(context, listen: false);

    Future.delayed(
      Duration.zero,
      () {
        mcqTestPrv?.init(ModalRoute.of(context)!.settings.arguments as List);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<McqTestPrv>(
      builder: (context, value, child) => Material(
        color: AppColors.white,
        child: CommonContainer(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: Responsive.isMobile(context)
                ? CommonAppbarMobile(title: value.arg?.title ?? "")
                : commonAppBar(
                    title: value.arg?.title ?? "",
                    description: value.arg?.description ?? ""),
            drawer: Responsive.isMobile(context)
                ? AppPreference().isTeacherLogin
                    ? TeacherDrawerBox(navKey: navigatorKey)
                    : DrawerBox(navKey: navigatorKey)
                : SizedBox(),
            // endDrawer:
            //     Responsive.isMobile(context) ? endDrawerMobile() : endDrawer(),
            body: Container(
              margin: EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: Responsive.isMobile(context) ? 10 : 15),
              padding: v10,
              decoration: BoxDecoration(
                color: AppColors.primaryYellow,
                borderRadius: cr24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ConnectionWidget.connection,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      w16,
                      Text('Math Assignment',
                          style: FontStyleUtilities.h4(
                              fontColor: AppColors.white,
                              fontWeight: FWT.semiBold)),
                      Spacer(),
                      Responsive.isMobile(context)
                          ? SizedBox()
                          : Text('Total marks: 3',
                              style: FontStyleUtilities.h4(
                                  fontColor: AppColors.white,
                                  fontWeight: FWT.semiBold)),
                      w20,
                    ],
                  ),
                  Expanded(
                    child: Container(
                        decoration: BoxDecoration(
                            color: AppColors.white, borderRadius: cr24),
                        margin: l15r15t10b10,
                        padding: Responsive.isMobile(context) ? all0 : all20,
                        child: Responsive.isMobile(context)
                            ? PageViewContainer()
                            : Row(
                                children: [
                                  Expanded(child: PageViewContainer()),
                                  w16,
                                  Column(
                                    children: [
                                      CommonTimer.commonTimer,
                                      h14,
                                      AnswerOrNotAnswerWidget(),
                                    ],
                                  ),
                                ],
                              )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
