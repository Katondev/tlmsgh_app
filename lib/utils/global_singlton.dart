import 'dart:developer';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class GlobalSingleton {
  static final GlobalSingleton globalSingleton = GlobalSingleton._internal();
  factory GlobalSingleton() {
    return globalSingleton;
  }

  GlobalSingleton._internal();

  String Dirpath = "";

  Future<String> getApppath() async {
    Directory path = await getApplicationDocumentsDirectory();
    log("path------" + path.path);

    Dirpath = path.path;
    return path.path;
  }
}
