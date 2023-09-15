import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:katon/models/argument_model.dart';
import 'package:katon/models/book_info_model.dart';
import 'package:katon/screens/library_page/controller/elearning_cnt.dart';
import 'package:katon/utils/prefs/app_preference.dart';
import 'package:katon/utils/prefs/preferences_key.dart';

class BookDetailProvider extends ChangeNotifier {
  BookDetailsM? books;
  Arguments? arg;
  ScrollController scrollController = new ScrollController();

  bool isLoading = true;
  final cnt = Get.put(ELearningCnt());

  Future<void> init(List<dynamic> args) async {
    Future.delayed(Duration.zero, () {
      isLoading = true;
      cnt.valueChange.value = false;
      notifyListeners();

      books = args[0];
      arg = args[1];

      final String booksString =
          AppPreference().getString(PreferencesKey.myLibraryData);
      List<BookDetailsM>? listOfBookDetails;
      if (booksString.isNotEmpty) {
        listOfBookDetails = BookDetailsM.decode(booksString);
      }
      if (listOfBookDetails?.isNotEmpty ?? false) {
        listOfBookDetails?.forEach((element) {
          if (element.bkId == books?.bkId) {
            cnt.valueChange.value = true;
          }
        });
      }
      log("book list--" + listOfBookDetails.toString());

      isLoading = false;
      notifyListeners();
    });
  }
}
