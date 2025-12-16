import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFF3B9CA7);
  static const Color whiteBackground = Color(0x00FFFFFF);
  static const Color background = Color(0xFF2C8AA4);
  static const Color fieldBorder = Color(0xFFCBD5E1);
  static const Color inactiveTextField = Color(0xFF9E9E9E);
  static const Color facebook = Color(0xFF1877F2);
  static const Color fontPrimary = Color(0xFF263238);

  static const Color progressBarBackground = Color(0xFFC0C0C0);
  static const Color progressBarValue = Color(0xFF4C586B);
}

class AppSpacing {
  static const EdgeInsets screenPadding = EdgeInsets.all(20);
}

class AppConfig {
  static const String urlEmulatorAndroid = 'http://10.0.2.2:8000/api';
  static const String urlAndroidAsli = 'http://10.140.97.100:8000/api';
  static const String baseUrl = urlEmulatorAndroid;
}
