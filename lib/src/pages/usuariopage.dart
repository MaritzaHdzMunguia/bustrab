import 'dart:io';

import 'package:bustrab/src/blocs/usuario_bloc.dart';
import 'package:bustrab/src/models/usuario_model.dart';
import 'package:flutter/material.dart';
//import 'package:formvalidacion/src/providers/productos_provider.dart';

import 'package:bustrab/src/utils/utils.dart' as utils;
import 'package:image_picker/image_picker.dart';

class UsuarioPage extends StatefulWidget {
  @override
  _UsuarioPageState createState() => _UsuarioPageState();
}

class _UsuarioPageState extends State<UsuarioPage> {
  final formKey = GlobalKey<FormState>();
  final scaffolKey = GlobalKey<ScaffoldState>();

  UsuarioBloc usuarioBloc;

  //final productoProvider = new ProductosProvider();

  UsuarioModel usuario = new UsuarioModel();
  bool _guardando = false;
  File foto;
  File _image;

  @override
  Widget build(BuildContext context) {
    /* usuarioBloc = Provider.usuarioBloc(context);

    final UsuarioModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      usuario = prodData;
    }
    return Scaffold(
      key: scaffolKey,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(4, 102, 200, 1),
        title: Text('Usuario'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          ),
          IconButton(
            icon: Icon(Icons.camera_alt),
            onPressed: _tomarFoto,
          )
        ],
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
                //   _crearDisponible(),
                _crearBoton(),
              ],
            ),
          ),
        ),
      ),
    );
    */

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 32,
          ),
          Center(
            child: GestureDetector(
              onTap: () {
                _showPicker(context);
              },
              child: CircleAvatar(
                radius: 70,
                backgroundColor: Colors.white12,
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.file(
                          _image,
                          width: 200,
                          height: 200,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(100)),
                        width: 200,
                        height: 200,
                        child: Icon(
                          Icons.camera_alt,
                          color: Colors.grey[800],
                        ),
                      ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _crearNombre() {
    return TextFormField(
      initialValue: usuario.nombre,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(labelText: 'Usuario'),
      onSaved: (value) => usuario.nombre = value,
      validator: (value) {
        if (value.length < 3) {
          return 'Ingrese su nombre';
        } else {
          return null;
        }
      },
    );
  }

  Widget _crearPrecio() {
    return TextFormField(
      initialValue: usuario.fecha.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: 'fecha de nacimiento'),
      onSaved: (value) => usuario.fecha = value,
      validator: (value) {
        if (utils.isNumeric(value)) {
          return null;
        } else {
          return 'Solo numeros';
        }
      },
    );
  }
/*
  Widget _crearDisponible() {
    return SwitchListTile(
      value: usuario.disponible,
      title: Text('Disponible'),
      onChanged: (value) => setState(() {
        usuario.disponible = value;
      }),
    );
  }
  */

  Widget _crearBoton() {
    return RaisedButton.icon(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: Color.fromRGBO(4, 102, 200, 1),
      textColor: Colors.white,
      label: Text('Guardar'),
      icon: Icon(Icons.save, color: Colors.white),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async {
    if (!formKey.currentState.validate()) return;
    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if (foto != null) {
      usuario.fotoUrl = await usuarioBloc.subirFoto(foto);
    }

    if (usuario.id == null) {
      usuarioBloc.agregarUsuario(usuario);
    } else {
      usuarioBloc.editarUsuario(usuario);
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
    if (usuario.fotoUrl != null) {
      return FadeInImage(
        image: NetworkImage(usuario.fotoUrl),
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

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
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
      usuario.fotoUrl = null;
    }
    setState(() {});
  }
}
