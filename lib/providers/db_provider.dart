import "dart:async";

import 'package:http/http.dart' as http;

//import 'package:imresanca/global/enviroment.dart';
import 'package:imresanca/modelos/productos.dart';
import 'package:imresanca/providers/productos_response.dart';

class DbProvider {
  // static final DbProvider db = DbProvider();
  DbProvider();

  // static final List<Productos> _catalogo = [
  //   Productos('010323', 'CONCHAS 23', 'UND', 5, 100),
  //   Productos('01234567890123456789',
  //       'CONCHAS 240123456789012345678901234567890123456789', 'UND', 10, 25.00),
  //   Productos('MAG01', 'MANGUERA', 'MTS', 11105.55, 30.5),
  //   Productos('010323', 'CONCHAS 23', 'UND', 5, 50),
  //   Productos('0103224', 'CONCHAS 24', 'UND', 10, 23),
  //   Productos('MAG01', 'MANGUERA', 'MTS', 105, 60),
  //   Productos('010323', 'CONCHAS 23', 'UND', 5, 70),
  //   Productos('0103224', 'CONCHAS 24', 'UND', 10, 80),
  //   Productos('MAG01', 'MANGUERA', 'MTS', 105, 12),
  //   Productos('010323', 'CONCHAS 23', 'UND', 5, 7),
  //   Productos('0103224', 'CONCHAS 24', 'UND', 10, 25.6),
  //   Productos('MAG01', 'MANGUERA', 'MTS', 105, 66),
  //   Productos('010323', 'CONCHAS 23', 'UND', 5, 11),
  //   Productos('0103224', 'CONCHAS 24', 'UND', 10, 40),
  //   Productos('MAG01', 'MANGUERA', 'MTS', 105, 70),
  //   Productos('010323', 'CONCHAS 23', 'UND', 5, 42),
  //   Productos('0103224', 'CONCHAS 24', 'UND', 10, 38),
  //   Productos('MAG01', 'MANGUERA', 'MTS', 105, 90),
  //   Productos('010323', 'CONCHAS 23', 'UND', 5, 74),
  //   Productos('0103224', 'CONCHAS 24', 'UND', 10, 59),
  //   Productos('MAG01', 'MANGUERA', 'MTS', 105, 2),
  //   Productos('010323', 'CONCHAS 23', 'UND', 5, 5),
  //   Productos('0103224', 'CONCHAS 24', 'UND', 10, 8),
  //   Productos('MAG01', 'MANGUERA', 'MTS', 105, 16),
  //   Productos('010323', 'CONCHAS 23', 'UND', 5, 7),
  //   Productos('0103224', 'CONCHAS 24', 'UND', 10, 37),
  //   Productos('MAG01', 'MANGUERA', 'MTS', 105, 88),
  // ];

  // get catalogo {
  //   return _catalogo;
  // }

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
}
