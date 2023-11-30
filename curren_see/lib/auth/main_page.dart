import 'package:curren_see/auth/auth_page.dart';
import 'package:curren_see/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../conversion/home.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          if (snapshot.hasData)
            {
              // return const HomePage();
              return const Home();
            } else
            {
              return const AuthPage();
            }
        },
      ),
    );
  }
}
