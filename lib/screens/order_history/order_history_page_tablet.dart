import 'package:flutter/material.dart';
import 'package:katon/models/argument_model.dart';
import 'package:get/get.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/common_container.dart';

class OrderHistoryPageTablet extends StatelessWidget {
  final Arguments? arguments;
  const OrderHistoryPageTablet({Key? key, this.arguments}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: commonAppBar(
          title: arguments?.title ?? "",
          description: arguments?.description ?? ""),
      // endDrawer: endDrawer(),
      body: ColorContainer(
        margin: t5l20r20b15,
        // decoration: BoxDecoration(
        //   borderRadius: cr24,
        color: AppColors.blueType2,
        title: 'order_history'.tr,
        textStyle: FontStyleUtilities.h4(
            fontColor: AppColors.white, fontWeight: FWT.semiBold),
        svgImage: Images.orderHistory,
        // ),
        child: Expanded(
          child: Container(
            decoration:
                BoxDecoration(color: AppColors.white, borderRadius: cr24),
            padding: EdgeInsets.only(
                left: 15,
                right: 15,
                top: 15,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text("coming_soon".tr,
                      style:
                          FontStyleUtilities.h6(fontColor: AppColors.grey500)),
                ),
                h500
              ],
            ),
          ),
        ),
      ),
    );
  }
}
