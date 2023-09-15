import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:get/get.dart';
import 'package:katon/network/api_constants.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/screens/training/controller/training_prv.dart';
import 'package:katon/widgets/download_file.dart';
import 'package:katon/widgets/no_data_found.dart';
import 'package:katon/widgets/pdf_view/pdf_view_cnt.dart';
import 'package:katon/utils/config.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class PDFViewPage extends StatefulWidget {
  final String filename;
  final bool? isFrom;
  final bool? isdownloading;
  // final String filetype;

  const PDFViewPage({
    Key? key,
    required this.filename,
    this.isFrom,
    this.isdownloading = false,
  }) : super(key: key);

  @override
  State<PDFViewPage> createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  final cnt = Get.put(ELearningCnt());
  final pdfViewCnt = Get.put(PDFViewCnt());
  bool isshowSnackbar = false;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.isFrom == true) {
      getData();
    }
    print("PDf name: ${widget.filename}");
    super.initState();
  }

  String pathLocal = "";

  getData() async {
    String path = await init(widget.filename);
    pathLocal = path;
    setState(() {});
  }

  String? path;
  Directory? dir;
  RxBool isLoading = false.obs;

  Future<String> init(String fileName) async {
    isLoading.value = true;
    setState(() {});
    dir = await getApplicationDocumentsDirectory();
    if (widget.isdownloading!) {
      isshowSnackbar = false;
      path = '/storage/emulated/0/Download/$fileName';
      log("ssš");
    } else {
      isshowSnackbar = false;
      path = '${dir!.path}/$fileName';
    }
    print("File Name=====>$fileName");
    log("Path =====>$path");
    log("Dir Path =====>${dir!.path}");
    final savedDir1 = File(path!);
    if (savedDir1.existsSync() == false) {
      await DownloadGeoJsonFile().downloadFile(
        url: "${ApiRoutes.imageURL}$fileName",
        filename: fileName.toString(),
        isFrom: true,
        fileType: "Pdf",
        uploadprogress: (prg) {
          double pro = double.parse(prg.toString());
          log(pro.toString());
        },
        isshowSnackbar: isshowSnackbar,
      );
    } else {
      log("sdsdsdsd---${cnt.updatePreviewPath}");
      cnt.updatePreviewPath = savedDir1.path;
      OpenFile.open(savedDir1.path);
    }
    isLoading.value = false;
    return path!;
  }

  void close() {
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.isdownloading!)
            FloatingActionButton(
              heroTag: "2",
              onPressed: () {
                Provider.of<TrainingProvider>(context, listen: false)
                    .downloadCertificate(
                  path: widget.filename,
                );
              },
              child: const Icon(
                Icons.download,
                color: AppColors.white,
              ),
            ),
          if (widget.isdownloading!) w20,
          FloatingActionButton(
            heroTag: "1",
            onPressed: () => pdfViewCnt.close(),
            child: const Icon(
              Icons.close,
              color: AppColors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: GetBuilder<ELearningCnt>(builder: (cont) {
          return isLoading.value
              ? const Center(child: CircularProgressIndicator())
              : widget.filename.isEmpty
                  ? const NoDataFound(message: "No Pdf Found!!")
                  : PDF(
                      onError: (error) {
                        log("error caused---$error");
                        cnt.pdfExisted.value = false;
                        pdfViewCnt.close();
                      },
                      pageFling: false,
                    ).fromPath(
                      "${widget.isFrom == true ? cnt.updatePreviewPath : widget.filename}");
        }),
      ),
    );
  }
}
