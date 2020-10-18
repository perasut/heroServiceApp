import 'package:flutter/material.dart';
import 'package:heroServiceApp/routers.dart';
import 'package:heroServiceApp/themes/style.dart';
import 'package:shared_preferences/shared_preferences.dart';

var appStep;
var initURL;

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  // appStep = sharedPreferences.getInt('appStep');
  // if (appStep == 1) {
  //   initURL = '/login';
  // } else if (appStep == 2) {
  //   initURL = '/dashboard';
  // } else if (appStep == 3) {
  //   initURL = '/lockscreen';
  // } else {
  //   initURL = '/welcome';
  // }
  WidgetsFlutterBinding.ensureInitialized();

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  appStep = sharedPreferences.getInt('appStep');

  if (appStep == 1) {
    print('appstep = $appStep');
    initURL = '/login';
  } else if (appStep == 2) {
    print('appstep = $appStep');
    initURL = '/dashboard';
  } else if (appStep == 3) {
    print('appstep = $appStep');
    initURL = '/lockscreen';
  } else {
    print('appstep = $appStep');
    initURL = '/welcome';
  }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: appTheme(),
      initialRoute: initURL,
      routes: routes,
    );
  }
}
