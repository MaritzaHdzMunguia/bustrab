import 'dart:io';

import 'package:bustrab/src/blocs/productos_bloc.dart';
import 'package:bustrab/src/blocs/provider.dart';
import 'package:bustrab/src/models/producto_model.dart';
import 'package:flutter/material.dart';
//import 'package:formvalidacion/src/providers/productos_provider.dart';

import 'package:bustrab/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class Descripcion extends StatefulWidget {
  @override
  _DescripcionState createState() => _DescripcionState();
}

class _DescripcionState extends State<Descripcion> {
  final formKey = GlobalKey<FormState>();
  final scaffolKey = GlobalKey<ScaffoldState>();

  ProductosBloc productosBloc;

  //final productoProvider = new ProductosProvider();

  ProductoModel producto = new ProductoModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {
    productosBloc = Provider.productosBloc(context);

    final ProductoModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      producto = prodData;
    }
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(4, 102, 200, 1),
        title: Text(
          'Descripción de servicio',
          textAlign: TextAlign.center,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                _mostrarFoto(),
                _crearNombre(),
                _crearPrecio(),
                _crearDisponible(),
                SizedBox(height: 20),
                //  _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: producto.titulo,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Tipo de empleo o servicio'),
      onSaved: (value) => producto.titulo = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese el nombre del empleo';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: producto.valor.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'Precio'),
      onSaved: (value) => producto.valor = double.parse(value),
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }

  Widget _crearDisponible() {
    return SwitchListTile(
      value: producto.disponible,
      title: Text('Disponible'),
      onChanged: (value) => setState(() {
        producto.disponible = value;
      }),
    );
  }

  /*
  Widget _crearBoton() {
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 80.0, vertical: 15.0),
        child: Text('Guardar cambios', style: TextStyle(fontSize: 15.0)),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      elevation: 8.0,
      color: Color.fromRGBO(4, 102, 200, 1),
      textColor: Colors.white,
      onPressed: (_guardando) ? null : _submit,
    );
  }
*/
  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      producto.fotoUrl = await productosBloc.subirFoto(foto);
    }

    if (producto.id == null) {
      productosBloc.agregarProducto(producto);
    } else {
      productosBloc.editarProducto(producto);
    }
    //setState(() {_guardando = false;});

    mostrarSnackbar('Registro guardado');
    // if (formKey.currentState.validate()) {
    //cuando el fomulario es valido'
    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(microseconds: 1500),
    );
    scaffolKey.currentState.showSnackBar(snackbar);
  }

  _mostrarFoto() {
    if (producto.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(producto.fotoUrl),
        placeholder: AssetImage('assets/img/jar-loading.gif'),
        height: 300.0,
        fit: BoxFit.contain,
      );
    } else {
      if (foto != null) {
        return Image.file(
          foto,
          fit: BoxFit.cover,
          height: 300.0,
        );
      }
      return Image.asset('assets/img/no-image.png');
    }
  }

  _seleccionarFoto() async {
    _procesarImagen(ImageSource.gallery);
  }

  _tomarFoto() async {
    _procesarImagen(ImageSource.camera);
  }

  _procesarImagen(ImageSource origen) async {
    foto = await ImagePicker.pickImage(source: origen);

    if (foto != null) {
      producto.fotoUrl = null;
    }
    setState(() {});
  }
}
