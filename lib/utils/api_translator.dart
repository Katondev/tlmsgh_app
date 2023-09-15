import 'package:katon/utils/config.dart';
import 'package:translator/translator.dart';

class Translator {
  final translator = GoogleTranslator();

  Future<String> translate(String text) async {
    if (AppPreference().getString(PreferencesKey.language).isEmpty ||
        AppPreference().getString(PreferencesKey.language) == "en") {
      return Future.delayed(
        Duration.zero,
        () => text,
      );
    } else {
      Translation translation = await translator.translate("${text}",
          to: AppPreference().getString(PreferencesKey.language), from: "en");
      return translation.text;
    }
  }
}
