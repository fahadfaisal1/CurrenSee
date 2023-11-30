import 'package:curren_see/pages/signin.dart';
import 'package:curren_see/pages/signup.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {

  bool showLoginPage = true;

  void toggleScreens()
  {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
        return SignIn(showRegisterPage: toggleScreens);
      } else {
        return SignUp(showLoginPage: toggleScreens);
    }
  }
}
