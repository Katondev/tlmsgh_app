import 'package:flutter/material.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:katon/utils/constants.dart';

class LargeButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;
  final double width;
  final double height;
  final double borderWidth;
  final BorderRadiusGeometry? borderRadius;

  const LargeButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width = 178.0,
    this.height = 56,
    this.color = AppColors.primary,
    this.textColor = AppColors.white,
    this.borderWidth = 0,
    this.borderRadius,
    this.borderColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        foregroundColor: textColor,
        padding: padding,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius ?? cr12,
        ),
        side: borderWidth == 0
            ? BorderSide.none
            : BorderSide(
                width: borderWidth,
                color: borderColor ?? AppColors.white,
              ),
        // padding: all0,
        backgroundColor: color ?? AppColors.black,
        minimumSize: Size(width, height),
      ),
      child: child,
    );
  }
}

class textButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? color;
  final Color? borderColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final double borderWidth;
  final EdgeInsetsGeometry? padding;
  final BorderRadiusGeometry? borderRadius;

  const textButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.width,
    this.height,
    this.color = AppColors.primary,
    this.textColor = AppColors.white,
    this.borderWidth = 0,
    this.borderRadius,
    this.borderColor,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
// borderRadius: borderRadius??cr12,
      // style: TextButton.styleFrom(
      //   foregroundColor: textColor,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: borderRadius ?? cr12,
      //   ),
      //   side: borderWidth == 0
      //       ? BorderSide.none
      //       : BorderSide(
      //           width: borderWidth,
      //           color: borderColor ?? AppColors.white,
      //         ),
      //   padding: all0,
      //   backgroundColor: color,
      //   minimumSize: Size(width, height),
      // ),
      child: Container(
        height: height,
        width: width,
        alignment: Alignment.center,
        padding: padding ?? EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration:
            BoxDecoration(color: color, borderRadius: borderRadius ?? cr12),
        child: child,
      ),
    );
  }
}
