import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/components/app_text_style.dart';
import 'package:katon/res.dart';
import 'package:katon/screens/auth/login/login_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';

/// type of login option with radio button

class TypeOfLoginWidget extends StatelessWidget {
  TypeOfLoginWidget({Key? key}) : super(key: key);
  final cnt = Get.put(LoginCnt());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
          direction: Axis.horizontal,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.center,
          spacing: 20,
          children: cnt.loginList
              .map((e) => Container(
                    width: Responsive.isMobile(context)
                        ? context.width / 2.6
                        : 112,
                    child: Obx(
                      () => GestureDetector(
                        onTap: () async {
                          cnt.onchangePressed(cnt.loginList.indexOf(e));
                        },
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              height:
                                  (Responsive.isMobilenew(context)) ? 140 : 146,
                              width:
                                  (Responsive.isMobilenew(context)) ? 120 : 130,
                              padding: (Responsive.isMobilenew(context))
                                  ? hz15
                                  : hz24,
                              decoration: BoxDecoration(
                                  color: cnt.radioIndex.value ==
                                          cnt.loginList.indexOf(e)
                                      ? AppColors.primaryYellow
                                      : Colors.transparent,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(
                                      color: cnt.radioIndex.value ==
                                              cnt.loginList.indexOf(e)
                                          ? Colors.transparent
                                          : AppColors.primaryYellow,
                                      width: 2)),
                              child: Center(
                                child: Text(
                                  e.toUpperCase(),
                                  style: AppTextStyle.normalBold12.copyWith(
                                    color: cnt.radioIndex.value ==
                                            cnt.loginList.indexOf(e)
                                        ? AppColors.white
                                        : AppColors.primaryYellow,
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  cnt.onchangePressed(cnt.loginList.indexOf(e));
                                },
                                icon: Image.asset(
                                  cnt.radioIndex.value ==
                                          cnt.loginList.indexOf(e)
                                      ? AppAssets.ic_radio_selected
                                      : AppAssets.ic_redio_unselected,
                                )),
                          ],
                        ),
                      ),
                    ),
                  ))
              .toList()),
    );
  }
}
