import 'package:bustrab/src/blocs/login_bloc.dart';
import 'package:bustrab/src/blocs/provider.dart';
import 'package:bustrab/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';
//import 'dart:async';

import 'package:bustrab/src/utils/utils.dart';

class RegistroPage extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    //Color.fromRGBO(255, 255, 255, 1);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final bloc = Provider.of(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 40.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 1.0),
            padding: EdgeInsets.symmetric(vertical: 30.5),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
                //Text('Registrarse', style: TextStyle(fontSize: 25.0)),
                SizedBox(height: 40.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearUsuario(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 30.0),
                _fecha(bloc),
                SizedBox(height: 30.0),
                _crearBoton(bloc),
                SizedBox(height: 150.0),
                FlatButton(
                  child: Text('Ya tienes cuenta? Ingresa',
                      style: TextStyle(color: Colors.black54)),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'login3'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      // stream: bloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
                icon:
                    Icon(Icons.alternate_email, color: Colors.lightBlueAccent),
                hintText: 'Ejemplo@correo.com',
                labelText: 'Correo electronico',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      // stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outlined, color: Colors.lightBlueAccent),
                labelText: 'Contraseña',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
          ),
        );
      },
    );
  }

  Widget _crearUsuario(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.usuarioStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                icon: Icon(Icons.account_circle, color: Colors.lightBlueAccent),
                hintText: 'User1199',
                labelText: 'Usuario',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeUsuario,
          ),
        );
      },
    );
  }

  Widget _fecha(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.fechaStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            keyboardType: TextInputType.name,
            decoration: InputDecoration(
                icon: Icon(Icons.date_range_outlined,
                    color: Colors.lightBlueAccent),
                hintText: 'DD/MM/YY',
                labelText: 'Fecha',
                counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeFecha,
          ),
        );
      },
    );
  }

  Widget _crearBoton(LoginBloc bloc) {
    //formValidStream

    return StreamBuilder(
      stream: bloc.formValidStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 75.0, vertical: 10.0),
            child: Text('Ingresar', style: TextStyle(fontSize: 16.0)),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Color.fromRGBO(4, 102, 200, 1),
          textColor: Colors.white,
          onPressed: () => _register(bloc, context),
        );
      },
    );
  }

  _register(LoginBloc bloc, BuildContext context) async {
    final info = await usuarioProvider.nuevoUsuario(
        bloc.email, bloc.usuario, bloc.password, bloc.fecha);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'tab');
    } else {
      mostrarAlerta(context, info['mensaje']);
    }
    //Navigator.pushReplacementNamed(context, 'home');
  }

  Widget _crearFondo(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final fondoMorado = Container(
      height: size.height * 0.1,
      width: double.infinity,
      decoration: BoxDecoration(
          //color: Color.fromRGBO(255, 255, 255, 1),
          ),
    );

    return Stack(
      children: <Widget>[
        fondoMorado,
        Container(
          padding: EdgeInsets.only(top: 80.0),
          child: Column(
            children: <Widget>[
              Text('Registrarse',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontFamily: 'Raleway')),

              SizedBox(height: 50.0, width: double.infinity),

              // Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
            ],
          ),
        )
      ],
    );
  }
}
