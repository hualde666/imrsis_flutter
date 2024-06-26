//import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:universal_html/html.dart' as html;

class PageProvider extends ChangeNotifier {
  PageController scrollController = PageController();
  final List<String> _paginas = [
    'catalogo',
    'inventario',
    'compras',
    'ventas',
    'carrito'
  ];

  int _currentPagina = 0;
  createScrollControlller(String routeName) {
    scrollController = PageController(initialPage: getPageIndex(routeName));
    html.document.title = 'imresanca ${_paginas[getPageIndex(routeName)]}';
    scrollController.addListener(() {
      final index = (scrollController.page ?? 0).round();
      if (index != _currentPagina) {
        html.window.history.pushState(null, '', '#/${_paginas[index]}');
        _currentPagina = index;
        html.document.title = 'imresanca ${_paginas[index]}';
      }
    });
  }

  int getPageIndex(String routeName) {
    return (!_paginas.contains(routeName)) ? 0 : _paginas.indexOf(routeName);
  }

  goToPage(int pagina) {
    //final rutaNombre = _paginas[pagina];

    //html.window.history.pushState(null, '', '#/${_paginas[pagina]}');
    scrollController.animateToPage(pagina,
        duration: const Duration(milliseconds: 50), curve: Curves.bounceOut);
  }
}
