import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InicioPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Color.fromRGBO(255, 255, 255, 1);
    return Scaffold(
        body: Stack(
      children: <Widget>[
        _crearFondo(context),
        _loginForm(context),
      ],
    ));
  }

  Widget _loginForm(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          SafeArea(
            child: Container(
              height: 200.0,
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
                SizedBox(height: 40.0),
                _crearBoton(context),
                SizedBox(height: 15.0),
                _crearBoton2(context),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _crearBoton(BuildContext context) {
    //formValidStream

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 100.0, vertical: 15.0),
            child: Text('Iniciar Sesión'),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 8.0,
          color: Color.fromRGBO(4, 102, 200, 1),
          textColor: Colors.white,
          onPressed: () => Navigator.pushNamed(context, 'login3'),
        );
      },
    );
  }

  Widget _crearBoton2(BuildContext context) {
    //formValidStream

    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return RaisedButton(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 105.0, vertical: 15.0),
            child: Text('Registrarse', style: TextStyle(color: Colors.black87)),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
          elevation: 8.0,
          color: Color.fromRGBO(248, 248, 248, 1),
          textColor: Colors.black,
          onPressed: () => Navigator.pushNamed(context, 'registro'),
        );
      },
    );
  }

  Widget _crearFondo(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(top: 130.0),
          child: Column(
            children: <Widget>[
              Image.asset('assets/img/BustrabLogo.png',
                  width: 230, height: 230),
              SizedBox(height: 15.0, width: double.infinity),
              // Icon(Icons.person_pin_circle, color: Colors.white, size: 100.0),
            ],
          ),
        )
      ],
    );
  }
}
