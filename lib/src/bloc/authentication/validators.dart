//Imports that are not mine
import 'dart:async';

//Imports that are mine

class Validators{

  final validarEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink){
      
      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if(regExp.hasMatch(email)){
        sink.add(email);
      }else{
        sink.addError('El email no es valido');
      }
    }
  );
  
  final validarPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink){
      if(password.length >= 6){
        sink.add(password);
      }else{
        sink.addError('La Contraseña debe tener 6 o mas caracteres');
      }
    }
  );
}

// Stream<bool> get formValidStream =>
//        Rx.combineLatest2(emailStream, passwStream, (e, p) => true);