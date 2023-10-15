import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:katon/res.dart';
import 'package:katon/widgets/button.dart';
import 'package:katon/utils/config.dart';

class CustomDialog extends StatelessWidget {
  final void Function()? onFirstButtonTap;
  final void Function()? onSecButtonTap;

  final String message;
  final String? title1;
  final String? title2;

  const CustomDialog(
      {Key? key,
      this.onFirstButtonTap,
      this.onSecButtonTap,
      this.title1,
      this.title2,
      required this.message})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: cr16),
      actions: <Widget>[
        Center(
          child: Padding(
            padding: hz20,
            child: Column(
              children: [
                h10,
                Image.asset(
                  AppAssets.ic_loder_black,
                  //color: AppColors.black,
                  height: 100.h,
                ),
                h20,
                Text(
                  message.toString(),
                  style: FontStyleUtilities.t2(),
                  textAlign: TextAlign.center,
                ),
                h20,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (onFirstButtonTap != null)
                      Expanded(
                        child: LargeButton(
                          width: 120,
                          height: 45,
                          onPressed: onFirstButtonTap,
                          color: AppColors.lightPurple1,
                          child: Text(
                            '$title1',
                            style: FontStyleUtilities.h6(
                                fontWeight: FWT.medium,
                                fontColor: AppColors.black),
                          ),
                        ),
                      ),
                    w14,
                    if (onSecButtonTap != null)
                      Expanded(
                        child: LargeButton(
                          width: 120,
                          height: 45,
                          onPressed: onSecButtonTap,
                          child: Text(
                            '$title2',
                            style: FontStyleUtilities.h6(
                              fontWeight: FWT.medium,
                              fontColor: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
                h20,
              ],
            ),
          ),
        )
      ],
    );
  }
}
