import 'package:actcms_spa_flutter/app_theme.dart';
import 'package:actcms_spa_flutter/locale/app_localizations.dart';
import 'package:actcms_spa_flutter/locale/languages_vi.dart';
import 'package:actcms_spa_flutter/locale/languages.dart';
import 'package:actcms_spa_flutter/model/material_you_model.dart';
import 'package:actcms_spa_flutter/model/remote_config_data_model.dart';
import 'package:actcms_spa_flutter/screens/splash_screen.dart';
import 'package:actcms_spa_flutter/services/auth_services.dart';
import 'package:actcms_spa_flutter/services/chat_messages_service.dart';
import 'package:actcms_spa_flutter/services/user_services.dart';
import 'package:actcms_spa_flutter/store/app_store.dart';
import 'package:actcms_spa_flutter/store/filter_store.dart';
import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:actcms_spa_flutter/utils/common.dart';
import 'package:actcms_spa_flutter/utils/configs.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

AppStore appStore = AppStore();
FilterStore filterStore = FilterStore();
BaseLanguage language = LanguageVi();

UserService userService = UserService();
AuthServices authService = AuthServices();
ChatMessageService chatMessageService = ChatMessageService();

RemoteConfigDataModel remoteConfigDataModel = RemoteConfigDataModel();

String currentPackageName = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  passwordLengthGlobal = 6;
  appButtonBackgroundColorGlobal = primaryColor;
  defaultAppButtonTextColorGlobal = Colors.white;
  defaultRadius = 12;
  defaultBlurRadius = 0;
  defaultSpreadRadius = 0;
  textSecondaryColorGlobal = appTextPrimaryColor;
  textPrimaryColorGlobal = appTextSecondaryColor;
  defaultAppButtonElevation = 0;
  pageRouteTransitionDurationGlobal = 400.milliseconds;

  await initialize();
  localeLanguageList = languageList();

  Stripe.publishableKey = STRIPE_PAYMENT_PUBLISH_KEY;

  Firebase.initializeApp().then((value) {
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

    setupFirebaseRemoteConfig();
  });

  await appStore.setLanguage(getStringAsync(SELECTED_LANGUAGE_CODE, defaultValue: DEFAULT_LANGUAGE));
  await appStore.setLoggedIn(getBoolAsync(IS_LOGGED_IN), isInitializing: true);

  int themeModeIndex = getIntAsync(THEME_MODE_INDEX);
  if (themeModeIndex == THEME_MODE_LIGHT) {
    appStore.setDarkMode(false);
  } else if (themeModeIndex == THEME_MODE_DARK) {
    appStore.setDarkMode(true);
  }

  OneSignal.shared.setAppId(ONESIGNAL_APP_ID).then((value) {
    OneSignal.shared.setNotificationWillShowInForegroundHandler((OSNotificationReceivedEvent event) {
      event.complete(event.notification);
    });

    OneSignal.shared.consentGranted(true);
    OneSignal.shared.promptUserForPushNotificationPermission();
    OneSignal.shared.sendTag(ONESIGNAL_TAG_KEY, ONESIGNAL_TAG_VALUE);

    saveOneSignalPlayerId();
  });

  await appStore.setUseMaterialYouTheme(getBoolAsync(USE_MATERIAL_YOU_THEME), isInitializing: true);

  if (appStore.isLoggedIn) {
    await appStore.setUserId(getIntAsync(USER_ID), isInitializing: true);
    await appStore.setFirstName(getStringAsync(FIRST_NAME), isInitializing: true);
    await appStore.setLastName(getStringAsync(LAST_NAME), isInitializing: true);
    await appStore.setUserEmail(getStringAsync(USER_EMAIL), isInitializing: true);
    await appStore.setUserName(getStringAsync(USERNAME), isInitializing: true);
    await appStore.setContactNumber(getStringAsync(CONTACT_NUMBER), isInitializing: true);
    await appStore.setUserProfile(getStringAsync(PROFILE_IMAGE), isInitializing: true);
    await appStore.setCountryId(getIntAsync(COUNTRY_ID), isInitializing: true);
    await appStore.setStateId(getIntAsync(STATE_ID), isInitializing: true);
    await appStore.setCityId(getIntAsync(COUNTRY_ID), isInitializing: true);
    await appStore.setUId(getStringAsync(UID), isInitializing: true);
    await appStore.setToken(getStringAsync(TOKEN), isInitializing: true);
    await appStore.setAddress(getStringAsync(ADDRESS), isInitializing: true);
    await appStore.setCurrencyCode(getStringAsync(CURRENCY_COUNTRY_CODE), isInitializing: true);
    await appStore.setCurrencyCountryId(getStringAsync(CURRENCY_COUNTRY_ID), isInitializing: true);
    await appStore.setCurrencySymbol(getStringAsync(CURRENCY_COUNTRY_SYMBOL), isInitializing: true);
    await appStore.setPrivacyPolicy(getStringAsync(PRIVACY_POLICY), isInitializing: true);
    await appStore.setLoginType(getStringAsync(LOGIN_TYPE), isInitializing: true);
    await appStore.setTermConditions(getStringAsync(TERM_CONDITIONS), isInitializing: true);
    await appStore.setInquiryEmail(getStringAsync(INQUIRY_EMAIL), isInitializing: true);
    await appStore.setHelplineNumber(getStringAsync(HELPLINE_NUMBER), isInitializing: true);
  }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RestartAppWidget(
      child: Observer(
        builder: (_) => FutureBuilder<Color>(
          future: getMaterialYouData(),
          builder: (_, snap) {
            return Observer(
              builder: (_) => MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: navigatorKey,
                home: SplashScreen(),
                theme: AppTheme.lightTheme(color: snap.data),
                darkTheme: AppTheme.darkTheme(color: snap.data),
                themeMode: appStore.isDarkMode ? ThemeMode.dark : ThemeMode.light,
                title: APP_NAME,
                supportedLocales: LanguageDataModel.languageLocales(),
                localizationsDelegates: [
                  AppLocalizations(),
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                localeResolutionCallback: (locale, supportedLocales) => locale,
                locale: Locale(appStore.selectedLanguageCode),
              ),
            );
          },
        ),
      ),
    );
  }
}
