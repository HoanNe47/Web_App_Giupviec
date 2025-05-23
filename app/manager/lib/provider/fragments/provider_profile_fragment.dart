import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:spa_manager_flutter/auth/change_password_screen.dart';
import 'package:spa_manager_flutter/auth/edit_profile_screen.dart';
import 'package:spa_manager_flutter/auth/sign_in_screen.dart';
import 'package:spa_manager_flutter/components/cached_image_widget.dart';
import 'package:spa_manager_flutter/components/theme_selection_dailog.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/user_data.dart';
import 'package:spa_manager_flutter/networks/rest_apis.dart';
import 'package:spa_manager_flutter/provider/handyman_list_screen.dart';
import 'package:spa_manager_flutter/provider/service_address/service_addresses_screen.dart';
import 'package:spa_manager_flutter/provider/services/service_list_screen.dart';
import 'package:spa_manager_flutter/provider/subscription/subscription_history_screen.dart';
import 'package:spa_manager_flutter/provider/taxes/taxes_screen.dart';
import 'package:spa_manager_flutter/provider/wallet/wallet_history_screen.dart';
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


class ProviderProfileFragment extends StatefulWidget {
  final List<UserData>? list;

  ProviderProfileFragment({this.list});

  @override
  ProviderProfileFragmentState createState() => ProviderProfileFragmentState();
}

class ProviderProfileFragmentState extends State<ProviderProfileFragment> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    //
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
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  24.height,
                  if (appStore.userProfileImage.isNotEmpty)
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          decoration: boxDecorationDefault(
                            border: Border.all(color: primaryColor, width: 3),
                            shape: BoxShape.circle,
                          ),
                          child: Container(
                            decoration: boxDecorationDefault(
                              border: Border.all(color: context.scaffoldBackgroundColor, width: 4),
                              shape: BoxShape.circle,
                            ),
                            child: CachedImageWidget(
                              url: appStore.userProfileImage.validate(),
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
                              border: Border.all(color: context.cardColor, width: 2),
                            ),
                            child: Icon(AntDesign.edit, color: white, size: 18),
                          ).onTap(() {
                            EditProfileScreen().launch(
                              context,
                              pageRouteAnimation: PageRouteAnimation.Fade,
                            );
                          }),
                        ),
                      ],
                    ),
                  16.height,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        appStore.userFullName,
                        style: boldTextStyle(color: primaryColor, size: 18),
                      ),
                      4.height,
                      Text(appStore.userEmail, style: secondaryTextStyle()),
                    ],
                  ),
                ],
              ).center().visible(appStore.isLoggedIn),
              if (appStore.earningTypeSubscription && appStore.isPlanSubscribe)
                Column(
                  children: [
                    32.height,
                    Container(
                      decoration: boxDecorationWithRoundedCorners(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        backgroundColor: appStore.isDarkMode ? cardDarkColor : primaryColor.withOpacity(0.1),
                      ),
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(context.translate.lblCurrentPlan, style: boldTextStyle(color: appStore.isDarkMode ? white : gray)),
                              Text(context.translate.lblValidTill, style: boldTextStyle(color: appStore.isDarkMode ? white : gray)),
                            ],
                          ),
                          16.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(appStore.planTitle.validate().capitalizeFirstLetter(), style: boldTextStyle()),
                              Text(
                                formatDate(appStore.planEndDate.validate(), format: DATE_FORMAT_2),
                                style: boldTextStyle(color: primaryColor),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              32.height,
              Container(
                decoration: boxDecorationWithRoundedCorners(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(32), topLeft: Radius.circular(32)),
                  backgroundColor: appStore.isDarkMode ? cardDarkColor : cardColor,
                ),
                child: Column(
                  children: [
                    16.height,
                    if (appStore.earningTypeSubscription)
                      SettingItemWidget(
                        leading: Image.asset(services, height: 18, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                        title: context.translate.lblSubscriptionHistory,
                        trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                        onTap: () async {
                          SubscriptionHistoryScreen().launch(context).then((value) {
                            setState(() {});
                          });
                        },
                      ),
                    if (appStore.earningTypeSubscription) Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                    SettingItemWidget(
                      leading: Image.asset(services, height: 18, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.lblServices,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        ServiceListScreen().launch(context);
                      },
                    ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                    SettingItemWidget(
                      leading: Image.asset(handyman, height: 18, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.lblAllHandyman,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        HandymanListScreen().launch(context);
                      },
                    ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                    SettingItemWidget(
                      leading: Image.asset(servicesAddress, height: 19, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.lblServiceAddress,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        ServiceAddressesScreen(false).launch(context);
                      },
                    ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                    SettingItemWidget(
                      leading: Image.asset(percent_line, height: 20, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.lblTaxes,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        TaxesScreen().launch(context);
                      },
                    ),
                    if (appStore.earningTypeCommission)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                          SettingItemWidget(
                            leading: Image.asset(percent_line, height: 20, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                            title: context.translate.lblWalletHistory,
                            trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                            onTap: () {
                              WalletHistoryScreen().launch(context);
                            },
                          ),
                        ],
                      ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                    SettingItemWidget(
                      leading: Image.asset(ic_theme, height: 20, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
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
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                    SettingItemWidget(
                      leading: Image.asset(language, height: 16, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.language,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        LanguagesScreen().launch(context);
                      },
                    ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                    SettingItemWidget(
                      leading: Image.asset(changePassword, height: 20, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.changePassword,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        ChangePasswordScreen().launch(context);
                      },
                    ),
                    Divider(height: 0, indent: 16, endIndent: 16, color: gray.withOpacity(0.3)).visible(appStore.isLoggedIn),
                    SettingItemWidget(
                      leading: Image.asset(ic_gallery, height: 20, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.lblGallery,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        //ProviderGalleryScreen().launch(context);
                      },
                    ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                    SettingItemWidget(
                      leading: Image.asset(about, height: 16, width: 18, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.lblAbout,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        AboutUsScreen().launch(context);
                      },
                    ),
                    Divider(height: 0, thickness: 1, indent: 15.0, endIndent: 15.0),
                    SettingItemWidget(
                      leading: Image.asset(purchase, height: 20, width: 20, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
                      title: context.translate.lblPurchaseCode,
                      trailing: Icon(Icons.chevron_right, color: appStore.isDarkMode ? white : gray.withOpacity(0.8), size: 24),
                      onTap: () {
                        launchUrlCustomTab(PURCHASE_URL);
                      },
                    ).visible(isIqonicProduct),
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
                    8.height,
                  ],
                ),
              ),
              SettingSection(
                title: Text(context.translate.lblDangerZone.toUpperCase(), style: boldTextStyle(color: redColor)),
                headingDecoration: BoxDecoration(color: redColor.withOpacity(0.08)),
                divider: Offstage(),
                items: [
                  8.height,
                  SettingItemWidget(
                    leading: ic_delete_account.iconImage(size: 20, color: appStore.isDarkMode ? white : gray.withOpacity(0.8)),
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
              16.height,
              TextButton(
                child: Text(context.translate.logout, style: boldTextStyle(color: primaryColor, size: 18)),
                onPressed: () {
                  appStore.setLoading(false);
                  logout(context);
                },
              ).center().visible(appStore.isLoggedIn),
              VersionInfoWidget(prefixText: 'v', textStyle: secondaryTextStyle(size: 14)).center(),
              16.height,
            ],
          ),
        ),
      ),
    );
  }
}
