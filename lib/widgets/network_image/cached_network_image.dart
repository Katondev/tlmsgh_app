import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:katon/utils/app_colors.dart';

class NetworkImageWidget extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  const NetworkImageWidget({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.fit,
    required this.imageUrl,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        fit: fit ?? BoxFit.cover,
        height: height,
        // maxHeightDiskCache: 400,
        // memCacheHeight: 400,
        // maxWidthDiskCache: 400,
        filterQuality: FilterQuality.high,
        cacheKey: imageUrl,
        width: width,
        color: color,
        imageUrl: imageUrl,
        imageBuilder: (context, imageProvider) => Container(
              height: height,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                // border: border,
                image: DecorationImage(
                  image: imageProvider,
                  fit: fit,
                  alignment: Alignment.center,
                  // scale: scale,
                ),
              ),
            ),
        progressIndicatorBuilder: (context, url, downloadProgress) => Container(
              height: height,
              width: width,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                // border: border,
                color: AppColors.boxgrey,
              ),
            ),
        errorWidget: (context, url, error) {
          log(error.toString());
          return Container(
              decoration: BoxDecoration(
                borderRadius: borderRadius,
                color: AppColors.boxgreyColor,
              ),
              child: const Icon(Icons.error, color: Colors.black));
        });
  }
}
