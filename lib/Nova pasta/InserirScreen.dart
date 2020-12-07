import 'package:controle_de_carro/widgets/consulta_form.dart';
import 'package:flutter/material.dart';

class InserirScreen extends StatefulWidget {
  @override
  _InserirScreenState createState() => _InserirScreenState();
}

class _InserirScreenState extends State<InserirScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: ConsultaForm(),
    );
  }
}
