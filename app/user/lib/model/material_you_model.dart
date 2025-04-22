import 'package:giup_viec_nha_app_user_flutter/main.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/colors.dart';
import 'package:giup_viec_nha_app_user_flutter/utils/configs.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

Future<Color> getMaterialYouData() async {
  if (appStore.useMaterialYouTheme && await isAndroid12Above()) {
    primaryColor = await getMaterialYouPrimaryColor();
  } else {
    primaryColor = defaultPrimaryColor;
  }

  return primaryColor;
}
