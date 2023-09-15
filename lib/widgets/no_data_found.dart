import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/svgIcon.dart';

class NoDataFound extends StatelessWidget {
  final String? message;
  const NoDataFound({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgIcon(
            Images.noData,
            height: 200,
            width: 200,
          ),
          h14,
          Text(
            message ?? "no_data_found".tr,
            style: FontStyleUtilities.h4(
              fontWeight: FWT.medium,
            ),
          ),
        ],
      ),
    );
  }
}
