import 'dart:core';

import 'package:flutter/material.dart';

import 'package:imresanca/modelos/productos.dart';
import 'package:imresanca/providers/db_provider.dart';
import 'package:imresanca/ui/widgets/cargar_carrito.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ListaCatalogo extends StatefulWidget {
  const ListaCatalogo({super.key});
  @override
  State<ListaCatalogo> createState() => ListaCatalogoState();
}

class ListaCatalogoState extends State<ListaCatalogo> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dbProvider = Provider.of<DbProvider>(context);
    Future<List<Productos>> filtrarDescripcion() async {
      List<Productos> lista = [];
      if (searchController.text.isEmpty) {
        lista = await dbProvider.getProductosDescripcion('');
      } else {
        lista = await dbProvider.getProductosDescripcion(searchController.text);
      }
      return lista;
    }

    return FutureBuilder(
        future: filtrarDescripcion(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.amber,
              ),
            );
          } else {
            if (snapshot.hasData) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                //  crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 300,
                          margin: const EdgeInsets.only(left: 100),
                          //color: Colors.black38,
                          child: const Text('Catálogo',
                              style: TextStyle(
                                fontSize: 40,
                              ))),
                      const Spacer(),
                      GestureDetector(
                          onTap: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                          },
                          child: Container(
                            height: 80,
                            width: 800,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 7),
                            child: TextField(
                              // enabled: abilitarBusqueda,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 25.0,
                                  color: Colors.white,
                                  height: 1.0),
                              keyboardType: TextInputType.name,
                              // inputFormatters: [
                              //   FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                              // ],
                              controller: searchController,
                              // autofocus: true,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(25.0))),
                                labelStyle: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 20),
                                labelText: 'Descripción :',
                                suffixIcon:
                                    // searchController.text.isNotEmpty
                                    //     ? IconButton(
                                    //         onPressed: () {
                                    //           setState(() {
                                    //             searchController.clear();
                                    //           });
                                    //         },
                                    //         icon: const Icon(
                                    //           Icons.clear,
                                    //           color: Colors.white,
                                    //           size: 30,
                                    //         ))
                                    //     :
                                    IconButton(
                                        onPressed: () {
                                          filtrarDescripcion();
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.search_rounded,
                                          color: Colors.white,
                                          size: 30,
                                        )),
                                focusedBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(25.0))),
                              ),
                            ),
                          )),
                      const SizedBox(
                        width: 100,
                      ),
                      // Text('tengo lista')
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  //encabezadoCatalogo(),
                  Expanded(
                    child: Container(
                      //height: 600,
                      margin: const EdgeInsets.only(
                          top: 10, left: 50, right: 50, bottom: 10),
                      child: listado(snapshot.data),
                    ),
                  )
                ],
              );
            } else {
              return const Center(
                child: Text('no se conecta'),
              );
            }
          }
        });
  }

  listado(List<Productos> catalogo) {
    return ListView.builder(
        itemCount: catalogo.length,
        //padding: const EdgeInsets.symmetric(vertical: 50),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,

        /// scroll bar dentro de la lista
        primary: true,

        /// permite scroll con las flechas
        itemBuilder: (context, i) {
          return FilaCatalogo(producto: catalogo[i], i: i);
        });
  }
}

class FilaCatalogo extends StatelessWidget {
  const FilaCatalogo({
    required this.producto,
    required this.i,
    super.key,
  });
  final Productos producto;
  final int i;

  @override
  Widget build(BuildContext context) {
    final double ancho = MediaQuery.of(context).size.width;
    final double tamanoFont = ancho > 850 ? 20.0 : 16;
    final f = NumberFormat("#,###.00", 'es');
    final desLargo = producto.descripcion.length;

    return Container(
      color: i.isEven ? Colors.black26 : Colors.black38,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {
                mostrarProcuto(context, producto);
              },
              child: Container(
                width: ancho > 850 ? 250 : 150,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                child: Text(
                  producto.codigo,
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: tamanoFont),
                ),
              ),
            ),
          ),
          Container(
            width: ancho > 850 ? 300 : 200,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Text(
              desLargo > 30
                  ? producto.descripcion.substring(0, 30)
                  : producto.descripcion,
              textAlign: TextAlign.left,
              style: TextStyle(fontSize: tamanoFont),
            ),
          ),
          // Container(
          //   //  color: i.isEven ? Colors.black45 : Colors.black87,
          //   width: ancho > 850 ? 100 : 50,
          //   padding: const EdgeInsets.symmetric(vertical: 10),

          //   child: Text(
          //     producto.,
          //     style: TextStyle(fontSize: tamanoFont),
          //   ),
          // ),
          Container(
            //          color: i.isEven ? Colors.black45 : Colors.black87,
            width: ancho > 850 ? 100 : 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              producto.disponible == 0 ? "0,00" : f.format(producto.disponible),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: tamanoFont),
            ),
          ),
          Container(
            //          color: i.isEven ? Colors.black45 : Colors.black87,
            width: ancho > 850 ? 100 : 60,
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              producto.precio == 0 ? "0,00" : f.format(producto.precio),
              textAlign: TextAlign.right,
              style: TextStyle(fontSize: tamanoFont),
            ),
          ),
          CargarCarrito(producto: producto),
        ],
      ),
    );
  }

  Future mostrarProcuto(BuildContext context, Productos producto) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return detalleProducto(context, producto);
        });
  }

  AlertDialog detalleProducto(BuildContext context, Productos producto) {
    // double height = (MediaQuery.of(context).size.height);
    final f = NumberFormat("#,###.00", 'es');

    return AlertDialog(
      backgroundColor: Colors.black,
      content: SingleChildScrollView(
        child: Form(
          child: SizedBox(
            height: 500,
            //height <= 500 ? 70 : 100,
            width: 500,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                    height: 50, //height <= 500 ? 25 : 30,
                    child: Text(
                      producto.codigo,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    )),
                SizedBox(
                    height: 50, //height <= 500 ? 25 : 30,
                    child: Text(
                      producto.descripcion,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Precio:',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    Text(
                      f.format(producto.precio),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                        height: 50, //height <= 500 ? 25 : 30,
                        child: Text(
                          'Existencia:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        )),
                    const SizedBox(
                      width: 50,
                    ),
                    SizedBox(
                        height: 50, //height <= 500 ? 25 : 30,
                        child: Text(
                          f.format(producto.disponible),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        )),
                  ],
                ),
                CargarCarrito(
                  producto: producto,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
