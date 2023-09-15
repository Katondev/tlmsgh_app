import 'package:flutter/material.dart';
import 'package:katon/utils/config.dart';
import 'package:katon/widgets/responsive.dart';

class ContentWidget extends StatelessWidget {
  final String leading;
  final String title;
  final EdgeInsetsGeometry? childrenPadding;
  const ContentWidget(
      {super.key,
      required this.leading,
      required this.title,
      this.childrenPadding});

  @override
  Widget build(BuildContext context) {
    final bool isresponsive = Responsive.isMobilenew(context);
    return Padding(
      padding: childrenPadding ?? EdgeInsets.only(left: isresponsive ? 10 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: 30,
            alignment: Alignment.center,
            child: Text(
              leading,
              style: isresponsive
                  ? FontStyleUtilities.t2(
                      fontWeight: FWT.medium, fontColor: AppColors.black)
                  : FontStyleUtilities.h5(
                      fontWeight: FWT.medium, fontColor: AppColors.black),
            ),
          ),
          w10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isresponsive
                      ? FontStyleUtilities.t2(
                          fontWeight: FWT.medium, fontColor: AppColors.black)
                      : FontStyleUtilities.h5(
                          fontWeight: FWT.regular, fontColor: AppColors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ContentWidgetwithDot extends StatelessWidget {
  final String title;
  final EdgeInsetsGeometry? childrenPadding;
  const ContentWidgetwithDot(
      {super.key, required this.title, this.childrenPadding});

  @override
  Widget build(BuildContext context) {
    final bool isresponsive = Responsive.isMobilenew(context);
    return Padding(
      padding: childrenPadding ?? EdgeInsets.only(left: isresponsive ? 15 : 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 8,
            width: 8,
            margin: EdgeInsets.only(top: isresponsive ? 7 : 10),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.black,
            ),
          ),
          w10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: isresponsive
                      ? FontStyleUtilities.t2(
                          fontWeight: FWT.medium, fontColor: AppColors.black)
                      : FontStyleUtilities.h5(
                          fontWeight: FWT.regular, fontColor: AppColors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
