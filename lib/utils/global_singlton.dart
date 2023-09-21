import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../models/video_books_model.dart';

class GlobalSingleton {
  static final GlobalSingleton globalSingleton = GlobalSingleton._internal();
  factory GlobalSingleton() {
    return globalSingleton;
  }

  GlobalSingleton._internal();

  String Dirpath = "";
  RxList<VideoDatum> globalVideolabelData = <VideoDatum>[].obs;
  RxList<VideoDatum> globalVideoData = <VideoDatum>[].obs;
  RxList<int> videobookIdList = <int>[].obs;
  RxList<int> ebookbookIdList = <int>[].obs;

  Future<String> getApppath() async {
    Directory path = await getApplicationDocumentsDirectory();
    log("path------" + path.path);

    Dirpath = path.path;
    return path.path;
  }
}
