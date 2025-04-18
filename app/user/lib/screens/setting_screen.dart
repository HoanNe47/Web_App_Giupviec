import 'package:actcms_spa_flutter/component/base_scaffold_widget.dart';
import 'package:actcms_spa_flutter/component/theme_selection_dialog.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/screens/language_screen.dart';
import 'package:actcms_spa_flutter/utils/common.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:actcms_spa_flutter/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class SettingScreen extends StatefulWidget {
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBarTitle: language.lblAppSetting,
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            SettingItemWidget(
              leading: ic_language.iconImage(size: SETTING_ICON_SIZE),
              title: language.language,
              trailing: trailing,
              onTap: () {
                LanguagesScreen().launch(context).then((value) {
                  setState(() {});
                });
              },
            ),
            SettingItemWidget(
              leading: ic_dark_mode.iconImage(size: SETTING_ICON_SIZE),
              title: language.appTheme,
              trailing: trailing,
              onTap: () async {
                await showInDialog(
                  context,
                  builder: (context) => ThemeSelectionDaiLog(),
                  contentPadding: EdgeInsets.zero,
                );
              },
            ),
            SettingItemWidget(
              leading: ic_slider_status.iconImage(size: SETTING_ICON_SIZE),
              title: language.lblAutoSliderStatus,
              trailing: Switch.adaptive(
                value: getBoolAsync(AUTO_SLIDER_STATUS, defaultValue: true),
                onChanged: (v) {
                  setValue(AUTO_SLIDER_STATUS, v);
                  setState(() {});
                },
              ).withHeight(24),
            ),
            SettingItemWidget(
              leading: ic_check_update.iconImage(size: SETTING_ICON_SIZE),
              title: language.lblOptionalUpdateNotify,
              trailing: Switch.adaptive(
                value: getBoolAsync(UPDATE_NOTIFY, defaultValue: true),
                onChanged: (v) {
                  setValue(UPDATE_NOTIFY, v);
                  setState(() {});
                },
              ).withHeight(24),
            ),
            SnapHelperWidget<bool>(
              future: isAndroid12Above(),
              onSuccess: (data) {
                if (data) {
                  return SettingItemWidget(
                    leading: 'assets/icons/ic_android_12.png'.iconImage(size: SETTING_ICON_SIZE),
                    title: language.lblMaterialTheme,
                    trailing: Switch.adaptive(
                      value: appStore.useMaterialYouTheme,
                      onChanged: (v) {
                        showConfirmDialogCustom(
                          context,
                          onAccept: (_) {
                            appStore.setUseMaterialYouTheme(v.validate());

                            RestartAppWidget.init(context);
                          },
                          title: language.lblAndroid12Support,
                          primaryColor: context.primaryColor,
                          positiveText: language.lblYes,
                          negativeText: language.lblCancel,
                        );
                      },
                    ).withHeight(24),
                    onTap: null,
                  );
                }
                return Offstage();
              },
            ),
          ],
        ),
      ),
    );
  }
}
