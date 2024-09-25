// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last, unused_local_variabl

import 'package:flutter/material.dart';
import 'package:qrail_fp/project/screens/home_pages/home.dart';
import 'package:qrail_fp/project/screens/auth_pages/forgot_password.dart';
import 'package:qrail_fp/project/screens/auth_pages/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}


class _LoginScreenState extends State<LoginScreen> {

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // Key for form state management

  // Error messages for username and password fields.
  String? _usernameError;
  String? _passwordError;

  // Hardcoded username and password
  final String _hardcodedUsername = "user";
  final String _hardcodedPassword = "password@123";

 //error  dialog for invalid login
  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'OK',
                style: TextStyle(fontSize: 17, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  //function to handle login
  void _handleLogin() {
    String username = _userNameController.text.trim();
    String password = _passwordController.text.trim();

    if (username == _hardcodedUsername && password == _hardcodedPassword) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      showErrorDialog("Invalid username or password");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(24),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  _header(context),
                  _inputField(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _header(context) {
    return Column(
      children: <Widget>[
        Center(
          child: Text("Login Here",
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
        ),
        SizedBox(height: 30.0),
        Text(
          "welcome back you've been missed",
          style: TextStyle(
            color: Color.fromARGB(255, 8, 8, 8),
            fontSize: 15.0,
          ),
          textAlign: TextAlign.justify,
        ),
        SizedBox(height: 40.0),
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/logo.jpg'),
          radius: 65.0,
        ),
        SizedBox(height: 40.0),
      ],
    );
  }

  _inputField(context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(30, 20, 30, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          TextFormField(
            controller: _userNameController,
            decoration: InputDecoration(
              labelText: "Email",
              prefixIcon: Icon(Icons.person),
            ),
            // Resets username error on change
            onChanged: (value) => setState(() => _usernameError = null),
          ),
          if (_usernameError != null)
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                _usernameError!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          SizedBox(
            height: 15.0,
          ),
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: "Password",
              prefixIcon: Icon(Icons.lock),
            ),

            onChanged: (value) => setState(() => _passwordError = null),
            obscureText: true,
          ),
          if (_passwordError != null)
            Container(
              margin: EdgeInsets.only(top: 5),
              child: Text(
                _passwordError!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          SizedBox(
            height: 9.0,
          ),

          //forget pasword section
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const ForgotPassword()),
              );
            },
            child: Text(
              "Forgot your password?",
              style: TextStyle(color: Colors.blueGrey),
            ),
            style: ButtonStyle(
              alignment: Alignment.centerRight,
            ),
          ),

          //login button
          ElevatedButton(
            onPressed: _handleLogin,
            child: Text(
              'Login',
              style: TextStyle(fontSize: 17, color: Colors.white),
            ),
          ),

          //new account
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) => SignUp()),
              );
            },
            child: Text("Create new account",
                style: TextStyle(color: Colors.blueGrey)),
          ),
        ],
      ),
    );
  }

  // Future<void> _handleSignIn() async {
  //   String username = _userNameController.text.trim();
  //   String password = _passwordController.text.trim();

  //   if (username.isNotEmpty && password.isNotEmpty) {
  //     try {
  //       final response = await LoginService().login(username, password);
  //       //Handle successful login
  //       final prefs = await SharedPreferences.getInstance();
  //       String jwtToken = response['access_token'];
  //       await prefs.setString('jwt', jwtToken);
  //       Navigator.pushReplacement(
  //         // ignore: use_build_context_synchronously
  //         context,
  //         MaterialPageRoute(builder: (context) => const HomePage()),
  //       );
  //     } on Exception catch (e) {
  //       //handle error
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text(e.toString())),
  //       );
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(content: Text('Please enter a username and password')),
  //     );
  //   }
  // }
}
