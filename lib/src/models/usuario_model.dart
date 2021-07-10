// To parse this JSON data, do
//
//     final productoModel = productoModelFromJson(jsonString);

import 'dart:convert';

UsuarioModel usuarioModelFromJson(String str) =>
    UsuarioModel.fromJson(json.decode(str));

String usuarioModelToJson(UsuarioModel data) => json.encode(data.toJson());

class UsuarioModel {
  UsuarioModel({
    this.id,
    this.nombre = '',
    this.apellidos = '',
    this.fecha = '',
    // this.disponible = true,
    this.fotoUrl,
  });

  String id;
  String nombre;
  String apellidos;
  String fecha;

  // bool disponible;
  String fotoUrl;

  factory UsuarioModel.fromJson(Map<String, dynamic> json) => UsuarioModel(
        id: json["id"],
        nombre: json["nombre"],
        apellidos: json["apellidos"],
        fecha: json["fecha"],
        //  disponible: json["disponible"],
        fotoUrl: json["fotoUrl"],
      );

  Map<String, dynamic> toJson() => {
        //"id": id,
        "nombre": nombre,
        "apellidos": apellidos,
        "fecha": fecha,
        //    "disponible": disponible,
        "fotoUrl": fotoUrl,
      };
}
