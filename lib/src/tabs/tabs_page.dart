import 'package:bustrab/src/pages/home3.dart';
import 'package:bustrab/src/pages/producto.dart';
import 'package:bustrab/src/pages/settings.dart';
import 'package:flutter/material.dart';

class TabsPages extends StatefulWidget {
  TabsPages({Key key}) : super(key: key);

  @override
  _TabsPagesState createState() => _TabsPagesState();
}

class _TabsPagesState extends State<TabsPages> {
  List<Widget> _widgetOptions = [
    HomePage3(),
    ProductoPage(),
    SettingsPage(),
  ];
  int _selectedItemIndex = 0;

  void _cambiarWidget(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedItemIndex),
      bottomNavigationBar: _bottomNavigationBar(context),
    );
  }

  Widget _bottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedItemIndex,
        onTap: _cambiarWidget,
        showSelectedLabels: true,
        backgroundColor: Color.fromRGBO(4, 102, 200, 1.0),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30.0), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, size: 40.0), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 30.0), title: Container()),
        ]);
  }
}
