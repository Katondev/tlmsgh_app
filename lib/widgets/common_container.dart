import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/screens/message/message_page.dart';
import 'package:katon/utils/api_translator.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/connection_manager.dart';
import 'package:katon/widgets/responsive.dart';
import 'package:katon/widgets/svgIcon.dart';

import 'drawer/end_drawer.dart';

class CommonContainer extends StatelessWidget {
  final Widget child;

  const CommonContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: Responsive.isMobile(context) ? cr0 : onlyTopBottomLeft42,
        color: AppColors.backGroundColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.grey500,
            blurRadius: 02,
            offset: Offset(2, 0),
          )
        ],
      ),
      child: child,
    );
  }
}

class BoxContainer {
  static BoxDecoration boxDeco = BoxDecoration(
    borderRadius: onlyTopBottomLeft42,
    color: AppColors.backGroundColor,
    boxShadow: [
      BoxShadow(
        color: AppColors.grey500,
        blurRadius: 02,
        offset: Offset(2, 0),
      )
    ],
  );
}

final cnt = Get.put(ConnectionManagerController());

class ConnectionWidget {
  static Obx connection = Obx(
    () => AnimatedContainer(
        duration: const Duration(seconds: 1),
        height: cnt.connectionType.value ? 0 : 40,
        color: AppColors.iconGrey,
        width: Get.width,
        child: Center(
          child: Text(
            "device_offline".tr,
            style: TextStyle(color: AppColors.white, fontSize: 18),
          ),
        )),
  );
}

class DottedLine extends StatelessWidget {
  final double width;
  final Color? color;
  const DottedLine({Key? key, required this.width, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        150 ~/ width,
        (index) => Expanded(
          child: Container(
            color: index % 2 == 0
                ? Colors.transparent
                : color ?? AppColors.gray300,
            height: 1,
            width: 1,
          ),
        ),
      ),
    );
  }
}

Drawer? endDrawer() {
  return AppPreference().isTeacherLogin
      ? null
      : Drawer(
          width: Get.width / 3,
          child: MessagePage(),
        );
}

EndDrawer? endDrawerMobile() {
  return AppPreference().isTeacherLogin ? null : EndDrawer();
  // : Drawer(

  //     width: Get.width / 1.2,
  //     child: MessagePage(),
  //   );
}

class ColorContainer extends StatelessWidget {
  final Widget child;
  final Widget? suffixItem;
  final Color? color;
  final String? svgImage;
  final String? pngImage;
  final String? title;
  final double? height;
  final double? width;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? margin;

  const ColorContainer(
      {Key? key,
      required this.child,
      this.color,
      this.height,
      this.width,
      this.suffixItem,
      this.svgImage,
      this.pngImage,
      this.title,
      this.margin,
      this.textStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: Responsive.isMobile(context) ? all10 : all14,
      decoration: BoxDecoration(
        color: AppColors.primaryYellow,
        borderRadius: cr24,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title!.isNotEmpty
              ? Row(
                  children: [
                    w10,
                    if (svgImage != null)
                      SvgIcon(svgImage ?? "",
                          color: AppColors.white, height: 20),
                    if (pngImage != null)
                      Image.asset(pngImage ?? "",
                          color: AppColors.white, height: 20),
                    w10,
                    FutureBuilder(
                      future: Translator().translate("${title}"),
                      builder: (context, snapshot) => Text(
                        snapshot.hasData ? "${snapshot.data}" : "${title}",
                        maxLines: 2,
                        style: textStyle ??
                            FontStyleUtilities.h6(
                              fontWeight: FWT.semiBold,
                              fontColor: AppColors.white,
                            ).copyWith(overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    Spacer(),
                    suffixItem ?? SizedBox.shrink(),
                  ],
                )
              : SizedBox.shrink(),
          title!.isNotEmpty ? h10 : SizedBox.shrink(),
          child,
        ],
      ),
    );
  }
}
