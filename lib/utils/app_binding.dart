import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/widgets/connection_manager.dart';

class AppBidding extends Bindings {
  @override
  Future<void> dependencies() async {
    WidgetsFlutterBinding.ensureInitialized();
    Get.lazyPut<ConnectionManagerController>(
        () => ConnectionManagerController());
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
