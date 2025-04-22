import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/locale/base_language.dart';
import 'package:spa_manager_flutter/locale/language_vi.dart';
import 'package:spa_manager_flutter/locale/language_en.dart';
import 'package:nb_utils/nb_utils.dart';

class AppLocalizations extends LocalizationsDelegate<Languages> {
  const AppLocalizations();

  @override
  Future<Languages> load(Locale locale) async {
    switch (locale.languageCode) {
      case 'vi':
        return LanguageVi();
      case 'en':
        return LanguageEn();
      default:
        return LanguageVi();
    }
  }

  @override
  bool isSupported(Locale locale) => LanguageDataModel.languages().contains(locale.languageCode);

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) => false;
}
