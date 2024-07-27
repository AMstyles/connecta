import 'package:dating_app/Widgets/callIndex.dart';
import 'package:dating_app/screens/Login/SignInScreen.dart';
import 'package:dating_app/screens/Registration/SignUpScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Widgets/themeNotifier.dart';
import 'screens/homeScreen.dart';


void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: SignupScreen(),
    );
  }
}
