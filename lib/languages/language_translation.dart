import 'package:get/get.dart';
import 'package:katon/languages/english.dart';
import 'package:katon/languages/french.dart';
import 'package:katon/languages/portugal.dart';

class LanguageTranslation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys =>
      {'en': english, 'fr': french, 'pt': portuguese};
}

