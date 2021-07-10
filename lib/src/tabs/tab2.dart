import 'package:flutter/material.dart';

import 'package:formvalidacion/src/pages/home3.dart';
import 'package:formvalidacion/src/pages/producto.dart';
import 'package:formvalidacion/src/pages/settings.dart';

class TabsPages2 extends StatefulWidget {
  TabsPages2({Key key}) : super(key: key);

  @override
  _TabsPages2State createState() => _TabsPages2State();
}

class _TabsPages2State extends State<TabsPages2> {
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
      bottomNavigationBar: build2(context),
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

  _buildView() {
    final List<Widget> _children = [
      HomePage3(),
      ProductoPage(),
      SettingsPage(),
    ];

    return Scaffold(
      body: _children[_selectedItemIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _cambiarWidget(1);
        },
        tooltip: "Add Savings",
        child: Icon(Icons.attach_money, color: Colors.indigo),
        elevation: 4.0,
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _selectedItemIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.home),
              title: new Text("Home"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.attach_money),
              title: new Text("Save"),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text("Profile"),
            ),
          ]),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _selectedItemIndex = index;
    });
  }

  Widget build2(BuildContext context) {
    final List<Widget> _children = [
      HomePage3(),
      ProductoPage(),
      SettingsPage(),
    ];

    return new Scaffold(
      body: _children[_selectedItemIndex],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: new Visibility(
        visible: true,
        child: new FloatingActionButton(
          backgroundColor: Color.fromRGBO(4, 102, 200, 1.0),
          onPressed: () {
            _cambiarWidget(1);
          },
          tooltip: 'Increment',
          child: new Icon(Icons.add),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromRGBO(4, 102, 200, 1.0),
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home),
              color: Colors.white,
              onPressed: () {
                _cambiarWidget(0);
              },
            ),
            IconButton(
              icon: Icon(Icons.account_circle),
              color: Colors.white,
              onPressed: () {
                _cambiarWidget(2);
              },
            ),
          ],
        ),
      ),
    );
  }
}
