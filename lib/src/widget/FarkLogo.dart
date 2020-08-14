//Imports that are not mine
import 'package:flutter/material.dart';

//Imports that are mine

class FarkLogo extends StatelessWidget {

  final double fontSize;

  FarkLogo({
    @required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SpecialLetter(
          letter: 'F', 
          color: Color(0xff00008B),
          fontSize: fontSize,
        ),
        SpecialLetter(
          letter: 'A', 
          color: Color(0xffFFFFFF),
          fontSize: fontSize,
        ),
        SpecialLetter(
          letter: 'R', 
          color: Color(0xff000F08),
          fontSize: fontSize,
        ),
        SpecialLetter(
          letter: 'K', 
          color: Color(0xffFF0000),
          fontSize: fontSize,
        ),
      ],
    );
  }
}

class SpecialLetter extends StatelessWidget {

  final String letter;
  final Color  color;
  final double fontSize;

  const SpecialLetter({
    @required this.letter,
    @required this.color,
    @required this.fontSize
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      letter,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontFamily: 'ProductSans',
      ),
    );
  }
}