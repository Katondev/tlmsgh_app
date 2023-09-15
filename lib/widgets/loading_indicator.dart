import 'package:flutter/material.dart';
import 'package:katon/res.dart';
import 'package:katon/utils/config.dart';

import '../utils/app_binding.dart';

enum LoadingIndicatorType { overlay, spinner, none }

class CustomLoadingIndicator {
  CustomLoadingIndicator._();

  static CustomLoadingIndicator instance = CustomLoadingIndicator._();
  bool _isShowingLoader = false;

  void show(
      {LoadingIndicatorType loadingIndicatorType = LoadingIndicatorType.overlay,
      String? message}) {
    if (!_isShowingLoader) {
      _isShowingLoader = true;
      // print("Show loading indicator");
      Navigator.of(navigatorKey.currentContext!).push(LoadingOverlay(
          loadingIndicatorType: loadingIndicatorType, message: message));
    }
  }

  void hide() {
    if (_isShowingLoader) {
      _isShowingLoader = false;
      // print("Hide loading indicator");
      Navigator.of(navigatorKey.currentContext!).pop();
    }
  }
}

class LoadingOverlay extends ModalRoute<void> {
  final LoadingIndicatorType loadingIndicatorType;
  final String? message;

  LoadingOverlay(
      {this.loadingIndicatorType = LoadingIndicatorType.overlay, this.message});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  bool get opaque => false;

  @override
  bool get barrierDismissible => false;

  @override
  Color get barrierColor => loadingIndicatorType == LoadingIndicatorType.spinner
      ? Colors.transparent
      : AppColors.black.withOpacity(0.5);

  @override
  String get barrierLabel => "";

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    // This makes sure that text and other content follows the material style
    return Material(
      type: MaterialType.transparency,
      // make sure that the overlay content is not cut off
      child: Spinner(
        progressColor: Theme.of(context).primaryColor,
        message: message,
      ),
    );
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    // You can add your own animations for the overlay content
    return FadeTransition(
      opacity: animation,
      child: ScaleTransition(
        scale: animation,
        child: child,
      ),
    );
  }
}

class Spinner extends StatelessWidget {
  const Spinner({
    Key? key,
    this.progressColor,
    this.message,
  }) : super(key: key);
  final Color? progressColor;
  final String? message;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary:
                progressColor ?? Theme.of(context).colorScheme.secondary),
      ),
      child: Center(
        child: Container(
          alignment: Alignment.center,
          height: 200.0,
          width: 200.0,
          decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: cr24,
              boxShadow: [
                BoxShadow(
                  color: AppColors.white.withOpacity(0.2),
                  blurRadius: 200.0, // soften the shadow
                  spreadRadius: 100.0, //extend the shadow
                  offset: const Offset(
                    5.0, // Move to right 10  horizontally
                    5.0, // Move to bottom 10 Vertically
                  ),
                )
              ]),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 70,
                width: 130,
                child: Image.asset(
                  AppAssets.ic_splash,
                  color: AppColors.black,
                ),
              ),
              h14,
              const CircularProgressIndicator(
                color: AppColors.black,
                backgroundColor: AppColors.white,
                strokeWidth: 5.5,
              ),
              h14,
              Text(
                message ?? "Loading wait...",
                style: FontStyleUtilities.h5(
                    fontColor: AppColors.primaryColor, fontWeight: FWT.medium),
              )
            ],
          ),
        ),
      ),
    );
  }
}
