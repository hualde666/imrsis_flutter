import 'package:flutter/material.dart';

import 'package:imresanca/providers/carrito_provider.dart';
import 'package:imresanca/modelos/productos.dart';
import 'package:provider/provider.dart';

class CargarCarrito extends StatelessWidget {
  CargarCarrito({super.key, required this.producto});
  final Productos producto;

  @override
  Widget build(BuildContext context) {
    final bool habilitado = (producto.disponible > 0 && producto.precio > 0);
    final carritoProvider = Provider.of<CarritoProvider>(context);

    return IconButton(
        onPressed: habilitado
            ? (() {
                carritoProvider.agregarAlCarrito(producto);
              })
            : () {},
        icon: Icon(
          Icons.trolley,
          color: habilitado ? Colors.amber : Colors.grey,
          size: 30,
        ));
  }
}
