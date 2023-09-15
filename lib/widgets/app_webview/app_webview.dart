import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/widgets/app_webview/app_web_view_cnt.dart';
import 'package:katon/widgets/common_appbar.dart';
import 'package:katon/widgets/responsive.dart';

class AppWebView extends StatefulWidget {
  final String? url;
  final Arguments? arguments;

  const AppWebView({super.key, this.url, this.arguments});
  @override
  _AppWebViewState createState() => new _AppWebViewState();
}

class _AppWebViewState extends State<AppWebView> {
  AppWebViewCnt cnt = Get.put(AppWebViewCnt());

  @override
  void initState() {
    super.initState();
    // cnt.init();
    log(widget.url.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Responsive.isMobile(context)
          ? CommonAppbarMobile(
              title: widget.arguments?.title ?? "",
              closeButton: true,
              backButton: false,
            )
          : commonAppBar(
              title: widget.arguments?.title ?? "",
              description: widget.arguments?.description,
              closeButton: true,
            ),
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              InAppWebView(
                key: cnt.webViewKey,
                initialUrlRequest:
                    URLRequest(url: Uri.parse(widget.url.toString())),
                initialOptions: cnt.options,
                onWebViewCreated: (controller) {
                  cnt.webViewController?.value = controller;
                },
                onLoadStart: (controller, url) =>
                    cnt.onLoadStart(controller, url),
                androidOnPermissionRequest:
                    (controller, origin, resources) async {
                  return PermissionRequestResponse(
                      resources: resources,
                      action: PermissionRequestResponseAction.GRANT);
                },
                shouldOverrideUrlLoading: (controller, navigationAction) =>
                    cnt.shouldOverrideUrlLoading(controller, navigationAction),
                onLoadStop: (controller, url) =>
                    cnt.onLoadStop(controller, url),
                onLoadError: (controller, url, code, message) {
                  cnt.pullToRefreshController.value.endRefreshing();
                },
                onProgressChanged: (controller, progress) =>
                    cnt.onProgressChanged(controller, progress),
                onUpdateVisitedHistory: (controller, url, androidIsReload) =>
                    cnt.onUpdateVisitedHistory(
                        controller, url, androidIsReload),
              ),
              cnt.progress.value < 1.0
                  ? LinearProgressIndicator(value: cnt.progress.value)
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
