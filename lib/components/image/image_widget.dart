// import 'package:extended_image/extended_image.dart';
// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:math' as math;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/utils/app_colors.dart';
import 'package:lottie/lottie.dart';

class NetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
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
    this.imageUrl,
    this.borderRadius = BorderRadius.zero,
  }) : super(key: key);

  static Map? header;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius?? BorderRadius.zero,
      child: CachedNetworkImage(
          fit: fit ?? BoxFit.cover,
          height: height,
          // httpHeaders: NetworkHttp.getHeaders(),
          // maxHeightDiskCache: 100,
          maxWidthDiskCache: (Get.width * 0.4).toInt(),
          // memCacheHeight: 500,
          memCacheWidth: (Get.width * 0.4).toInt(),
          cacheKey: imageUrl,
          width: width,
          color: color,
          useOldImageOnUrlChange: true,
          imageUrl: imageUrl!,
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Lottie.asset(
                    'assets/json/loader.json',
                    height: 100,
                    width: 100,
                  ),
                ),
              ),
          errorWidget: (context, url, error) {
            log("image Widget load error $error");
            return Container(
                decoration: BoxDecoration(
                  borderRadius: borderRadius,
                  color: AppColors.boxgrey,
                ),
                child: const Icon(Icons.error, color: AppColors.primaryBlack));
          }),
    );
  }
}

class FullNetworkImageWidget extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  const FullNetworkImageWidget({
    Key? key,
    this.height,
    this.width,
    this.color,
    this.fit,
    this.imageUrl,
    this.borderRadius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit ?? BoxFit.cover,
      height: height,
      cacheKey: imageUrl,
      width: width,
      color: color,
      imageUrl: imageUrl!,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Lottie.asset(
        'assets/json/loader.json',
        height: 100,
        width: 100,
      ),
      errorWidget: (context, url, error) =>
          const Icon(Icons.error, color: AppColors.primaryBlack),
    );
  }
}

void cleancach() {
  ImageCache imagecach = PaintingBinding.instance.imageCache;
  // print(
  //     "------------------>cachimage cleared--->${((_imagecach.currentSizeBytes / 1024) / 1024) > 80}");
  // print(
  //     "------------------>liveImageCount cleared${_imagecach.liveImageCount}");

  if (imagecach.liveImageCount > 20) {
    imagecach.clearLiveImages();
    // _imagecach.clear();
  }
}

class CBouncingScrollPhysics extends ScrollPhysics {
  /// Creates scroll physics that bounce back from the edge.
  const CBouncingScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CBouncingScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CBouncingScrollPhysics(parent: buildParent(ancestor));
  }

  /// The multiple applied to overscroll to make it appear that scrolling past
  /// the edge of the scrollable contents is harder than scrolling the list.
  /// This is done by reducing the ratio of the scroll effect output vs the
  /// scroll gesture input.
  ///
  /// This factor starts at 0.52 and progressively becomes harder to overscroll
  /// as more of the area past the edge is dragged in (represented by an increasing
  /// `overscrollFraction` which starts at 0 when there is no overscroll).
  double frictionFactor(double overscrollFraction) =>
      0.2 * math.pow(1 - overscrollFraction, 2);

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    assert(offset != 0.0);
    assert(position.minScrollExtent <= position.maxScrollExtent);

    if (!position.outOfRange) return offset;

    final double overscrollPastStart =
        math.max(position.minScrollExtent - position.pixels, 0.0);
    final double overscrollPastEnd =
        math.max(position.pixels - position.maxScrollExtent, 0.0);
    final double overscrollPast =
        math.max(overscrollPastStart, overscrollPastEnd);
    final bool easing = (overscrollPastStart > 0.0 && offset < 0.0) ||
        (overscrollPastEnd > 0.0 && offset > 0.0);

    final double friction = easing
        // Apply less resistance when easing the overscroll vs tensioning.
        ? frictionFactor(
            (overscrollPast - offset.abs()) / position.viewportDimension)
        : frictionFactor(overscrollPast / position.viewportDimension);
    final double direction = offset.sign;

    return direction * _applyFriction(overscrollPast, offset.abs(), friction);
  }

  static double _applyFriction(
      double extentOutside, double absDelta, double gamma) {
    assert(absDelta > 0);
    double total = 0.0;
    if (extentOutside > 0) {
      final double deltaToLimit = extentOutside / gamma;
      if (absDelta < deltaToLimit) return absDelta * gamma;
      total += extentOutside;
      absDelta -= deltaToLimit;
    }
    return total + absDelta;
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) => 0.0;

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    final Tolerance tolerance = this.tolerance;
    if (velocity.abs() >= tolerance.velocity || position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
      );
    }
    return null;
  }

  // The ballistic simulation here decelerates more slowly than the one for
  // ClampingScrollPhysics so we require a more deliberate input gesture
  // to trigger a fling.
  @override
  double get minFlingVelocity => 2 * 2.0;

  // Methodology:
  // 1- Use https://github.com/flutter/platform_tests/tree/master/scroll_overlay to test with
  //    Flutter and platform scroll views superimposed.
  // 3- If the scrollables stopped overlapping at any moment, adjust the desired
  //    output value of this function at that input speed.
  // 4- Feed new input/output set into a power curve fitter. Change function
  //    and repeat from 2.
  // 5- Repeat from 2 with medium and slow flings.
  /// Momentum build-up function that mimics iOS's scroll speed increase with repeated flings.
  ///
  /// The velocity of the last fling is not an important factor. Existing speed
  /// and (related) time since last fling are factors for the velocity transfer
  /// calculations.
  @override
  double carriedMomentum(double existingVelocity) {
    return existingVelocity.sign *
        math.min(
            0.000516 * math.pow(existingVelocity.abs(), 2).toDouble(), 4000.0);
  }

  // Eyeballed from observation to counter the effect of an unintended scroll
  // from the natural motion of lifting the finger after a scroll.
  @override
  double get dragStartDistanceMotionThreshold => 3.5;
}
