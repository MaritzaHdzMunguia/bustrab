import 'dart:async';
import 'package:bustrab/src/blocs/validators.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _usuarioController = BehaviorSubject<String>();
  final _fechaController = BehaviorSubject<String>();

  // Recuperar  los datos del Stream

  Stream<String> get emailStream =>
      _emailController.stream.transform(validarEmail);
  Stream<String> get usuarioStream =>
      _usuarioController.stream.transform(validarUsuario);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validarPassword);
  Stream<String> get fechaStream =>
      _fechaController.stream.transform(validarFecha);

  Stream<bool> get formValidStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) => true);
  // Insertar valores al Stream

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(String) get changeUsuario => _usuarioController.sink.add;
  Function(String) get changeFecha => _fechaController.sink.add;
  //obtener el ultimo valor ingresado a los streams
  String get email => _emailController.value;
  String get password => _passwordController.value;
  String get usuario => _passwordController.value;
  String get fecha => _fechaController.value;

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _usuarioController?.close();
    _fechaController?.close();
  }
}
