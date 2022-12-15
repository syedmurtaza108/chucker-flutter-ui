import 'package:chucker_flutter_ui/src/localization/localization.dart';
import 'package:chucker_flutter_ui/src/view/chucker_page.dart';
import 'package:chucker_flutter_ui/src/view/helper/chucker_ui_helper.dart';
import 'package:chucker_flutter_ui/src/view/helper/colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      localizationsDelegates: Localization.localizationsDelegates,
      supportedLocales: Localization.supportedLocales,
      locale: Localization.currentLocale,
      theme: ThemeData(
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          labelStyle: TextStyle(fontSize: 14),
        ),
        backgroundColor: primaryColor,
      ),
      home: const ChuckerPage(),
    ),
  );
}
