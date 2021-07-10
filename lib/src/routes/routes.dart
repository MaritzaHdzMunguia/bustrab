import 'package:bustrab/src/blocs/provider.dart';
import 'package:bustrab/src/pages/ForgetScreen.dart';
import 'package:bustrab/src/pages/descripcion.dart';
import 'package:bustrab/src/pages/home3.dart';
import 'package:bustrab/src/pages/home_page.dart';
import 'package:bustrab/src/pages/inicio%20copy.dart';
import 'package:bustrab/src/pages/login3.dart';
import 'package:bustrab/src/pages/login_pages%20copy.dart';
import 'package:bustrab/src/pages/login_pages.dart';
import 'package:bustrab/src/pages/perfil_page%20copy.dart';
import 'package:bustrab/src/pages/producto.dart';
import 'package:bustrab/src/pages/registro_page.dart';
import 'package:bustrab/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:bustrab/src/tabs/tab2.dart';
import 'package:bustrab/src/tabs/tabs_page.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  'login': (BuildContext context) => LoginPage(),
  'home': (BuildContext context) => HomePage(),
  'producto': (BuildContext context) => ProductoPage(),
  'login2': (BuildContext context) => LoginPage2(),
  'registro': (BuildContext context) => RegistroPage(),
  'inicio': (BuildContext context) => InicioPage(),
  'home3': (BuildContext context) => HomePage3(),
  'tab': (BuildContext context) => TabsPages(),
};
