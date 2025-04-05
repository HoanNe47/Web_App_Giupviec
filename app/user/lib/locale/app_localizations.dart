import 'package:actcms_spa_flutter/locale/languages_vi.dart';
import 'package:actcms_spa_flutter/locale/language_en.dart';
import 'package:actcms_spa_flutter/locale/languages.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'language_en.dart';
import 'languages_vi.dart';

class AppLocalizations extends LocalizationsDelegate<BaseLanguage> {
  const AppLocalizations();

  @override
  Future<BaseLanguage> load(Locale locale) async {
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
  bool shouldReload(LocalizationsDelegate<BaseLanguage> old) => false;
}
