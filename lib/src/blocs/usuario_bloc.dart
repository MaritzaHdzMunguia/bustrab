import 'dart:io';

import 'package:bustrab/src/models/usuario_model.dart';
import 'package:bustrab/src/providers/providerUsuario.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:rxdart/rxdart.dart';

class UsuarioBloc {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final _usuarioController = new BehaviorSubject<List<UsuarioModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _usuarioProvider = new UsProvider();

  Stream<List<UsuarioModel>> get usuarioStream => _usuarioController.stream;

  Stream<bool> get cargando => _cargandoController.stream;

  void cargarUsuario() async {
    final usuario = await _usuarioProvider.cargarUsuario();
    _usuarioController.sink.add(usuario);
  }

  void agregarUsuario(UsuarioModel usuario) async {
    _cargandoController.sink.add(true);

    await _usuarioProvider.crearUsuario(usuario);
    _cargandoController.sink.add(false);
  }

  Future<String> subirFoto(File foto) async {
    _cargandoController.sink.add(true);

    final fotoUrl = await _usuarioProvider.subirImagen(foto);

    _cargandoController.sink.add(false);

    return fotoUrl;
  }

  void editarUsuario(UsuarioModel usuario) async {
    _cargandoController.sink.add(true);

    await _usuarioProvider.editarUsuario(usuario);
    _cargandoController.sink.add(false);
  }

  void borrarUsuario(String id) async {
    await _usuarioProvider.borrarUsuario(id);
  }

  dispose() {
    _usuarioController?.close();
    _cargandoController?.close();
  }

  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
