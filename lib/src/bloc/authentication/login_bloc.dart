//Imports that are not mine
import 'dart:async';
import 'package:rxdart/rxdart.dart';

//Imports that are mine
import 'package:fark/src/bloc/authentication/validators.dart';

class LoginBloc with Validators{

  final _emailController    = BehaviorSubject<String>();  
  final _passwordController = BehaviorSubject<String>(); 

  // Recuperar los datos del stream
  Stream<String> get emailStream    => _emailController.stream.transform(validarEmail);
  Stream<String> get passwordStream => _passwordController.stream.transform(validarPassword);
  
  Stream<bool> get formValidStream => 
    Rx.combineLatest2(emailStream, passwordStream, (e, p) => true);

  // Insertar valores al Strem
  Function(String) get changeEmail    => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  // Obtener el ultimo valor ingresado a los Streams
  String get email    => _emailController.value;
  String get password => _passwordController.value;

  dispose(){
    _emailController?.close();
    _passwordController?.close();
  }

}


