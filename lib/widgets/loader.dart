import 'package:flutter/material.dart';
import 'package:katon/res.dart';

import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';
import 'package:katon/utils/font_style.dart';

class Loader extends StatelessWidget {
  final String? message;
  const Loader({Key? key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            AppAssets.ic_loder_black,
            width: 64,
            // color: AppColors.black,
          ),
          h10,
          const CircularProgressIndicator(
            color: AppColors.black,
          ),
          h10,
          Text(
            "$message",
            style: FontStyleUtilities.h6(
              fontColor: AppColors.black,
            ),
          )
        ],
      ),
    );
  }
}
