//Imports that are not mine
import 'package:flutter/material.dart';

//Imports that are mine
import 'package:fark/src/pages/onboarding/onboarding_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
        body: OnboardingPage()
      ),
    );
  }
}