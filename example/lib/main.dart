import 'package:chucker_flutter_ui/chucker_flutter_ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      navigatorObservers: [ChuckerFlutter.navigatorObserver],
      home: Scaffold(body: ChuckerFlutter.chuckerButton),
    ),
  );
}
