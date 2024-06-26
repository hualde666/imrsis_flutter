class Productos {
  String codigo;
  String descripcion;
  int disponible;
  double precio;
  int id;

  Productos({
    required this.codigo,
    required this.descripcion,
    required this.disponible,
    required this.precio,
    required this.id,
  });

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CODIGO": codigo,
        "DESCRIPCION": descripcion,
        "DISPONIBLE": disponible,
        "PRECIO": precio,
      };

  factory Productos.fromJson(Map<String, dynamic> json) => Productos(
        id: json["ID"],
        codigo: json["CODIGO"],
        descripcion: json["DESCRIPCION"],
        disponible: json["DISPONIBLE"],
        precio: json["PRECIO"]?.toDouble(),
      );
}
