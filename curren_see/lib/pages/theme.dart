import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier{
  bool _isDarkTheme = true;
  ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme()
  {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black54,
      appBarTheme: AppBarTheme(color: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
        ),
      ),

      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
          headline4: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
      )
  );

  static ThemeData lightTheme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(color: Colors.white),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.red,
        ),
      ),

      iconTheme: IconThemeData(color: Colors.white),
      textTheme: TextTheme(
          headline4: TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w500,
          ),
      )
  );
}

