//import 'dart:io';

import 'package:bustrab/src/blocs/productos_bloc.dart';
import 'package:bustrab/src/blocs/provider.dart';
import 'package:bustrab/src/models/producto_model.dart';
import 'package:flutter/material.dart';
//import 'package:formvalidacion/src/providers/productos_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //final productosProvider = new ProductosProvider();

  @override
  Widget build(BuildContext context) {
    final productosBloc = Provider.productosBloc(context);
    productosBloc.cargarProductos();

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromRGBO(4, 102, 200, 1),
      ),
      body: _crearListado(productosBloc),
      floatingActionButton: _crearBoton(context),
    );
  }

  Widget _crearListado(ProductosBloc productosBloc) {
    return StreamBuilder(
      stream: productosBloc.productosStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProductoModel>> snapshot) {
        if (snapshot.hasData) {
          final producto = snapshot.data;
          return ListView.builder(
            itemCount: producto.length,
            itemBuilder: (context, i) =>
                _crearItem(context, productosBloc, producto[i]),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, ProductosBloc productosBloc,
      ProductoModel producto) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
          color: Colors.red,
        ),
        onDismissed: (direccion) => productosBloc.borrarProducto(producto.id),
        //productosProvider.borrarProducto(producto.id);
        child: Card(
          child: Column(
            children: <Widget>[
              (producto.fotoUrl == null)
                  ? Image(image: AssetImage('assets/img/no-image.png'))
                  : FadeInImage(
                      image: NetworkImage(producto.fotoUrl),
                      placeholder: AssetImage('assets/img/jar-loading.gif'),
                      height: 100.0,
                      width: 100.0,
                      fit: BoxFit.contain,
                    ),
              ListTile(
                title: Text('${producto.titulo} - ${producto.valor}'),
                subtitle: Text(producto.id),
                onTap: () => Navigator.pushNamed(context, 'producto',
                        arguments: producto)
                    .then((value) => setState(() {})),
              ),
            ],
          ),
        ));
  }

  _crearBoton(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: Color.fromRGBO(4, 102, 200, 1),
      onPressed: () => Navigator.pushNamed(context, 'producto')
          .then((value) => setState(() {})),
    );
  }
}
