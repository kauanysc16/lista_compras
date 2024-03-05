import 'package:flutter/material.dart';
import 'package:lista_compras/ListaController.dart';
import 'package:lista_compras/ListaView.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ListaController _controller = ListaController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de Compras',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaView(controller: _controller),
    );
  }
}