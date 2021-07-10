import 'package:bustrab/src/blocs/productos_bloc.dart';
import 'package:bustrab/src/blocs/provider.dart';
import 'package:bustrab/src/models/producto_model.dart';
import 'package:flutter/material.dart';

//import 'package:formvalidacion/src/providers/productos_provider.dart';

class HomePage3 extends StatefulWidget {
  @override
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  //final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();
    return Scaffold(
      body: _loginForm(context),
      //floatingActionButton: _crearBoton(context),
      // bottomNavigationBar: _buttomNavigationBar(context),
    );
  }

  Widget _loginForm(BuildContext context) {
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();
    return Container(
      margin: EdgeInsets.only(left: 25.0, right: 5.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80.0),
            Text("Bustrab",
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 30.0,
                    fontFamily: 'Raleway')),
            SizedBox(height: 25.0),
            Container(
              width: double.infinity,
              height: 50.0,
              margin: EdgeInsets.only(right: 18.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(248, 248, 248, 1),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 4,
                            offset: Offset(0, 4), // changes position of shadow
                          ),
                        ],
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: TextField(
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          icon: Icon(
                            Icons.search,
                            size: 25.0,
                            color: Colors.black,
                          ),
                          border: InputBorder.none,
                          hintText: "Encuentra lo que necesitas",
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 35.0),
            Text("Que estas buscando?",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.0,
                  fontFamily: 'Raleway3',
                )),
            SizedBox(height: 15.0),
            _crearListado2(productosBloc),
            _loginForm2(context),
          ],
        ),
      ),
    );
  }

  Widget _loginForm2(BuildContext context) {
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();
    return Container(
      margin: EdgeInsets.only(left: 5.0, right: 5.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20.0),
            Text("Sugerencias para ti",
                style: TextStyle(
                  color: Colors.black87,
                  fontSize: 15.0,
                  fontFamily: 'Raleway3',
                )),
            SizedBox(height: 15.0),
            _crearListado(productosBloc),
            // SizedBox(height: 15.0),
          ],
        ),
      ),
    );
  }

  Widget _crearListado(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final producto = snapshot.data;
          return Container(
            height: 240,
            width: 350,
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: producto.length,
              itemBuilder: (context, i) =>
                  _crearItem2(context, productosBloc, producto[i]),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem2(BuildContext context, ProductosBloc productosBloc,
      ProductoModel producto) {
    //return Dismissible(
    // key: UniqueKey(),
    //background: Container(
    // color: Colors.red,
    //),
    // onDismissed: (direccion) => productosBloc.borrarProducto(producto.id),
    //productosProvider.borrarProducto(producto.id);
    return Card(
      color: Color.fromRGBO(248, 248, 248, 1),
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.symmetric(),
            title: Text('  ${producto.titulo}'),
            subtitle: Text('  ${producto.valor}'),
            // subtitle: Text(producto.id),
            onTap: () =>
                Navigator.pushNamed(context, 'descripcion', arguments: producto)
                    .then((value) => setState(() {})),
          ),
        ],
      ),
    );
  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc,
      ProductoModel producto) {
    //return Dismissible(
    // key: UniqueKey(),
    //background: Container(
    // color: Colors.red,
    //),
    // onDismissed: (direccion) => productosBloc.borrarProducto(producto.id),
    //productosProvider.borrarProducto(producto.id);
    return Card(
      color: Color.fromRGBO(248, 248, 248, 1),
      //shadowColor: Colors.black,
      elevation: 3.0,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: <Widget>[
          Hero(
            tag: producto.id,
            child: ClipRRect(
              child: (producto.fotoUrl == null)
                  ? Image(image: AssetImage('assets/img/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(producto.fotoUrl),
                      placeholder: AssetImage('assets/img/jar-loading.gif'),
                      height: 120,
                      width: double.infinity,
                      fit: BoxFit.contain,
                    ),
            ),
          ),
          ListTile(
            title: Text('${producto.titulo} - ${producto.valor}'),
            //subtitle: Text(producto.id),
            onTap: () =>
                Navigator.pushNamed(context, 'descripcion', arguments: producto)
                    .then((value) => setState(() {})),
          ),
        ],
      ),
    );
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color.fromRGBO(4, 102, 200, 1),
      onPressed: () => Navigator.pushNamed(context, 'producto')
          .then((value) => setState(() {})),
    );
  }

  _crearListado2(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final producto = snapshot.data;
          return Container(
            height: 200,
            width: 350,
            child: PageView.builder(
              controller: PageController(viewportFraction: 0.5),
              scrollDirection: Axis.horizontal,
              itemCount: producto.length,
              itemBuilder: (context, i) =>
                  _crearItem(context, productosBloc, producto[i]),
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  /*Widget _buttomNavigationBar(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Color.fromRGBO(4, 102, 200, 1.0),
          primaryColor: Colors.white,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: TextStyle(color: Colors.white60))),
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home, size: 30.0), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.add, size: 40.0), title: Container()),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle, size: 30.0), title: Container()),
        ],
      ),
    );
  }*/
}
