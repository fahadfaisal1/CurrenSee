import 'package:curren_see/auth/main_page.dart';
import 'package:curren_see/pages/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //final AppTheme appTheme = AppTheme();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    // theme: AppTheme.lightTheme,
    // darkTheme: AppTheme.darkTheme,
    // themeMode: appTheme.currentTheme,
    initialRoute: 'main',
    routes: {
      'main': (context)=> const MainPage(),

    },
  ));
}
