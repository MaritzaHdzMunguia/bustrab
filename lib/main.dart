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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new PreferenciasUsuario();
  await prefs.initPrefs();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //WidgetsFlutterBinding.ensureInitialized();
    final prefs = new PreferenciasUsuario();
    print(prefs.token);

    return Provider(
        child: MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: 'inicio',
      routes: {
        'login': (BuildContext context) => LoginPage(),
        'descripcion': (BuildContext context) => Descripcion(),
        'home': (BuildContext context) => HomePage(),
        'producto': (BuildContext context) => ProductoPage(),
        'login2': (BuildContext context) => LoginPage2(),
        'registro': (BuildContext context) => RegistroPage(),
        'inicio': (BuildContext context) => InicioPage(),
        'home3': (BuildContext context) => HomePage3(),
        'tab': (BuildContext context) => TabsPages(),
        'tab2': (BuildContext context) => TabsPages2(),
        'login3': (BuildContext context) => LoginPage3(),
        'perfil': (BuildContext context) => Perfil(),
        'password': (BuildContext context) => ForgetScreen(),
      },
    ));
  }
}
