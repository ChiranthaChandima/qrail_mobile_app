import 'dart:io';
import 'package:flutter/material.dart';
import 'package:qrail_fp/project/screens/splash_screen/splash_screen.dart';
import 'package:qrail_fp/project/screens/auth_pages/login_screen.dart';
import 'package:qrail_fp/project/screens/auth_pages/sign_up.dart';
import 'package:qrail_fp/project/screens/auth_pages/welcome_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl_standalone.dart'
    if (dart.library.html) 'package:intl/intl_browser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await findSystemLocale();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/second',
      routes: {
        '/': (context) => const SplashScreen(),
        '/welcome': (context) => const WelcomScreen(),
//'/second' :(context) => TrainSchedule(),
        // '/second' :(context) => TrainSchedule(),
        '/second': (context) => const LoginScreen(),
        '/third': (context) => const SignUp(),
      },
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  Colors.blueGrey,
                ),
                padding: WidgetStateProperty.all(const EdgeInsets.all(10.0)),
                shape: WidgetStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0))))),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
              borderSide: BorderSide(
            color: Color.alphaBlend(Colors.black, Colors.white),
            style: BorderStyle.solid,
          )),
        ),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
