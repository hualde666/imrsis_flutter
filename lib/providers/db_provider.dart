import "dart:async";
//import 'dart:convert';
import 'package:http/http.dart' as http;

//import 'package:imresanca/global/enviroment.dart';
import 'package:imresanca/modelos/productos.dart';
import 'package:imresanca/providers/productos_response.dart';

class DbProvider {
  // static final DbProvider db = DbProvider();
  DbProvider();

  Future<List<Productos>> getProductos() async {
    List<Productos> lista = [];
    try {
      final Uri uri = Uri.parse('http://localhost:3000/productos');
      final resp = await http.get(uri, headers: {
        'conten-Type': 'application/json',
        //'x-token': await AuthService.getToken()
      });
      //  final usuariosResponse = responseUsuariosFromJson(resp.body);
      final prodRespuestas = responseProductosFromJson(
          resp.body); //responseProductosFromJson(resp.body);

      return prodRespuestas.recordset;
    } catch (e) {
      return lista;
    }
  }

  Future<List<Productos>> getProductosDescripcion(String busqueda) async {
    final String texto = busqueda.trimLeft();
    final data = busqueda == '' ? "'%'" : "'$texto%'";
    try {
      final Uri uri = Uri.parse('http://localhost:3000/des');
      final resp = await http.get(
        uri,
        headers: {
          'conten-Type': 'application/json',
          'descripcion': data
          //'x-token': await AuthService.getToken()
        },
      );
      //  final usuariosResponse = responseUsuariosFromJson(resp.body);
      final prodRespuestas = responseProductosFromJson(
          resp.body); //responseProductosFromJson(resp.body);

      return prodRespuestas.recordset;
    } catch (e) {
      return [];
    }
  }
}
