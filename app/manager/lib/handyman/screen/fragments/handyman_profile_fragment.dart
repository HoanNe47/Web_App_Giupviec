import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:spa_manager_flutter/auth/change_password_screen.dart';
import 'package:spa_manager_flutter/auth/edit_profile_screen.dart';
import 'package:spa_manager_flutter/auth/sign_in_screen.dart';
import 'package:spa_manager_flutter/components/cached_image_widget.dart';
import 'package:spa_manager_flutter/components/theme_selection_dailog.dart';
import 'package:spa_manager_flutter/handyman/component/handyman_experience_widget.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/networks/rest_apis.dart';
import 'package:spa_manager_flutter/screens/about_us_screen.dart';
import 'package:spa_manager_flutter/screens/languages_screen.dart';
import 'package:spa_manager_flutter/utils/colors.dart';
import 'package:spa_manager_flutter/utils/common.dart';
import 'package:spa_manager_flutter/utils/configs.dart';
import 'package:spa_manager_flutter/utils/constant.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:spa_manager_flutter/utils/extensions/string_extension.dart';
import 'package:spa_manager_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class HandymanProfileFragment extends StatefulWidget {
  @override
  _HandymanProfileFragmentState createState() => _HandymanProfileFragmentState();
}

class _HandymanProfileFragmentState extends State<HandymanProfileFragment> {
  UniqueKey keyForExperienceWidget = UniqueKey();
  bool isAvailable = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(primaryColor);
    isAvailable = appStore.handymanAvailability == 1 ? true : false;
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Observer(
        builder: (_) => SingleChildScrollView(
          padding: EdgeInsets.only(top: context.statusBarHeight),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    color: primaryColor,
                    height: 300,
                    width: context.width(),
                    child: Column(
                      children: [
                        16.height,
                        if (appStore.userProfileImage.isNotEmpty)
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                decoration: boxDecorationDefault(
                                  border: Border.all(color: primaryColor, width: 2),
                                  shape: BoxShape.circle,
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(4),
                                  child: CachedImageWidget(
                                    url: appStore.userProfileImage,
                                    height: 90,
                                    fit: BoxFit.cover,
                                    circle: true,
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 8,
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(6),
                                  decoration: boxDecorationDefault(
                                    shape: BoxShape.circle,
                                    color: primaryColor,
                                    border: Border.all(width: 2, color: white),
                                  ),
                                  child: Icon(AntDesign.edit, color: white, size: 18),
                                ).onTap(() {
                                  EditProfileScreen().launch(context);
                                }),
                              ),
                            ],
                          ),
                        24.height,
                        Text(appStore.userFullName, style: boldTextStyle(color: white, size: 18)),
                        4.height,
                        Text(appStore.userEmail, style: secondaryTextStyle(color: white.withOpacity(0.8), size: 16)),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: -50,
                    left: 0,
                    right: 0,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 28),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 24),
                      decoration: boxDecorationWithRoundedCorners(backgroundColor: appStore.isDarkMode ? cardDarkColor : cardColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Observer(
                                builder: (context) => Text(
                                  "${appStore.completedBooking.validate().toString()}",
                                  style: boldTextStyle(color: primaryColor, size: 22),
                                ),
                              ),
                              8.height,
                              Text(
                                "${context.translate.lblServices} \n${context.translate.lblDelivered}",
                                style: secondaryTextStyle(),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                          Container(height: 45, width: 1, color: appTextSecondaryColor.withOpacity(0.4)),
                          HandymanExperienceWidget(key: keyForExperienceWidget),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              80.height,
              if (appStore.isLoggedIn && isUserTypeHandyman)
                Observer(builder: (context) {
                  return AnimatedContainer(
                    margin: EdgeInsets.all(16),
                    decoration: boxDecorationWithRoundedCorners(
                      backgroundColor: (appStore.handymanAvailability == 1 ? Colors.green : Colors.red).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(defaultRadius),
                    ),
                    duration: 300.milliseconds,
                    child: SettingItemWidget(
                      padding: EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                      title: context.translate.lblAvailableStatus,
                      subTitle: '${context.translate.lblYouAre} ${appStore.handymanAvailability == 1 ? ONLINE : OFFLINE}',
                      subTitleTextColor: appStore.handymanAvailability == 1 ? Colors.green : Colors.red,
                      trailing: Switch(
                        value: appStore.handymanAvailability == 1 ? true : false,
                        activeColor: Colors.green,
                        onChanged: (v) {
                          isAvailable = v;
                          setState(() {});
                          appStore.setHandymanAvailability(isAvailable ? 1 : 0, isInitializing: true);
                          Map request = {
                            "is_available": isAvailable ? 1 : 0,
                            "id": appStore.userId,
                          };
                          updateHandymanAvailabilityApi(request: request).then((value) {
                            toast(value.message);
                          }).catchError((e) {
                            appStore.setHandymanAvailability(isAvailable ? 0 : 1, isInitializing: true);
                            toast(e.toString());
                          });
                        },
                      ),
                    ),
                  );
                }),
              SettingItemWidget(
                leading: Image.asset(language, height: 14, width: 14, color: context.iconColor),
                title: context.translate.language,
                trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                onTap: () {
                  LanguagesScreen().launch(context).then((value) {
                    keyForExperienceWidget = UniqueKey();
                  });
                },
              ),
              Divider(height: 0, endIndent: 16, indent: 16, color: gray.withOpacity(0.3)),
              SettingItemWidget(
                leading: Image.asset(ic_theme, height: 18, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                title: context.translate.appTheme,
                trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                onTap: () async {
                  await showInDialog(
                    context,
                    builder: (context) => ThemeSelectionDaiLog(context),
                    contentPadding: EdgeInsets.zero,
                  );
                },
              ),
              Divider(height: 0, endIndent: 16, indent: 16, color: gray.withOpacity(0.3)),
              SettingItemWidget(
                leading: Image.asset(changePassword, height: 18, width: 18, color: context.iconColor),
                title: context.translate.changePassword,
                trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                onTap: () {
                  ChangePasswordScreen().launch(context);
                },
              ),
              Divider(height: 0, indent: 16, endIndent: 16, color: gray.withOpacity(0.3)).visible(appStore.isLoggedIn),
              SettingItemWidget(
                leading: Image.asset(about, height: 18, width: 16, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                title: context.translate.lblAbout,
                trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                onTap: () {
                  AboutUsScreen().launch(context);
                },
              ),
              if (isIqonicProduct)
                Column(
                  children: [
                    Divider(height: 0, indent: 16, endIndent: 16, color: gray.withOpacity(0.3)).visible(appStore.isLoggedIn),
                    SettingItemWidget(
                      leading: Image.asset(purchase, height: 18, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.lblPurchaseCode,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        launchUrlCustomTab(PURCHASE_URL);
                      },
                    ),
                  ],
                ),
              Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
              SettingItemWidget(
                leading: Image.asset(ic_check_update, height: 18, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                title: context.translate.lblOptionalUpdateNotify,
                trailing: Switch.adaptive(
                  value: getBoolAsync(UPDATE_NOTIFY, defaultValue: true),
                  onChanged: (v) {
                    setValue(UPDATE_NOTIFY, v);
                    setState(() {});
                  },
                ).withHeight(24),
              ),
              SettingSection(
                title: Text(context.translate.lblDangerZone.toUpperCase(), style: boldTextStyle(color: redColor)),
                headingDecoration: BoxDecoration(color: redColor.withOpacity(0.08)),
                divider: Offstage(),
                items: [
                  8.height,
                  SettingItemWidget(
                    leading: ic_delete_account.iconImage(size: 22),
                    paddingBeforeTrailing: 4,
                    title: context.translate.lblDeleteAccount,
                    onTap: () {
                      showConfirmDialogCustom(
                        context,
                        negativeText: context.translate.lblCancel,
                        positiveText: context.translate.lblDelete,
                        onAccept: (_) {
                          ifNotTester(context, () {
                            deleteAccountCompletely().then((value) async {
                              appStore.setLoading(false);

                              toast(value.message);
                              await clearPreferences();
                              push(SignInScreen(), isNewTask: true);
                            }).catchError((e) {
                              appStore.setLoading(false);
                              toast(e.toString());
                            });
                          });
                        },
                        dialogType: DialogType.DELETE,
                        title: context.translate.lblDeleteAccountConformation,
                      );
                    },
                  ).paddingOnly(left: 4),
                ],
              ),
              20.height,
              TextButton(
                child: Text(context.translate.logout, style: boldTextStyle(color: primaryColor, size: 18)),
                onPressed: () {
                  appStore.setLoading(false);
                  logout(context);
                },
              ).center().visible(appStore.isLoggedIn),
              VersionInfoWidget(
                prefixText: 'v',
                textStyle: secondaryTextStyle(),
              ).center(),
            ],
          ).paddingOnly(bottom: 24),
        ),
      ),
    );
  }
}
