import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppColor {
  static const Color primary = Color(0xFF3B9CA7);
  static const Color whiteBackground = Color(0x00FFFFFF);
  static const Color fieldBorder = Color(0xFFCBD5E1);
  static const Color inactiveTextField = Color(0xFF9E9E9E);
  static const Color facebook = Color(0xFF1877F2);
  static const Color fontPrimary = Color(0xFF263238);
}

class AppSpacing {
  static const EdgeInsets screenPadding = EdgeInsets.all(20);
}

class AppConfig {
  static const String urlEmulatorAndroid = 'http://10.0.2.2:8000/api';
  static const String urlAndroidAsli = 'http://192.168.0.103:8000/api';
  static const String baseUrl = urlEmulatorAndroid;
}
