import 'package:flutter/material.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/button.dart';

class NoInternet extends StatelessWidget {
  final String? message;
  final Function()? onTap;

  const NoInternet({Key? key, this.message, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            Images.noInternet,
            height: 200,
            width: 200,
          ),
          h16,
          Text(
            "We're unable to show this content.\nPlease try again later.",
            style: FontStyleUtilities.h5(
                fontWeight: FWT.medium, fontColor: AppColors.black),
            textAlign: TextAlign.center,
          ),
          h16,
          LargeButton(
            height: 48,
            onPressed: onTap,
            child: Text(
              "Retry",
              style: FontStyleUtilities.h5(
                fontWeight: FWT.medium,
                fontColor: AppColors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
