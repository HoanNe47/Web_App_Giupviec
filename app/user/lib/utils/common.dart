import 'dart:convert';

import 'package:actcms_spa_flutter/component/app_common_dialog.dart';
import 'package:actcms_spa_flutter/component/cached_image_widget.dart';
import 'package:actcms_spa_flutter/component/html_widget.dart';
import 'package:actcms_spa_flutter/component/location_service_dialog.dart';
import 'package:actcms_spa_flutter/component/new_update_dialog.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/model/remote_config_data_model.dart';
import 'package:actcms_spa_flutter/model/service_data_model.dart';
import 'package:actcms_spa_flutter/model/service_detail_response.dart';
import 'package:actcms_spa_flutter/network/rest_apis.dart';
import 'package:actcms_spa_flutter/screens/auth/sign_in_screen.dart';
import 'package:actcms_spa_flutter/services/location_service.dart';
import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:actcms_spa_flutter/utils/configs.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:actcms_spa_flutter/utils/model_keys.dart';
import 'package:actcms_spa_flutter/utils/permissions.dart';
import 'package:actcms_spa_flutter/utils/string_extensions.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart' as custom_tabs;
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'constant.dart';

bool get isIqonicProduct => currentPackageName == appPackageName;

bool get isUserTypeHandyman => appStore.userType == USER_TYPE_HANDYMAN;

bool get isUserTypeProvider => appStore.userType == USER_TYPE_PROVIDER;

bool get isUserTypeUser => appStore.userType == USER_TYPE_USER;

bool get isLoginTypeUser => appStore.loginType == LOGIN_TYPE_USER;

bool get isLoginTypeGoogle => appStore.loginType == LOGIN_TYPE_GOOGLE;

bool get isLoginTypeApple => appStore.loginType == LOGIN_TYPE_APPLE;

bool get isLoginTypeOTP => appStore.loginType == LOGIN_TYPE_OTP;

ThemeMode get appThemeMode => appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light;

Future<void> commonLaunchUrl(String address, {LaunchMode launchMode = LaunchMode.inAppWebView}) async {
  await launchUrl(Uri.parse(address), mode: launchMode).catchError((e) {
    toast('Invalid URL: $address');
  });
}

void launchCall(String? url) {
  if (url.validate().isNotEmpty) {
    if (isIOS)
      commonLaunchUrl('tel://' + url!, launchMode: LaunchMode.externalApplication);
    else
      commonLaunchUrl('tel:' + url!, launchMode: LaunchMode.externalApplication);
  }
}

void launchMap(String? url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl(GOOGLE_MAP_PREFIX + url!, launchMode: LaunchMode.externalApplication);
  }
}

void launchMail(String url) {
  if (url.validate().isNotEmpty) {
    commonLaunchUrl('$MAIL_TO$url', launchMode: LaunchMode.externalApplication);
  }
}

void checkIfLink(BuildContext context, String value, {String? title}) {
  if (value.validate().isEmpty) return;

  String temp = parseHtmlString(value.validate());
  if (temp.startsWith("https") || temp.startsWith("http")) {
    launchUrlCustomTab(temp.validate());
  } else if (temp.validateEmail()) {
    launchMail(temp);
  } else if (temp.validatePhone() || temp.startsWith('+')) {
    launchCall(temp);
  } else {
    HtmlWidget(postContent: value, title: title).launch(context);
  }
}

void launchUrlCustomTab(String? url) {
  if (url.validate().isNotEmpty) {
    custom_tabs.launch(
      url!,
      customTabsOption: custom_tabs.CustomTabsOption(
        enableDefaultShare: true,
        enableInstantApps: true,
        enableUrlBarHiding: true,
        showPageTitle: true,
        toolbarColor: primaryColor,
      ),
      safariVCOption: custom_tabs.SafariViewControllerOption(
        preferredBarTintColor: primaryColor,
        preferredControlTintColor: Colors.white,
        barCollapsingEnabled: true,
        entersReaderIfAvailable: true,
        dismissButtonStyle: SafariViewControllerDismissButtonStyle.close,
      ),
    );
  }
}

List<LanguageDataModel> languageList() {
  return [
    LanguageDataModel(id: 1, name: 'Tiếng Việt', languageCode: 'vi', fullLanguageCode: 'vi-VN', flag: 'assets/flag/ic_vi.png'),
    LanguageDataModel(id: 2, name: 'English', languageCode: 'en', fullLanguageCode: 'en-US', flag: 'assets/flag/ic_us.png'),
  ];
  /*//TODO Enable after adding more language on server
  if (false) {
    Iterable it = jsonDecode(getStringAsync(SERVER_LANGUAGES));
    var res = it.map((e) => LanguageOption.fromJson(e)).toList();

    localeLanguageList.clear();

    res.forEach((element) {
      localeLanguageList.add(LanguageDataModel(languageCode: element.id, flag: element.flagImage, name: element.title));
    });

    return localeLanguageList;
  } else {

  }*/
}

InputDecoration inputDecoration(BuildContext context, {Widget? prefixIcon, String? labelText, double? borderRadius}) {
  return InputDecoration(
    contentPadding: EdgeInsets.only(left: 12, bottom: 10, top: 10, right: 10),
    labelText: labelText,
    labelStyle: secondaryTextStyle(),
    alignLabelWithHint: true,
    prefixIcon: prefixIcon,
    enabledBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.transparent, width: 0.0),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 0.0),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: Colors.red, width: 1.0),
    ),
    errorMaxLines: 2,
    errorStyle: primaryTextStyle(color: Colors.red, size: 12),
    focusedBorder: OutlineInputBorder(
      borderRadius: radius(borderRadius ?? defaultRadius),
      borderSide: BorderSide(color: primaryColor, width: 0.0),
    ),
    filled: true,
    fillColor: context.cardColor,
  );
}

String parseHtmlString(String? htmlString) {
  return parse(parse(htmlString).body!.text).documentElement!.text;
}

String formatDate(String? dateTime, {String format = DATE_FORMAT_1, bool isFromMicrosecondsSinceEpoch = false}) {
  if (isFromMicrosecondsSinceEpoch) {
    return DateFormat(format, appStore.selectedLanguageCode).format(DateTime.fromMicrosecondsSinceEpoch(dateTime.validate().toInt() * 1000));
  } else {
    return DateFormat(format, appStore.selectedLanguageCode).format(DateTime.parse(dateTime.validate()));
  }
}

Future<void> saveOneSignalPlayerId() async {
  await OneSignal.shared.getDeviceState().then((value) async {
    if (value!.userId.validate().isNotEmpty) await setValue(PLAYERID, value.userId.validate());
    log('notification player id ' + value.toString());
  }).catchError((e) {
    toast(e.toString());
  });
}

bool get isRTL => RTL_LanguageS.contains(appStore.selectedLanguageCode);

Widget noDataFound(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CachedImageWidget(url: notDataFoundImg, height: 200),
      8.height,
      Text(language.lblNoData, style: boldTextStyle()),
    ],
  );
}

num calculateTotalAmount({
  required num servicePrice,
  required int qty,
  required num? serviceDiscountPercent,
  CouponData? couponData,
  ServiceData? detail,
  required List<TaxData>? taxes,
}) {
  double totalAmount = 0.0;
  double discountPrice = 0.0;
  double taxAmount = 0.0;
  double couponDiscountAmount = 0.0;

  taxes.validate().forEach((element) {
    if (element.type == SERVICE_TYPE_PERCENT) {
      element.totalCalculatedValue = ((servicePrice * qty) * element.value.validate()) / 100;
    } else {
      element.totalCalculatedValue = element.value.validate();
    }
    taxAmount += element.totalCalculatedValue.validate().toDouble();
  });

  if (serviceDiscountPercent.validate() != 0) {
    totalAmount = (servicePrice * qty) - (((servicePrice * qty) * (serviceDiscountPercent!)) / 100);
    discountPrice = servicePrice * qty - totalAmount;

    totalAmount = (servicePrice * qty) - discountPrice - couponDiscountAmount + taxAmount;
  } else {
    totalAmount = (servicePrice * qty) - couponDiscountAmount + taxAmount;
  }

  if (couponData != null) {
    if (couponData.discountType.validate() == SERVICE_TYPE_FIXED) {
      totalAmount = totalAmount - couponData.discount.validate();
      couponDiscountAmount = couponData.discount.validate().toDouble();
    } else {
      totalAmount = totalAmount - ((totalAmount * couponData.discount.validate()) / 100);
      num calValue = (totalAmount * couponData.discount.validate());
      couponDiscountAmount = calValue / 100;
    }
    if (detail != null) {
      detail.couponCode = couponData.code.validate().toString();
      detail.appliedCouponData = couponData;
      detail.couponDiscountAmount = couponDiscountAmount.validate();
    }
  }

  if (detail != null) {
    detail.totalAmount = totalAmount.toStringAsFixed(DECIMAL_POINT).validate().toDouble();
    detail.qty = qty.validate();
    detail.discountPrice = discountPrice.toStringAsFixed(DECIMAL_POINT).validate().toDouble();
    detail.taxAmount = taxAmount.toStringAsFixed(DECIMAL_POINT).validate().toDouble();
  }
  return totalAmount;
}

Future<bool> addToWishList({required int serviceId}) async {
  Map req = {"id": "", "service_id": serviceId, "user_id": appStore.userId};
  return await addWishList(req).then((res) {
    toast(res.message!);
    return true;
  }).catchError((error) {
    toast(error.toString());
    return false;
  });
}

Future<bool> removeToWishList({required int serviceId}) async {
  Map req = {"user_id": appStore.userId, 'service_id': serviceId};

  return await removeWishList(req).then((res) {
    toast(res.message!);
    return true;
  }).catchError((error) {
    toast(error.toString());
    return false;
  });
}

Widget commonLocationWidget({required BuildContext context, required Function() onTap, Color? color}) {
  return Observer(
    builder: (_) => IconButton(
      icon: ic_active_location.iconImage(size: 24, color: appStore.isCurrentLocation ? color ?? Colors.white : color ?? Colors.white),
      visualDensity: VisualDensity.compact,
      onPressed: () {
        Permissions.cameraFilesAndLocationPermissionsGranted().then((value) async {
          await setValue(PERMISSION_STATUS, value);

          if (value) {
            bool? res = await showInDialog(
              context,
              contentPadding: EdgeInsets.zero,
              builder: (p0) {
                return AppCommonDialog(
                  title: language.lblAlert,
                  child: LocationServiceDialog(),
                );
              },
            );

            if (res ?? false) {
              appStore.setLoading(true);

              await setValue(PERMISSION_STATUS, value);
              await getUserLocation().then((value) async {
                await appStore.setCurrentLocation(!appStore.isCurrentLocation);
              }).catchError((e) {
                appStore.setLoading(false);
                toast(e.toString(), print: true);
              });

              onTap.call();
            }
          }
        }).catchError((e) {
          toast(e.toString(), print: true);
        });
      },
    ),
  );
}

Future deleteDialog(
  BuildContext context, {
  final String? title,
  final String? subTitle,
  required final Function() onSuccess,
  final Function()? onCancel,
}) async {
  return showInDialog(
    context,
    contentPadding: EdgeInsets.zero,
    builder: (c) {
      return Container(
        width: context.width(),
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 100,
              width: 100,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor,
              ),
              child: Image.asset(ic_delete_dialog, height: 60, width: 60),
            ),
            32.height,
            Text(title ?? language.lblDeleteAddress, style: boldTextStyle(size: 22)),
            16.height,
            Text(subTitle ?? language.lblDeleteSunTitle, style: secondaryTextStyle(), textAlign: TextAlign.center),
            24.height,
            Row(
              children: [
                AppButton(
                  text: language.lblCancel,
                  textColor: textPrimaryColorGlobal,
                  color: context.cardColor,
                  onTap: onCancel ??
                      () {
                        finish(context);
                      },
                ).expand(),
                16.width,
                AppButton(
                  text: language.lblDelete,
                  color: primaryColor,
                  textColor: Colors.white,
                  onTap: () {
                    onSuccess.call();
                    finish(context);
                  },
                ).expand(),
              ],
            )
          ],
        ),
      );
    },
  );
}

// Logic For Calculate Time
String calculateTimer(int secTime) {
  int hour = 0, minute = 0, seconds = 0;

  hour = secTime ~/ 3600;

  minute = ((secTime - hour * 3600)) ~/ 60;

  seconds = secTime - (hour * 3600) - (minute * 60);

  String hourLeft = hour.toString().length < 2 ? "0" + hour.toString() : hour.toString();

  String minuteLeft = minute.toString().length < 2 ? "0" + minute.toString() : minute.toString();

  String minutes = minuteLeft == '00' ? '01' : minuteLeft;

  String result = "$hourLeft:$minutes";

  log(seconds);

  return result;
}

num getHourlyPrice({required int secTime, required num price, required String date}) {
  if (isTodayAfterDate(DateTime.parse(date))) {
    return hourlyCalculationNew(price: price, secTime: secTime);
  } else {
    return hourlyCalculation(price: price, secTime: secTime);
  }
}

String newCalculateTimer(int secTime) {
  int hour = 0, minute = 0, seconds = 0;

  hour = secTime ~/ 3600;

  minute = ((secTime - hour * 3600)) ~/ 60;

  seconds = secTime - (hour * 3600) - (minute * 60);

  String hourLeft = hour.toString().length < 2 ? "0" + hour.toString() : hour.toString();

  String minuteLeft = minute.toString().length < 2 ? "0" + minute.toString() : minute.toString();

  String secondsLeft = seconds.toString().length < 2 ? "0" + seconds.toString() : seconds.toString();

  String result = "$hourLeft:$minuteLeft:$secondsLeft";

  return result;
}

num hourlyCalculationNew({required int secTime, required num price}) {
  /// Calculating time on based of seconds.
  String time = newCalculateTimer(secTime);

  /// Splitting the time to get the Hour,Minute,Seconds.
  List<String> data = time.split(":");
  String hour = data.first, minute = data[1];
  //String hour = data.first, minute = data[1], seconds = data.last;

  /// Calculating per minute charge for the price [Price is Dynamic].
  String perMinuteCharge = (price / 60).toStringAsFixed(2);

  /// If time is less than a hour then it will calculate the Base Price default.
  if (hour == "00") {
    return (price * 1).toStringAsFixed(2).toDouble();
  }

  ///If the time has passed the hour mark, the minute charge will be calculated.
  else if (hour != "00") {
    String value = (price * 1).toStringAsFixed(2);

    ///If the minute after one hour is greater than 00 (i.e. 01:02:00), the 02 minute charge will be calculated and added to the base price.

    if (minute != "00") {
      /// Calculating Minute Charge for the service,
      num minuteCharge = perMinuteCharge.toDouble() * minute.toDouble();

      return price + minuteCharge;
    }

    return value.toDouble();
  }

  return 0.0;
}

num hourlyCalculation({required int secTime, required num price}) {
  num result = 0;

  String time = calculateTimer(secTime);
  String perMinuteCharge = (price / 60).toStringAsFixed(2);

  if (time == "01:00") {
    String value = (price * 1).toStringAsFixed(2);
    result = value.toDouble();
  } else {
    List<String> data = time.split(":");
    if (data.first == "00") {
      String value;
      if (secTime < 60) {
        value = (perMinuteCharge.toDouble() * 1).toStringAsFixed(2);
      } else {
        value = (perMinuteCharge.toDouble() * data.last.toDouble()).toStringAsFixed(2);
      }

      result = value.toDouble();
    } else {
      if (data.first.toInt() > 01 && data.last.toInt() == 00) {
        String value = (price * data.first.toInt()).toStringAsFixed(2);
        result = value.toDouble();
      } else {
        String value = (price * data.first.toInt()).toStringAsFixed(2);
        String extraMinuteCharge = (data.last.toDouble() * perMinuteCharge.toDouble()).toStringAsFixed(2);
        String finalPrice = (value.toDouble() + extraMinuteCharge.toDouble()).toStringAsFixed(2);
        result = finalPrice.toDouble();
      }
    }
  }

  return result.toDouble();
}

Brightness getStatusBrightness({required bool val}) {
  return val ? Brightness.light : Brightness.dark;
}

String getPaymentStatusText(String? status, String? method) {
  if (status!.isEmpty) {
    return 'Chưa giải quyết';
  } else if (status == SERVICE_PAYMENT_STATUS_PAID) {
    return 'Đã thanh toán';
  } else if (status == SERVICE_PAYMENT_STATUS_PENDING && method == PAYMENT_METHOD_COD) {
    return 'Chờ phê duyệt';
  }
  if (status == SERVICE_PAYMENT_STATUS_PENDING) {
    return 'Chưa giải quyết';
  } else {
    return "";
  }
}

String getReasonText(String val) {
  if (val == BookingStatusKeys.cancelled) {
    return language.lblReasonCancelling;
  } else if (val == BookingStatusKeys.rejected) {
    return language.lblReasonRejecting;
  } else if (val == BookingStatusKeys.failed) {
    return language.lblFailed;
  }
  return '';
}

String buildPaymentStatusWithMethod(String status, String method) {
  return '${getPaymentStatusText(status, method)}${status == SERVICE_PAYMENT_STATUS_PAID ? ' bởi ${method.capitalizeFirstLetter()}' : ''}';
}

Color getRatingBarColor(int rating) {
  if (rating == 1 || rating == 2) {
    return Color(0xFFE80000);
  } else if (rating == 3) {
    return Color(0xFFff6200);
  } else if (rating == 4 || rating == 5) {
    return Color(0xFF73CB92);
  } else {
    return Color(0xFFE80000);
  }
}

Future<FirebaseRemoteConfig> setupFirebaseRemoteConfig() async {
  final FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  remoteConfig.setConfigSettings(RemoteConfigSettings(fetchTimeout: Duration.zero, minimumFetchInterval: Duration.zero));
  await remoteConfig.fetch();
  await remoteConfig.fetchAndActivate();

  if (remoteConfig.getString(USER_CHANGE_LOG).validate().isNotEmpty) {
    remoteConfigDataModel = RemoteConfigDataModel.fromJson(jsonDecode(remoteConfig.getString(USER_CHANGE_LOG)));

    setValue(USER_CHANGE_LOG, remoteConfig.getString(USER_CHANGE_LOG));

    if (isIOS) {
      await setValue(HAS_IN_REVIEW, remoteConfig.getBool(HAS_IN_APP_STORE_REVIEW));
    } else if (isAndroid) {
      await setValue(HAS_IN_REVIEW, remoteConfig.getBool(HAS_IN_PLAY_STORE_REVIEW));
    }
  }

  return remoteConfig;
}

void ifNotTester(VoidCallback callback) {
  if (appStore.userEmail != DEFAULT_EMAIL) {
    callback.call();
  } else {
    toast(language.lblUnAuthorized);
  }
}

void doIfLoggedIn(BuildContext context, VoidCallback callback) {
  if (appStore.isLoggedIn) {
    callback.call();
  } else {
    SignInScreen(returnExpected: true).launch(context).then((value) {
      if (value ?? false) {
        callback.call();
      }
    });
  }
}

Widget get trailing {
  return ic_arrow_right.iconImage(size: 16);
}

void showNewUpdateDialog(BuildContext context) async {
  showInDialog(
    context,
    contentPadding: EdgeInsets.zero,
    barrierDismissible: !remoteConfigDataModel.isForceUpdate.validate(),
    builder: (_) {
      return NewUpdateDialog();
    },
  );
}

Future<void> showForceUpdateDialog(BuildContext context) async {
  if (getBoolAsync(UPDATE_NOTIFY, defaultValue: true)) {
    getPackageInfo().then((value) {
      if (isAndroid && remoteConfigDataModel.android != null && remoteConfigDataModel.android!.versionCode.validate().toInt() > value.versionCode.validate().toInt()) {
        showNewUpdateDialog(context);
      } else if (isIOS && remoteConfigDataModel.iOS != null && remoteConfigDataModel.iOS!.versionCode.validate() != value.versionCode.validate()) {
        showNewUpdateDialog(context);
      }
    });
  }
}

bool get isCurrencyPositionLeft => getStringAsync(CURRENCY_POSITION, defaultValue: CURRENCY_POSITION_LEFT) == CURRENCY_POSITION_LEFT;

bool get isCurrencyPositionRight => getStringAsync(CURRENCY_POSITION, defaultValue: CURRENCY_POSITION_LEFT) == CURRENCY_POSITION_RIGHT;

bool isTodayAfterDate(DateTime val) => val.isAfter(todayDate);

Widget mobileNumberInfoWidget() {
  return RichTextWidget(
    list: [
      TextSpan(text: 'Thêm mã quốc gia', style: secondaryTextStyle(size: 12)),
      TextSpan(text: ' "84-" ', style: boldTextStyle(size: 12)),
      TextSpan(
        text: ' (Hướng dẫn)',
        style: boldTextStyle(size: 12, color: primaryColor),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            launchUrlCustomTab("https://countrycode.org/");
          },
      ),
    ],
  );
}
