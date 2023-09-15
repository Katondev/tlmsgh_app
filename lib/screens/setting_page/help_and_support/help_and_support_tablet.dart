import 'package:flutter/material.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/screens/home_page.dart';
import 'package:katon/utils/config.dart';
import 'package:provider/provider.dart';
import '../../../widgets/common_appbar.dart';
import '../../practice/controller/practice_prv.dart';

class HelpAndSupportTablet extends StatefulWidget {
  final Arguments args;
  const HelpAndSupportTablet({Key? key, required this.args}) : super(key: key);

  @override
  State<HelpAndSupportTablet> createState() => _HelpAndSupportTabletState();
}

class _HelpAndSupportTabletState extends State<HelpAndSupportTablet> {
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
                body: Container(
                  padding: EdgeInsets.fromLTRB(35, 30, 80, 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CommonAppBar2(
                        isshowback: true,
                        title: widget.args.description,
                      ),
                      customHeight(15),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.boxgreyColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.fromLTRB(36, 69, 36, 0),
                          child: SingleChildScrollView(
                            physics: BouncingScrollPhysics(),
                            child: Column(
                              children: [
                                helpandsupportWidget(
                                    onTap: () {
                                      navigatorKey.currentState
                                          ?.pushNamed(RoutesConst.FAQscreen);
                                    },
                                    height: 60,
                                    title: "FAQ"),
                                Divider(
                                  color: AppColors.dividergreyColor,
                                  thickness: 2,
                                  height: 0,
                                ),
                                helpandsupportWidget(
                                    onTap: () {
                                      navigatorKey.currentState?.pushNamed(
                                          RoutesConst.termsandcondition);
                                    },
                                    height: 60,
                                    title: "T&C"),
                                Divider(
                                  color: AppColors.dividergreyColor,
                                  thickness: 2,
                                  height: 0,
                                ),
                                helpandsupportWidget(
                                    onTap: () {
                                      navigatorKey.currentState?.pushNamed(
                                          RoutesConst.privacypolicy);
                                    },
                                    height: 60,
                                    title: "Privacy policy"),
                              ],
                            ),
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

Widget helpandsupportWidget(
    {double? height,
    required String title,
    Widget? suffixIcon,
    void Function()? onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: height,
      color: AppColors.transparentColor,
      padding: EdgeInsets.only(left: 40),
      child: Row(
        children: [
          // Container(
          //   height: 20,
          //   width: 20,
          //   child: Image.asset(icon),
          // ),
          customWidth(40),
          Text(
            title,
            style: AppTextStyle.normalBold14.copyWith(
              color: AppColors.primaryBlack,
            ),
          ),
          Spacer(),
          if (suffixIcon != null) suffixIcon,
        ],
      ),
    ),
  );
}
