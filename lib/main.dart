import 'package:flutter/material.dart';
import 'package:imresanca/providers/carrito_provider.dart';
import 'package:imresanca/providers/db_provider.dart';
import 'package:imresanca/providers/page_provider.dart';
import 'package:imresanca/router/router.dart';

import 'package:provider/provider.dart';

void main() => runApp(const AppState());

class AppState extends StatelessWidget {
  const AppState({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PageProvider()),
        ChangeNotifierProvider(create: (_) => CarritoProvider()),
        Provider(create: (_) => DbProvider()),
      ],
      child: const MainApp(),
    );
  }
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();

    Flurorouter.configureRoutes();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: colorThema(),

      title: 'imresanca',
      initialRoute: '/inicio',
      onGenerateRoute: Flurorouter.router.generator,
      //  backgroundColor: Colors.black87,
      // body: Facturar() //ListaCatalogo(),
    );
  }

  ThemeData colorThema() {
    return ThemeData(
      scaffoldBackgroundColor: Colors.black87,
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: MaterialStateProperty.all(Colors.white),
      ),
      primaryColor: Colors.white,
      textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white60)),
    );
  }
}

class Header extends StatelessWidget {
  const Header({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      //    height: 120,
      padding: const EdgeInsets.only(top: 10, bottom: 10, left: 20),
      color: Colors.blueAccent,
      child: const Text(
        'IMRESANCA',
        style: TextStyle(fontSize: 25, color: Colors.white),
      ),
    );
  }
}
