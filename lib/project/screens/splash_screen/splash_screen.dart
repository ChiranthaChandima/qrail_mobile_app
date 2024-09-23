import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    _timer = Timer(const Duration(milliseconds: 4000), () {
      Navigator.of(context).pushReplacementNamed('/welcome');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              child: Image.asset('assets/images/logo.jpg'),
            )
          ],
        ),
      ),
    );
  }
}
