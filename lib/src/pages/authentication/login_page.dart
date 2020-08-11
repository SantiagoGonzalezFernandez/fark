//Imports that are not mine
import 'package:fark/src/utils/background_gradient.dart';
import 'package:fark/src/utils/fadeAnimation.dart';
import 'package:flutter/material.dart';

//Imports that are mine

class LoginPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: generateBackgroundGradient()
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 110.0),
              TitleAndSubtitle(),
              SizedBox(height: 20.0),
              Expanded(
                child: ContainerMain(),
              )
            ],
          ),
        ),
      )
    );
  }
}

class TitleAndSubtitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FadeAnimation(
            delay: 1,
            child: Text(
              'Iniciar Sesion',
               style: TextStyle(
                 color: Colors.white,
                 fontSize: 40.0,
                 fontFamily: 'ProductSans'
               ),
            ),
          ),
          SizedBox(height: 10.0),
          FadeAnimation(
            delay: 1.1,
            child: Text(
              'Animate a creer en vos',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ContainerMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(60.0),
          topRight: Radius.circular(60.0),
        )
      ),
      child: Padding(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(height: 60.0),
            FormLogin(),
            SizedBox(height: 40.0),
            GreyTextFadeAnimation(
              delay: 1.5,
              text: 'Olvidaste tu contraseña?',
            ),
            SizedBox(height: 40.0),
            GestureDetector(
              onTap: () => print('Navegar al home'),
              child: ButtonIniciarSesion(
                delay: 1.6,
                text: 'Iniciar Sesion',
                color: Color(0xff2AB7CA),
              ),
            ),
            SizedBox(height: 40.0),
            GestureDetector(
              onTap: () => print('Navegar al Sign Up'),
              child: GreyTextFadeAnimation(
                delay: 1.7,
                text: 'No tienes cuenta? Registrate',
              ),
            )
          ],
        ),
      ),
    );
  }
}

class FormLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: 1.4,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [BoxShadow(
            color: Color(0xff2AB7CA),
            blurRadius: 20.0,
            offset: Offset(0, 10)
          )]
        ),
        child: Column(
          children: [
            TextFieldLogin(
              hintText: 'Correo Electronico',
              textInputType: TextInputType.emailAddress,
              isPassword: false,
            ),
            TextFieldLogin(
              hintText: 'Contraseña',
              isPassword: true,
            )
          ],
        ),
      ),
    );
  }
}

class TextFieldLogin extends StatelessWidget {

  final String hintText;
  final TextInputType textInputType;
  final bool isPassword;

  TextFieldLogin({
    @required this.hintText,
    @required this.isPassword,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[200]
          )
        )
      ),
      child: TextField(
        keyboardType: textInputType,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey
          ),
          border: InputBorder.none
        ),
      ),
    );
  }
}

class GreyTextFadeAnimation extends StatelessWidget {

  final double delay;
  final String text;

  GreyTextFadeAnimation({
    this.delay = 1,
    this.text  = 'Grey Text'  
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: delay,
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey
        ),
      ),
    );
  }
}

class ButtonIniciarSesion extends StatelessWidget {

  final double delay;
  final String text;
  final Color color;

  ButtonIniciarSesion({
    this.delay = 1,
    this.text  = 'Iniciar Sesion',
    @required this.color
  });

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      delay: delay,
      child: Container(
        height: 50.0,
        margin: EdgeInsets.symmetric(horizontal: 50.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: color
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
              fontFamily: 'ProductSans'
            ),
          ),
        ),
      ),
    );
  }
}