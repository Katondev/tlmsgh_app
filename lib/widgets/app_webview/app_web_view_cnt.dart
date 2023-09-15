import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

class AppWebViewCnt extends GetxController {
  RxString url = "".obs;
  RxDouble progress = 0.0.obs;
  final GlobalKey webViewKey = GlobalKey();

  late Rx<PullToRefreshController> pullToRefreshController =
      PullToRefreshController().obs;

  Rx<InAppWebViewController>? webViewController;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(
      useHybridComposition: true,
    ),
    ios: IOSInAppWebViewOptions(
      allowsInlineMediaPlayback: true,
    ),
  );

  void init() {
    pullToRefreshController.value = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {},
    );
  }

  void onLoadStart(InAppWebViewController controller, Uri? newUri) {
    url.value = newUri.toString();
  }

  Future<NavigationActionPolicy?> shouldOverrideUrlLoading(
      InAppWebViewController controller,
      NavigationAction navigationAction) async {
    var uri = navigationAction.request.url!;

    if (!["http", "https", "file", "chrome", "data", "javascript", "about"]
        .contains(uri.scheme)) {
      if (await canLaunchUrl(Uri.parse(url.value))) {
        await launchUrl(Uri.parse(url.value));
        return NavigationActionPolicy.CANCEL;
      }
    }

    return NavigationActionPolicy.ALLOW;
  }

  void onLoadStop(InAppWebViewController controller, Uri? newUri) {
    pullToRefreshController.value.endRefreshing();

    url.value = newUri.toString();
  }

  void onProgressChanged(InAppWebViewController controller, int newPro) {
    if (newPro == 100) {
      pullToRefreshController.value.endRefreshing();
    }

    progress.value = newPro / 100;
  }

  void onUpdateVisitedHistory(
      InAppWebViewController controller, Uri? newUri, bool? androidIsReload) {
    url.value = newUri.toString();
  }
}
