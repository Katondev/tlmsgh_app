import 'dart:developer';
import 'dart:io';

import 'package:get/get.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/widgets/download_file.dart';
import 'package:path_provider/path_provider.dart';

class PDFViewCnt extends GetxController {
  String? path;
  Directory? dir;
  RxBool isLoading = false.obs;

  Future<String> init(String fileName) async {
    isLoading.value = true;
    dir = await getApplicationDocumentsDirectory();

    path = '${dir!.path}/$fileName';
    print("File Name=====>$fileName");
    print("Path =====>$path");
    final savedDir1 = File(path!);
    if (savedDir1.existsSync() == false) {
      await DownloadGeoJsonFile().downloadFile(
        
        url: "${ApiRoutes.imageURL}$fileName",
        filename: fileName.toString(),
        uploadprogress: (prg) {
          var progress = double.parse(prg.toString());
          log(progress.toString());
        },
      );
    }
    isLoading.value = false;
    return path!;
  }

  void close() {
    Get.back();
  }
}
