import 'dart:convert';
import 'dart:io';
import 'package:bustrab/src/models/usuario_model.dart';
import 'package:bustrab/src/preferencias_usuario/preferencias_usuario.dart';
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

//import 'dart:html';

import 'package:http/http.dart' as http;

class UsProvider {
  final String _url = 'https://bustrab-8e267-default-rtdb.firebaseio.com';
  final _prefs = new PreferenciasUsuario();

  Future<bool> crearUsuario(UsuarioModel usuario) async {
    final url = '$_url/usuario.json?auth=${_prefs.token}';

    final resp = await http.post(url, body: usuarioModelToJson(usuario));
    final decodedData = json.decode(resp.body);
    print(decodedData);

    return true;
  }

  Future<bool> editarUsuario(UsuarioModel usuario) async {
    final url = '$_url/usuario/${usuario.id}.json?auth=${_prefs.token}';

    final resp = await http.put(url, body: usuarioModelToJson(usuario));
    final decodedData = json.decode(resp.body);
    print(decodedData);

    return true;
  }

  Future<List<UsuarioModel>> cargarUsuario() async {
    final url = '$_url/usuario.json?auth=${_prefs.token}';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<UsuarioModel> usuario = new List();
    //print(decodedData);
    if (decodedData == null) return [];
    if (decodedData['error'] != null) return [];

    decodedData.forEach((id, prod) {
      final prodTemp = UsuarioModel.fromJson(prod);
      prodTemp.id = id;
      usuario.add(prodTemp);
    });
    //print(productos[0].id);

    return usuario;
  }

  Future<int> borrarUsuario(String id) async {
    final url = '$_url/usuario/$id.json?auth=${_prefs.token}';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<String> subirImagen(File imagen) async {
    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dvbqs10mo/image/upload?upload_preset=uftouccg');
    final mimeType = mime(imagen.path).split('/'); //Imagen/jpeg

    final imageUploadRequest = http.MultipartRequest('POST', url);
    final file = await http.MultipartFile.fromPath('file', imagen.path,
        contentType: MediaType(mimeType[0], mimeType[1]));
    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();
    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal');
      print(resp.body);
      return null;
    }
    final respData = json.decode(resp.body);
    print(respData);
    return respData['secure_url'];
  }
}
