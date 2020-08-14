//Imports that are not mine
import 'package:flutter/material.dart';

//Imports that are mine
import 'package:fark/src/model/user_model.dart';

class ProfileRandomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final UserModel userData = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('${userData.nombre}'),
      ),
      body: Center(
        child: Text('Profile Random'),
      ),
    );
  }
}