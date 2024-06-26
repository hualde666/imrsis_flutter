import 'package:flutter/material.dart';
import 'package:imresanca/modelos/item_carrito.dart';
import 'package:imresanca/modelos/productos.dart';
//import 'package:imresanca/modelos/productos.dart';

class CarritoProvider with ChangeNotifier {
  static final CarritoProvider _carritoprovider = CarritoProvider._internal();
  factory CarritoProvider() {
    return _carritoprovider;
  }
  static List<ItemCarrito> _carrito = [];
  static double _subtotal = 0;

  CarritoProvider._internal() {
    _carrito = [];
  }
  List<ItemCarrito> get contenidoCarrito {
    return _carrito;
  }

  int get itemsCarrito {
    return _carrito.length;
  }

  double get subtotal {
    return _subtotal;
  }

  agregarAlCarrito(Productos producto) {
    // si producto duplicado entonce incrementar cantidad
    // OJO verificar exitencias

    int i = _carrito.indexWhere((item) => item.codigo == producto.codigo);
    if (i >= 0) {
      if (producto.disponible > _carrito[i].cantidad) {
        _carrito[i].cantidad = _carrito[i].cantidad + 1;
        _subtotal = _subtotal + producto.precio;
        notifyListeners();
      }
    } else {
      final ItemCarrito item =
          ItemCarrito(producto.codigo, producto.descripcion, producto.precio);
      _carrito.add(item);
      _carrito.sort((a, b) => a.descripcion.compareTo(b.descripcion));
      _subtotal = _subtotal + producto.precio;
      notifyListeners();
    }
  }

  eliminarDelCarrito(int i) {
    // si producto duplicado entonce incrementar cantidad
    _subtotal = _subtotal - _carrito[i].precio * _carrito[i].cantidad;
    _carrito.remove(_carrito[i]);
    notifyListeners();
  }

  incrementarCantidad(int i) {
    //  incrementar cantidad
    // OJO verificar disponibilidad
    _subtotal = _subtotal + _carrito[i].precio;
    _carrito[i].cantidad = _carrito[i].cantidad + 1;

    notifyListeners();
  }

  decrementarCantidad(int i) {
    // decrementar cantidad
    if (_carrito[i].cantidad > 1) {
      _subtotal = _subtotal - _carrito[i].precio;
      _carrito[i].cantidad = _carrito[i].cantidad - 1;
      notifyListeners();
    }
  }
}
