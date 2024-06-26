// To parse this JSON data, do
//
//     final responseProductos = responseProductosFromJson(jsonString);

import 'dart:convert';

import 'package:imresanca/modelos/productos.dart';

ResponseProductos responseProductosFromJson(String str) =>
    ResponseProductos.fromJson(json.decode(str));

String responseProductosToJson(ResponseProductos data) =>
    json.encode(data.toJson());

class ResponseProductos {
  List<List<Productos>> recordsets;
  List<Productos> recordset;
  Output output;
  List<int> rowsAffected;

  ResponseProductos({
    required this.recordsets,
    required this.recordset,
    required this.output,
    required this.rowsAffected,
  });

  factory ResponseProductos.fromJson(Map<String, dynamic> json) =>
      ResponseProductos(
        recordsets: List<List<Productos>>.from(json["recordsets"].map(
            (x) => List<Productos>.from(x.map((x) => Productos.fromJson(x))))),
        recordset: List<Productos>.from(
            json["recordset"].map((x) => Productos.fromJson(x))),
        output: Output.fromJson(json["output"]),
        rowsAffected: List<int>.from(json["rowsAffected"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "recordsets": List<dynamic>.from(recordsets
            .map((x) => List<dynamic>.from(x.map((x) => x.toJson())))),
        "recordset": List<dynamic>.from(recordset.map((x) => x.toJson())),
        "output": output.toJson(),
        "rowsAffected": List<dynamic>.from(rowsAffected.map((x) => x)),
      };
}

class Output {
  Output();

  factory Output.fromJson(Map<String, dynamic> json) => Output();

  Map<String, dynamic> toJson() => {};
}
