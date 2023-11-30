import 'package:curren_see/auth/auth_page.dart';
import 'package:curren_see/auth/main_page.dart';
import 'package:curren_see/conversion/anyToAny.dart';
import 'package:curren_see/pages/feedback.dart';
import 'package:curren_see/pages/user_support.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


void main() async{
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'main',
    routes: {
      // 'main': (context) => const AnyToAny(currencies: {}, rates: null,),
      'main': (context)=> const MainPage(),

    },
  ));
}
