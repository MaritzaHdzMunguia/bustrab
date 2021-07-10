import 'dart:async';

class Validators {
  final validarEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(email)) {
      sink.add(email);
    } else {
      sink.addError('Email no es correcto');
    }
  });

  final validarUsuario = StreamTransformer<String, String>.fromHandlers(
      handleData: (usuario, sink) {
    if (usuario.length >= 6) {
      sink.add(usuario);
    } else {
      sink.addError('Numeros y letras');
    }
  });

  final validarPassword = StreamTransformer<String, String>.fromHandlers(
      handleData: (password, sink) {
    if (password.length >= 6) {
      sink.add(password);
    } else {
      sink.addError('Más de 6 caracteres por favor');
    }
  });

  final validarFecha =
      StreamTransformer<String, String>.fromHandlers(handleData: (fecha, sink) {
    Pattern pattern =
        r'^(0?[1-9]|[12][0-9]|3[01])[\/\-](0?[1-9]|1[012])[\/\-]\d{4}$';
    RegExp regExp = new RegExp(pattern);
    if (regExp.hasMatch(fecha)) {
      sink.add(fecha);
    } else {
      sink.addError('Fecha en formato incorrecto');
    }
  });
}
