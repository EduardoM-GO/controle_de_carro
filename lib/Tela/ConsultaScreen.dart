import 'package:controle_de_carro/widgets/consulta_form.dart';
import 'package:flutter/material.dart';

class ConsultaScreen extends StatefulWidget {
  @override
  _ConsultaScreenState createState() => _ConsultaScreenState();
}

class _ConsultaScreenState extends State<ConsultaScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ConsultaForm(),
    );
  }
}
