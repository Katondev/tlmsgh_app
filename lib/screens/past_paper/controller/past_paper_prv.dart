import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:katon/models/past_paper_details_model.dart';
import 'package:katon/models/past_paper_model.dart';
import 'package:katon/services/auth_service.dart';

import '../../../network/api_constants.dart';
import '../../../widgets/download_file.dart';

class PastPaperProvider extends ChangeNotifier {
  List<PastPaperList>? pastPaperList;
  PastPaperDetailModel? pastPaperDetailModel;
  bool _isLoading = false;
  bool connections = false;
  int paperId = 0;
  List _alphabetList = ["a", "B", "C", "d", "E"];

  bool get value => _isLoading;
  int get PaperId => paperId;
  List get alphabetList => _alphabetList;
  bool get connection => connections;

  void _setLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  Future getAllPastPaperList() async {
    try {
      _setLoading(true);
      await AuthServices().getAllPastPaper().then((value) {
        pastPaperList = value?.data?.pastPaper;
        connections = false;
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      _setLoading(false);
    }
  }

  Future downloadPdf(int index) async {
    pastPaperList?[index].ppinProgress?.value = true;
    log("1---${pastPaperList?[index].ppinProgress?.value.toString()}");
    await DownloadGeoJsonFile().downloadFile(
      url: "${ApiRoutes.imageURL}${pastPaperList?[index].ppPdf}",
      filename: pastPaperList![index].ppPdf.toString(),
      uploadprogress: (prg) {
        var progress = double.parse(prg.toString());
        log(progress.toString());
      },
    );
    pastPaperList?[index].ppisDownloading?.value = true;
    // ntId = notification![index].ntId!.toInt();
    pastPaperList?[index].ppinProgress?.value = false;
    log("2---${pastPaperList?[index].ppinProgress?.value.toString()}");
    notifyListeners();
  }

  Future getPastPaperDetails({int? paperID}) async {
    try {
      _setLoading(true);
      await AuthServices().getPastPaperDetail(PaperId: paperID).then((value) {
        pastPaperDetailModel = value;
        log("Model data--->" + pastPaperDetailModel!.data.toString());
        connections = false;
      });
      _setLoading(false);
    } on Exception catch (e) {
      if (e.toString() == "No Internet") {
        connections = true;
      }
      print("error in past paper details $e");
      _setLoading(false);
    }
  }
}
