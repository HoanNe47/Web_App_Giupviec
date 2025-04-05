import 'dart:ui';

import 'package:actcms_spa_flutter/main.dart';
import 'package:actcms_spa_flutter/screens/auth/sign_in_screen.dart';
import 'package:actcms_spa_flutter/screens/booking/booking_detail_screen.dart';
import 'package:actcms_spa_flutter/screens/category/category_screen.dart';
import 'package:actcms_spa_flutter/screens/dashboard/fragment/booking_fragment.dart';
import 'package:actcms_spa_flutter/screens/dashboard/fragment/chat_fragment.dart';
import 'package:actcms_spa_flutter/screens/dashboard/fragment/dashboard_fragment.dart';
import 'package:actcms_spa_flutter/screens/dashboard/fragment/profile_fragment.dart';
import 'package:actcms_spa_flutter/screens/service/service_detail_screen.dart';
import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:actcms_spa_flutter/utils/common.dart';
import 'package:actcms_spa_flutter/utils/constant.dart';
import 'package:actcms_spa_flutter/utils/images.dart';
import 'package:actcms_spa_flutter/utils/string_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class DashboardScreen extends StatefulWidget {
  final bool? redirectToBooking;

  DashboardScreen({this.redirectToBooking});

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    if (widget.redirectToBooking.validate(value: false)) {
      currentIndex = 1;
      setState(() {});
    }

    afterBuildCreated(() async {
      // Handle Notification click and redirect to that Service & BookDetail screen
      if (isMobile) {
        OneSignal.shared.setNotificationOpenedHandler((OSNotificationOpenedResult notification) async {
          if (notification.notification.additionalData!.containsKey('ID')) {
            String? notId = notification.notification.additionalData!["ID"];
            if (notId.validate().isNotEmpty) {
              BookingDetailScreen(bookingId: notId.toString().toInt()).launch(context);
            }
          } else if (notification.notification.additionalData!.containsKey('service_id')) {
            String? notId = notification.notification.additionalData!["service_id"];
            if (notId.validate().isNotEmpty) {
              ServiceDetailScreen(serviceId: notId.toInt()).launch(context);
            }
          }
        });
      }

      // Changes System theme when changed
      if (getIntAsync(THEME_MODE_INDEX) == THEME_MODE_SYSTEM) {
        appStore.setDarkMode(context.platformBrightness() == Brightness.dark);
      }
      window.onPlatformBrightnessChanged = () async {
        if (getIntAsync(THEME_MODE_INDEX) == THEME_MODE_SYSTEM) {
          appStore.setDarkMode(context.platformBrightness() == Brightness.light);
        }
      };

      await 3.seconds.delay;
      showForceUpdateDialog(context);
    });
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return DoublePressBackWidget(
      message: language.lblBackPressMsg,
      child: Scaffold(
        body: [
          DashboardFragment(),
          Observer(builder: (context) => appStore.isLoggedIn ? BookingFragment() : SignInScreen(isFromDashboard: true)),
          CategoryScreen(),
          Observer(builder: (context) => appStore.isLoggedIn ? UserChatListScreen() : SignInScreen(isFromDashboard: true)),
          ProfileFragment(),
        ][currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          height: 60,
          destinations: [
            NavigationDestination(
              icon: ic_home.iconImage(color: appTextSecondaryColor),
              selectedIcon: ic_home.iconImage(color: white),
              label: language.dashboard,
            ),
            NavigationDestination(
              icon: ic_ticket.iconImage(color: appTextSecondaryColor),
              selectedIcon: ic_ticket.iconImage(color: white),
              label: language.booking,
            ),
            NavigationDestination(
              icon: ic_category.iconImage(color: appTextSecondaryColor),
              selectedIcon: ic_category.iconImage(color: white),
              label: language.category,
            ),
            NavigationDestination(
              icon: ic_chat.iconImage(color: appTextSecondaryColor),
              selectedIcon: ic_chat.iconImage(color: white),
              label: language.lblchat,
            ),
            NavigationDestination(
              icon: ic_profile2.iconImage(color: appTextSecondaryColor),
              selectedIcon: ic_profile2.iconImage(color: white),
              label: language.profile,
            ),
          ],
          onDestinationSelected: (index) {
            currentIndex = index;
            setState(() {});
          },
        ),
      ),
    );
  }
}
