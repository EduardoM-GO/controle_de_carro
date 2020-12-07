import 'package:controle_de_carro/widgets/Funcao.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:controle_de_carro/widgets/Inserir_form.dart';

class ConsultaForm extends StatefulWidget {
  @override
  _ConsultaFormState createState() => _ConsultaFormState();
}

class _ConsultaFormState extends State<ConsultaForm> {
  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);

    Widget _CarroCard(documents, int i) {
      return Container(
        child: GestureDetector(
          child: Card(
            child: Padding(
              padding: EdgeInsets.all(5),
              child: Row(
                children: <Widget>[
                  Container(
                    width: 80.0,
                    height: 120.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                          image: documents[i]["Imagem"] != null
                              ? Image.network(documents[i]["Imagem"]).image
                              : AssetImage("Imagem/Padrao.png"),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Nome: " + documents[i]["Nome"],
                        ),
                        Text(
                          "Modelo: " + documents[i]["Modelo"],
                        ),
                        Text(
                          "Marca: " + documents[i]["Marca"],
                        ),
                        Text(
                          "Ano: " + documents[i]["Ano"],
                        ),
                        Text(
                          "Fabricante: " + documents[i]["Fabricante"],
                        ),
                        Text(
                          "Tipo de combustível " + documents[i]["Tipo"],
                        ),
                        Text(
                          "Transmissão: " + documents[i]["Transmissao"],
                        ),
                        Text(
                          "Portas: " + documents[i]["Portas"],
                        ),
                        Text(
                          "Ar-condicionado: " + documents[i]["Condicionado"],
                        ),
                        Text(
                          "Passageiros : " + documents[i]["Passageiros"],
                        ),
                        Text(
                          "Motor: " + documents[i]["Motor"],
                        ),
                        Text(
                          "Status: " + documents[i]["Status"],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => InseriForm(documents: documents[i])));
          },
         /* onLongPress: () {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Excluir Carro?"),
                    content: Text("O Carro sera excluidor Completamente!"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("Cancelar"),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                      FlatButton(
                        child: Text("Excluir"),
                        onPressed: () {
                          Delete(documents[i].reference.documentID);
                          Navigator.pop(context);
                          setState(() {});
                        },
                      ),
                    ],
                  );
                });
          },*/
        ),
      );
    }

    Widget _Lista() {
      return Container(
        height: MediaQuery.of(context).size.height - 70,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Carros")
              .orderBy("Nome")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            /* if (snapshot.data == null)
              return Text(FirebaseFirestore.instance.toString());*/
            final documents = snapshot.data.docs;
            return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: documents.length,
              itemBuilder: (ctx, i) => Container(
                padding: EdgeInsets.all(8),
                child: _CarroCard(documents, i),
              ),
            );
          },
        ),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            _Lista(),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => InseriForm()));
              },
              child: Icon(Icons.add),
            ),
          ],
        ),
      ),
    );
  }
}
