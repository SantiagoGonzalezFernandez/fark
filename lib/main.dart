//Imports that are not mine
import 'package:fark/src/pages/home/home_page.dart';
import 'package:flutter/material.dart';

//Imports that are mine
import 'package:fark/src/pages/onboarding/onboarding_page.dart';
import 'package:fark/src/pages/authentication/login_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fark',
      initialRoute: 'login',
      routes: {
        'onboarding' : (BuildContext context) => OnboardingPage(),
        'login'      : (BuildContext context) => LoginPage(),
        'home'       : (BuildContext context) => HomePage(),
      },
      home: Scaffold(
        body: OnboardingPage()
      ),
    );
  }
}