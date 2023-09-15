import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SvgIcon extends StatelessWidget {
  const SvgIcon(
      this.icon, {
        Key? key,
        this.height,
        this.width,
        this.color,
        this.fit,
      }) : super(key: key);
  final double? height, width;
  final Color? color;
  final String icon;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      icon,
      height: height,
      width: width,
      color: color,
      fit: fit ?? BoxFit.contain,
    );
  }
}