//Imports that are not mine
import 'package:flutter/material.dart';

//Imports that are mine

LinearGradient generateBackgroundGradient() {
  return LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    stops: [
      0.1,
      0.4,
      0.7,
      0.99
    ],
    colors: [
      Color(0xff2AB7CA),
      Color(0xff2A67CA),
      Color(0xff3D2ACA),
      Color(0xff8D2ACA),
    ]
  );
}