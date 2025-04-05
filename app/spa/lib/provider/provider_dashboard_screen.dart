import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/fragments/booking_fragment.dart';
import 'package:spa_manager_flutter/fragments/notification_fragment.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/provider/fragments/provider_home_fragment.dart';
import 'package:spa_manager_flutter/provider/fragments/provider_payment_fragment.dart';
import 'package:spa_manager_flutter/provider/fragments/provider_profile_fragment.dart';
import 'package:spa_manager_flutter/screens/chat/user_chat_list_screen.dart';
import 'package:spa_manager_flutter/utils/colors.dart';
import 'package:spa_manager_flutter/utils/common.dart';
import 'package:spa_manager_flutter/utils/configs.dart';
import 'package:spa_manager_flutter/utils/constant.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:spa_manager_flutter/utils/extensions/string_extension.dart';
import 'package:spa_manager_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class ProviderDashboardScreen extends StatefulWidget {
  final int? index;

  ProviderDashboardScreen({this.index});

  @override
  ProviderDashboardScreenState createState() => ProviderDashboardScreenState();
}

class ProviderDashboardScreenState extends State<ProviderDashboardScreen> {
  int currentIndex = 0;

  DateTime? currentBackPressTime;

  List<Widget> fragmentList = [
    ProviderHomeFragment(),
    BookingFragment(),
    ProviderPaymentFragment(),
    ProviderProfileFragment(),
  ];

  List<String> screenName = [];

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    afterBuildCreated(
      () async {
        if (getIntAsync(THEME_MODE_INDEX) == THEME_MODE_SYSTEM) {
          appStore.setDarkMode(context.platformBrightness() == Brightness.dark);
        }

        window.onPlatformBrightnessChanged = () async {
          if (getIntAsync(THEME_MODE_INDEX) == THEME_MODE_SYSTEM) {
            appStore.setDarkMode(context.platformBrightness() == Brightness.light);
          }
        };
      },
    );

    LiveStream().on(LIVESTREAM_PROVIDER_ALL_BOOKING, (index) {
      currentIndex = index as int;
      setState(() {});
    });

    await 3.seconds.delay;
    showForceUpdateDialog(context);
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  void dispose() {
    super.dispose();
    LiveStream().dispose(LIVESTREAM_PROVIDER_ALL_BOOKING);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        DateTime now = DateTime.now();

        if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
          currentBackPressTime = now;
          toast(context.translate.lblCloseAppMsg);
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Scaffold(
        appBar: appBarWidget(
          [
            context.translate.lblProviderDashboard,
            context.translate.lblBooking,
            context.translate.lblPayment,
            context.translate.lblProfile,
          ][currentIndex],
          color: primaryColor,
          textColor: Colors.white,
          showBack: false,
          actions: [
            IconButton(
              icon: chat.iconImage(color: white, size: 20),
              onPressed: () async {
                ChatListScreen().launch(context);
              },
            ),
            IconButton(
              icon: ic_notification.iconImage(color: white, size: 20),
              onPressed: () async {
                NotificationFragment().launch(context);
              },
            ),
          ],
        ),
        body: fragmentList[currentIndex],
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          height: 60,
          destinations: [
            NavigationDestination(
              icon: ic_home.iconImage(color: appTextSecondaryColor),
              selectedIcon: ic_fill_home.iconImage(color: white),
              label: context.translate.lblProviderDashboard,
            ),
            NavigationDestination(
              icon: total_booking.iconImage(color: appTextSecondaryColor),
              selectedIcon: fill_ticket.iconImage(color: white),
              label: context.translate.lblBooking,
            ),
            NavigationDestination(
              icon: un_fill_wallet.iconImage(color: appTextSecondaryColor),
              selectedIcon: ic_fill_wallet.iconImage(color: white),
              label: context.translate.lblPayment,
            ),
            NavigationDestination(
              icon: profile.iconImage(color: appTextSecondaryColor),
              selectedIcon: ic_fill_profile.iconImage(color: white),
              label: context.translate.lblProfile,
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
