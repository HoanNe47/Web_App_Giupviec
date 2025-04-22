import 'package:giup_viec_nha_app_user_flutter/locale/language_ar.dart';
import 'package:giup_viec_nha_app_user_flutter/locale/language_vi.dart';
import 'package:giup_viec_nha_app_user_flutter/locale/language_en.dart';
import 'package:giup_viec_nha_app_user_flutter/locale/language_hi.dart';
import 'package:giup_viec_nha_app_user_flutter/locale/languages.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

import 'languages_de.dart';
import 'languages_fr.dart';

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
