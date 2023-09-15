import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:katon/models/language_model.dart';

class LanguagesCnt extends GetxController {
  var indexs = 0.obs;

  final List<Language> locale = [
    Language(LanguageName: 'English', LanguageCode: Locale('en')),
    Language(LanguageName: 'French', LanguageCode: Locale('fr')),
    Language(LanguageName: 'Portuguese', LanguageCode: Locale('pt')),
  ];

  updateLanguage(Locale locale) {
    Get.updateLocale(locale);
  }

  void onChanged(var index) {
    indexs.value = index;
  }
}
