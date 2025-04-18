import 'package:actcms_spa_flutter/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nb_utils/nb_utils.dart';

class AppTheme {
  //
  AppTheme._();

  static ThemeData lightTheme({Color? color}) => ThemeData(
        primarySwatch: createMaterialColor(color ?? primaryColor),
        primaryColor: color ?? primaryColor,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: GoogleFonts.quicksand().fontFamily,
        useMaterial3: true,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: Colors.white),
        iconTheme: IconThemeData(color: appTextSecondaryColor),
        textTheme: GoogleFonts.quicksandTextTheme(),
        dialogBackgroundColor: Colors.white,
        unselectedWidgetColor: Colors.black,
        dividerColor: borderColor,
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
          backgroundColor: Colors.white,
        ),
        cardColor: cardColor,
        appBarTheme: AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light)),
        dialogTheme: DialogTheme(shape: dialogShape()),
        navigationBarTheme: NavigationBarThemeData(labelTextStyle: MaterialStateProperty.all(primaryTextStyle(size: 10))),
        pageTransitionsTheme: PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );

  static ThemeData darkTheme({Color? color}) => ThemeData(
        primarySwatch: createMaterialColor(primaryColor),
        primaryColor: primaryColor,
        appBarTheme: AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
        ),
        scaffoldBackgroundColor: scaffoldColorDark,
        fontFamily: GoogleFonts.quicksand().fontFamily,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(backgroundColor: scaffoldSecondaryDark),
        iconTheme: IconThemeData(color: Colors.white),
        textTheme: GoogleFonts.quicksandTextTheme(),
        dialogBackgroundColor: scaffoldSecondaryDark,
        unselectedWidgetColor: Colors.white60,
        useMaterial3: true,
        bottomSheetTheme: BottomSheetThemeData(
          shape: RoundedRectangleBorder(borderRadius: radiusOnly(topLeft: defaultRadius, topRight: defaultRadius)),
          backgroundColor: scaffoldSecondaryDark,
        ),
        dividerColor: dividerDarkColor,
        cardColor: scaffoldSecondaryDark,
        dialogTheme: DialogTheme(shape: dialogShape()),
        navigationBarTheme: NavigationBarThemeData(labelTextStyle: MaterialStateProperty.all(primaryTextStyle(size: 10, color: Colors.white))),
      ).copyWith(
        pageTransitionsTheme: PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.linux: OpenUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
      );
}
