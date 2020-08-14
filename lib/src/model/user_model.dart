// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
      this.id,
      this.nombre = '',
      this.descripcion = '',
      this.edad = 0,
      this.trabajo = 'Sin Definir',
      this.experiencia = 'Sin Definir',
      this.fotoUrl,
  });

  String id;
  String nombre;
  String descripcion;
  int edad;
  String trabajo;
  String experiencia;
  String fotoUrl;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
      id          : json["id"],
      nombre      : json["nombre"],
      descripcion : json["descripcion"],
      edad        : json["edad"],
      trabajo     : json["trabajo"],
      experiencia : json["experiencia"],
      fotoUrl     : json["fotoUrl"],
  );

  Map<String, dynamic> toJson() => {
      "id"          : id,
      "nombre"      : nombre,
      "descripcion" : descripcion,
      "edad"        : edad,
      "trabajo"     : trabajo,
      "experiencia" : experiencia,
      "fotoUrl"     : fotoUrl,
  };
}
