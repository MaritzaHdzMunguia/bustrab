import 'package:bustrab/src/blocs/productos_bloc.dart';
import 'package:bustrab/src/blocs/usuario_bloc.dart';
import 'package:flutter/material.dart';

import 'login_bloc.dart';

class Provider extends InheritedWidget {
  final loginBloc = new LoginBloc();
  final _productosBloc = new ProductosBloc();
  final _usuarioBloc = new UsuarioBloc();

  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }
    return _instancia;
  }
  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  //Provider({Key key, Widget child})
  //: super(key: key, child: child);
  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static LoginBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().loginBloc;
  }

  static ProductosBloc productosBloc(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<Provider>()
        ._productosBloc;
  }

  static UsuarioBloc usuarioBloc(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>()._usuarioBloc;
  }
}
