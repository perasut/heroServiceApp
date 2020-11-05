import 'package:flutter/material.dart';
import 'package:heroServiceApp/screens/dashboard/dashboard_screen.dart';
import 'package:heroServiceApp/screens/lockscreen/lock_screen.dart';
import 'package:heroServiceApp/screens/login/login_screen.dart';
import 'package:heroServiceApp/screens/newsdetail/newsdetail_screen.dart';
import 'package:heroServiceApp/screens/qrcode/qrcode_screeen.dart';
import 'package:heroServiceApp/screens/userprofile/userprofile_screen.dart';
import 'package:heroServiceApp/screens/welcome/welcome_screen.dart';


// สร้างตัวแปร Map ไว้เก็บ URL และ Screen
final Map<String, WidgetBuilder> routes = <String, WidgetBuilder>{
  "/welcome": (BuildContext context) => WelcomeScreen(),
  "/dashboard": (BuildContext context) => DashboardScreen(),
  "/lockscreen": (BuildContext context) => LockScreen(),
  "/login": (BuildContext context) => LoginScreen(),
  "/userprofile": (BuildContext context) => UserProfileScreen(),
  "/newsdetail": (BuildContext context) => NewsDetailScreen(),
  "/qrcode": (BuildContext context) => QRCodeScreen(),
};
