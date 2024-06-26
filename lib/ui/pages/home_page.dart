import 'package:flutter/material.dart';

import 'package:imresanca/providers/page_provider.dart';
import 'package:imresanca/ui/shared/menu.dart';
import 'package:imresanca/ui/views/carrito.dart';
import 'package:imresanca/ui/views/catalogo.dart';
import 'package:imresanca/ui/views/compras.dart';
import 'package:imresanca/ui/views/inventario.dart';
import 'package:imresanca/ui/views/ventas.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      // backgroundColor: Colors.white70,
      body: Stack(
        children: [
          _HomeBody(),
          Menu(),
        ],
      ),
    );
  }
}

class _HomeBody extends StatelessWidget {
  const _HomeBody();

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context);
    return PageView(
        controller: pageProvider.scrollController,
        // scrollDirection: Axis.vertical,
        allowImplicitScrolling: true,
        children: const [
          ListaCatalogo(),
          Inventario(),
          Compras(),
          Ventas(),
          Carrito()
        ]);
  }
}
