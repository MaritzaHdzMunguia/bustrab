import 'package:bustrab/src/blocs/login_bloc.dart';
import 'package:bustrab/src/blocs/provider.dart';
import 'package:bustrab/src/pages/ForgetScreen.dart';
import 'package:bustrab/src/providers/usuario_provider.dart';
import 'package:flutter/material.dart';

import 'package:bustrab/src/utils/utils.dart';

class LoginPage3 extends StatelessWidget {
  final usuarioProvider = new UsuarioProvider();

  @override
  Widget build(BuildContext context) {
    // Color.fromRGBO(255, 255, 255, 1);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        SizedBox(height: 20.0),
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
              height: 5.0,
            ),
          ),
          Container(
            width: size.width * 0.85,
            margin: EdgeInsets.symmetric(vertical: 30.0),
            padding: EdgeInsets.symmetric(vertical: 90.0),
            decoration: BoxDecoration(
              color: Colors.white10,
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              children: <Widget>[
                Text('Iniciar sesión',
                    style: TextStyle(
                        fontSize: 22.0,
                        fontFamily: 'Century',
                        color: Color.fromRGBO(0, 0, 0, 75))),
                SizedBox(height: 30.0),
                _crearEmail(bloc),
                SizedBox(height: 30.0),
                _crearPassword(bloc),
                SizedBox(height: 20.0),
                GestureDetector(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      'Olvidaste tu contrasena?',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => ForgetScreen()));
                  },
                ),
                SizedBox(height: 25.0),
                _crearBoton(bloc),
                SizedBox(height: 230.0),
                FlatButton(
                  child: Text('No tienes una cuenta? Registrate',
                      style: TextStyle(color: Colors.black54)),
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, 'registro'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearEmail(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.emailStream,
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
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changeEmail,
          ),
        );
      },
    );
  }

  Widget _crearPassword(LoginBloc bloc) {
    return StreamBuilder(
      stream: bloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          child: TextField(
            obscureText: true,
            decoration: InputDecoration(
                icon: Icon(Icons.lock_outlined, color: Colors.lightBlueAccent),
                labelText: 'Contraseña',
                //counterText: snapshot.data,
                errorText: snapshot.error),
            onChanged: bloc.changePassword,
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
            padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
            child: Text('Ingresar'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 0.0,
          color: Color.fromRGBO(4, 102, 200, 1),
          textColor: Colors.white,
          onPressed: () => _login(bloc, context),
        );
      },
    );
  }

  _login(LoginBloc bloc, BuildContext context) async {
    Map info = await usuarioProvider.login(
        bloc.email, bloc.password, bloc.usuario, bloc.fecha);
    if (info['ok']) {
      Navigator.pushReplacementNamed(context, 'tab');
    } else {
      mostrarAlerta(context, info['mensaje']);
    }
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
              Text('Bienvenido a Bustrab',
                  style: TextStyle(
                      color: Colors.black87,
                      fontSize: 30.0,
                      fontFamily: 'Raleway')),

              SizedBox(height: 15.0, width: double.infinity),

              // Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
            ],
          ),
        )
      ],
    );
  }
}
