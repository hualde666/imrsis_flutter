import 'package:flutter/material.dart';

import 'package:imresanca/providers/carrito_provider.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Carrito extends StatelessWidget {
  const Carrito({super.key});

  @override
  Widget build(BuildContext context) {
    final carritoProvider = Provider.of<CarritoProvider>(context);

    List<Widget> listaFactura = List.generate(
        carritoProvider.contenidoCarrito.length,
        (i) => itemFactura(context, i));

    List<Widget> pantalla = [];
    pantalla.add(
      EncabezadoCarrito(carritoProvider: carritoProvider),
    );
    pantalla.addAll(listaFactura);

    return Container(
      // color: Colors.black,
      margin: const EdgeInsets.only(
        top: 80,
        left: 100,
        right: 100,
      ),
      child: Expanded(
        child: ListView.builder(
            itemCount: pantalla.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,

            /// scroll bar dentro de la lista
            primary: true,

            /// permite scroll con las flechas
            itemBuilder: (context, i) {
              return pantalla[i];
            }),
      ),
    );
  }
}

class EncabezadoCarrito extends StatelessWidget {
  const EncabezadoCarrito({
    super.key,
    required this.carritoProvider,
  });

  final CarritoProvider carritoProvider;

  @override
  Widget build(BuildContext context) {
    final f = NumberFormat("#,###.00", 'es');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      height: 100,
      width: 700,
      color: Colors.black38,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Carrito',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          const Spacer(),
          const Text(
            'Sub-Total: ',
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Text(
            f.format(carritoProvider.subtotal),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 30),
          ),
        ],
      ),
    );
  }
}

Widget itemFactura(BuildContext context, int i) {
  final f = NumberFormat("#,###.00", 'es');
  // final double monto = producto.precio * producto.cantidad;
  final carritoProvider = Provider.of<CarritoProvider>(context);
  return Container(
    height: 84,
    width: 700,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    color: i.isEven ? Colors.black26 : Colors.black38,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.symmetric(vertical: 2),
          color: Colors.black45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  onPressed: (() {
                    carritoProvider.incrementarCantidad(i);
                  }),
                  splashColor: Colors.white54,
                  icon: const Icon(
                    Icons.publish_sharp,
                    color: Colors.amber,
                    size: 20,
                    weight: 30,
                  )),
              IconButton(
                  onPressed: (() {
                    carritoProvider.decrementarCantidad(i);
                  }),
                  icon: const Icon(
                    Icons.download_rounded,
                    color: Colors.amber,
                    size: 20,
                  )),
            ],
          ),
        ),
        Container(
          width: 60,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            f.format(carritoProvider.contenidoCarrito[i].cantidad),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Container(
          width: 200,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            carritoProvider.contenidoCarrito[i].codigo,
            textAlign: TextAlign.start,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Container(
          width: 300,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          child: Text(
            carritoProvider.contenidoCarrito[i].descripcion,
            textAlign: TextAlign.left,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        // Container(
        //   width: 50,
        //   padding: const EdgeInsets.symmetric(vertical: 10),
        //   child: Text(
        //     carritoProvider.contenidoCarrito[i].unidad,
        //     style: const TextStyle(fontSize: 20),
        //   ),
        // ),
        Container(
          //          color: i.isEven ? Colors.black45 : Colors.black87,
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            f.format(carritoProvider.contenidoCarrito[i].precio),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        Container(
          //          color: i.isEven ? Colors.black45 : Colors.black87,
          width: 100,
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Text(
            f.format(carritoProvider.contenidoCarrito[i].cantidad *
                carritoProvider.contenidoCarrito[i].precio),
            textAlign: TextAlign.right,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        IconButton(
            onPressed: (() {
              carritoProvider.eliminarDelCarrito(i);
            }),
            icon: const Icon(
              Icons.delete_forever,
              color: Colors.amber,
              size: 30,
            ))
      ],
    ),
  );
}
