// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class WelcomScreen extends StatefulWidget {
  const WelcomScreen({super.key});

  @override
  State<WelcomScreen> createState() => _WelcomScreenState();
}

class _WelcomScreenState extends State<WelcomScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/logo.jpg'),
                radius: 110.0,
              ),
              SizedBox(height: 30.0),
              Text(
                "Welcome to QRail",
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15.0,
              ),
              Text(
                "All Aboard Sign in to Explore Train Travel with QRail",
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
              SizedBox(height: 80.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/second');
                },
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/third');
                },
                child: Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 17, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
