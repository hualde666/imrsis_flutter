import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:imresanca/providers/carrito_provider.dart';

import 'package:provider/provider.dart';
import 'package:imresanca/providers/page_provider.dart';

class Menu extends StatelessWidget {
  const Menu({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ancho = MediaQuery.of(context).size.width;
    final pageProvider = Provider.of<PageProvider>(context, listen: false);
    final carritoProvider = Provider.of<CarritoProvider>(context);

    return Positioned(
      //right: 20,
      //top: 20,
      child: ancho > 900
          ? MouseRegion(
              cursor: SystemMouseCursors.click,
              child: FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  // width: 550,
                  //  margin: const EdgeInsets.only(right: 25),
                  height: 50,
                  width: ancho,
                  color: Colors.amberAccent,
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                    const SizedBox(
                      width: 50,
                    ),
                    const Text(
                      'IMRESANCA',
                      style: TextStyle(fontSize: 40, color: Colors.black),
                    ),
                    Expanded(child: Container()),
                    _ItemsMenu(
                        texto: 'Catálogo',
                        onPress: () => pageProvider.goToPage(0),
                        vertical: false),
                    _ItemsMenu(
                        texto: 'Inventario',
                        onPress: () => pageProvider.goToPage(1),
                        vertical: false),
                    _ItemsMenu(
                        texto: 'Compras',
                        onPress: () => pageProvider.goToPage(2),
                        vertical: false),
                    _ItemsMenu(
                        texto: 'Ventas',
                        onPress: () => pageProvider.goToPage(3),
                        vertical: false),
                    const SizedBox(
                      width: 10,
                    ),
                    IconButton(
                        onPressed: () => {
                              if (carritoProvider.itemsCarrito != 0)
                                {pageProvider.goToPage(4)}
                            },
                        icon: const Icon(
                          Icons.trolley,
                          color: Colors.black,
                        )),
                    Text('( ${carritoProvider.itemsCarrito} )',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('TOTAL: ${carritoProvider.subtotal} ',
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black)),
                    const SizedBox(
                      width: 50,
                    )
                  ]),
                  // color: Color.fromARGB(255, 22, 201, 183),
                ),
              ),
            )
          : const _MenuDinamico(),
    );
  }
}

class _MenuDinamico extends StatefulWidget {
  const _MenuDinamico({
    Key? key,
  }) : super(key: key);

  @override
  State<_MenuDinamico> createState() => _MenuDinamicoState();
}

class _MenuDinamicoState extends State<_MenuDinamico>
    with SingleTickerProviderStateMixin {
  bool menuopen = false;
  late AnimationController controler;
  @override
  void initState() {
    super.initState();
    controler = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  Widget build(BuildContext context) {
    final pageProvider = Provider.of<PageProvider>(context, listen: false);
    return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (menuopen) {
              controler.reverse();
            } else {
              controler.forward();
            }
            setState(() {
              menuopen = !menuopen;
            });
          },
          child: Container(
            height: menuopen ? 170 : 60,
            width: 1000,

            ///   color: Colors.blue,
            color: menuopen ? Color.fromARGB(255, 213, 226, 213) : Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _MenuTitulo(menuopen: menuopen, controler: controler),
                if (menuopen) ...[
                  const SizedBox(
                    height: 1,
                  ),
                  _ItemsMenu(
                      texto: 'Catálogo',
                      onPress: () => pageProvider.goToPage(0)),
                  const SizedBox(
                    height: 1,
                  ),
                  _ItemsMenu(
                      texto: 'Compras',
                      onPress: () => pageProvider.goToPage(1)),
                  const SizedBox(
                    height: 1,
                  ),
                  // _ItemsMenu(
                  //     texto: 'Diseño', onPress: () => pageProvider.goToPage(3)),
                  // const SizedBox(
                  //   height: 1,
                  // ),
                  _ItemsMenu(
                      texto: 'Inventario',
                      onPress: () => pageProvider.goToPage(3)),
                  const Icon(
                    Icons.trolley,
                    color: Colors.black,
                  )
                ]
              ],
            ),
          ),
        ));
  }
}

class _ItemsMenu extends StatefulWidget {
  const _ItemsMenu({
    required this.texto,
    required this.onPress,
    this.vertical = true,
  });
  final String texto;
  final Function onPress;
  final bool vertical;
  @override
  State<_ItemsMenu> createState() => _ItemsMenuState();
}

class _ItemsMenuState extends State<_ItemsMenu> {
  bool isHover = false;
  @override
  Widget build(BuildContext context) {
    return FadeIn(
      delay: const Duration(milliseconds: 50),
      child: MouseRegion(
        onEnter: (_) => setState(() => isHover = true),
        onExit: (_) => setState(() => isHover = false),
        child: GestureDetector(
          onTap: () => widget.onPress(),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 28,
            width: 130,
            color: isHover
                ? Colors.black12
                : widget.vertical
                    ? Colors.white70
                    : Colors.amberAccent,
            child: Center(
              child: Text(
                widget.texto,
                style: TextStyle(
                    fontSize: widget.vertical ? 15 : 20, color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MenuTitulo extends StatelessWidget {
  const _MenuTitulo({
    Key? key,
    required this.menuopen,
    required this.controler,
  }) : super(key: key);

  final bool menuopen;
  final AnimationController controler;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.red,
      width: 200,
      height: 40,
      //  margin: EdgeInsets.only(top: 25),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        AnimatedContainer(
            width: menuopen ? 5 : 0,
            curve: Curves.easeInOut,
            duration: const Duration(milliseconds: 200)),
        Text('Menu ',
            style: TextStyle(
              fontSize: 15,
            )),
        AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          size: 30,
          progress: controler,
          color: Colors.black,
        )
      ]),
    );
  }
}
