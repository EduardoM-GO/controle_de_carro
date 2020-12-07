import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:controle_de_carro/widgets/Funcao.dart';
import 'package:image_picker/image_picker.dart';
import 'package:controle_de_carro/widgets/Funcao.dart';

class InseriForm extends StatefulWidget {
  final documents;

  InseriForm({this.documents});

  @override
  _InserirFormState createState() => _InserirFormState();
}

class _InserirFormState extends State<InseriForm> {
  TextEditingController _Nome = TextEditingController();
  TextEditingController _Modelo = TextEditingController();
  TextEditingController _Marca = TextEditingController();
  TextEditingController _Ano = TextEditingController();
  TextEditingController _Fabricante = TextEditingController();
  TextEditingController _Tipo = TextEditingController();
  TextEditingController _Transmissao = TextEditingController();
  TextEditingController _Portas = TextEditingController();
  TextEditingController _Condicionado = TextEditingController();
  TextEditingController _Passageiros = TextEditingController();
  TextEditingController _Motor = TextEditingController();
  TextEditingController _Status = TextEditingController();
  TextEditingController _Imagem = TextEditingController();

  var _status = ["Disponivel", "Alugado"];
  var _opcao = ["Sim", "Não"];
  var _tipo = ["Gasolina", "Etanol", "Diesel", "Flex"];
  var _trans = ["Manual", "Automática"];
  final _NomeFocus = FocusNode();
  int _operacao;

  @override
  void initState() {
    super.initState();
    if (widget.documents == null) {
      _Nome.text = "";
      _Modelo.text = "";
      _Marca.text = "";
      _Ano.text = "";
      _Fabricante.text = "";
      _Tipo.text = _tipo[3];
      _Transmissao.text = _trans[0];
      _Portas.text = "";
      _Condicionado.text = _opcao[0];
      _Passageiros.text = "";
      _Motor.text = "";
      _Status.text = _status[0];
      _Imagem.text =
          "https://firebasestorage.googleapis.com/v0/b/controle-carro-81517.appspot.com/o/uploads%2FPadrao.png?alt=media&token=d8a32969-aa69-48c3-8136-c59e196e81c7";
      _operacao = 0;
    } else {
      _Nome.text = widget.documents["Nome"];
      _Modelo.text = widget.documents["Modelo"];
      _Marca.text = widget.documents["Marca"];
      _Ano.text = widget.documents["Ano"];
      _Fabricante.text = widget.documents["Fabricante"];
      _Tipo.text = widget.documents["Tipo"];
      _Transmissao.text = widget.documents["Transmissao"];
      _Portas.text = widget.documents["Portas"];
      _Condicionado.text = widget.documents["Condicionado"];
      _Passageiros.text = widget.documents["Passageiros"];
      _Motor.text = widget.documents["Motor"];
      _Status.text = widget.documents["Status"];
      _Imagem.text = widget.documents["Imagem"];
      _operacao = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData deviceInfo = MediaQuery.of(context);

    ImageProvider _VerificaImagem(String url) {
      if (url.contains("https://firebasestorage") == true) {
        return Image.network(url).image;
      } else {
        return AssetImage(url);
      }
    }

    Widget _SelectStatus() {
      return Container(
        width: 158,
        child: TextField(
          controller: _Status,
          decoration: InputDecoration(
            labelText: "Status",
            labelStyle: TextStyle(fontSize: 20),
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 40,
              ),
              padding: EdgeInsets.all(8),
              onSelected: (String value) {
                _Status.text = value;
              },
              itemBuilder: (BuildContext context) {
                return _status.map<PopupMenuItem<String>>((String value) {
                  return new PopupMenuItem(
                      child: new Text(value), value: value);
                }).toList();
              },
            ),
          ),
          readOnly: true,
        ),
      );
    }

    Widget _Ar() {
      return Container(
        width: 183,
        child: TextField(
          controller: _Condicionado,
          decoration: InputDecoration(
            labelText: "Ar-condicionado",
            labelStyle: TextStyle(fontSize: 20),
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 40,
              ),
              padding: EdgeInsets.all(8),
              onSelected: (String value) {
                _Condicionado.text = value;
              },
              itemBuilder: (BuildContext context) {
                return _opcao.map<PopupMenuItem<String>>((String value) {
                  return new PopupMenuItem(
                      child: new Text(value), value: value);
                }).toList();
              },
            ),
          ),
          readOnly: true,
        ),
      );
    }

    Widget _Combustivel() {
      return Container(
        width: 183,
        child: TextField(
          controller: _Tipo,
          decoration: InputDecoration(
            labelText: "Tipo de combustível",
            labelStyle: TextStyle(fontSize: 20),
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 40,
              ),
              padding: EdgeInsets.all(8),
              onSelected: (String value) {
                _Tipo.text = value;
              },
              itemBuilder: (BuildContext context) {
                return _tipo.map<PopupMenuItem<String>>((String value) {
                  return new PopupMenuItem(
                      child: new Text(value), value: value);
                }).toList();
              },
            ),
          ),
          readOnly: true,
        ),
      );
    }

    Widget _transmissao() {
      return Container(
        width: 158,
        child: TextField(
          controller: _Transmissao,
          decoration: InputDecoration(
            labelText: "Transmissão",
            labelStyle: TextStyle(fontSize: 20),
            suffixIcon: PopupMenuButton<String>(
              icon: const Icon(
                Icons.arrow_drop_down,
                size: 40,
              ),
              padding: EdgeInsets.all(8),
              onSelected: (String value) {
                _Transmissao.text = value;
              },
              itemBuilder: (BuildContext context) {
                return _trans.map<PopupMenuItem<String>>((String value) {
                  return new PopupMenuItem(
                      child: new Text(value), value: value);
                }).toList();
              },
            ),
          ),
          readOnly: true,
        ),
      );
    }

    Widget _FormCarro() {
      return Container(
        child: Column(
          children: <Widget>[
            Text(
              "Para tirar foto é so clicar na imagem",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 30)),
            GestureDetector(
              child: Container(
                width: 150.0,
                height: 100.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: _Imagem.text != null
                          ? _VerificaImagem(_Imagem.text)
                          : _VerificaImagem(
                              "https://firebasestorage.googleapis.com/v0/b/controle-carro-81517.appspot.com/o/uploads%2FPadrao.png?alt=media&token=d8a32969-aa69-48c3-8136-c59e196e81c7"),
                      fit: BoxFit.cover),
                ),
              ),
              onTap: () {
                try {
                  ImagePicker.pickImage(source: ImageSource.camera)
                      .then((file) {
                    if (file == null) return;
                    _VerificaImagem(file.path);
                    setState(() {
                      _Imagem.text = file.path;
                    });
                  });
                } catch (e, s) {}
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Nome',
              ),
              controller: _Nome,
              focusNode: _NomeFocus,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Modelo',
              ),
              controller: _Modelo,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Marca',
              ),
              controller: _Marca,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Ano',
              ),
              controller: _Ano,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Fabricante',
              ),
              controller: _Fabricante,
            ),
            Row(
              children: <Widget>[
                _Combustivel(),
                Padding(padding: EdgeInsets.only(left: 50)),
                _transmissao(),
              ],
            ),
            Row(
              children: <Widget>[
                _Ar(),
                Padding(padding: EdgeInsets.only(left: 50)),
                _SelectStatus(),
              ],
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Portas',
              ),
              controller: _Portas,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Passageiros',
              ),
              controller: _Passageiros,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Motor',
              ),
              controller: _Motor,
            ),
            Padding(padding: EdgeInsets.only(top: 40.0)),
          ],
        ),
      );
    }
    Widget _Botao() {
      if(widget.documents == null) {
        return Container(
          width: 158,
          child: RaisedButton(
            onPressed: () async {
              String TempImagem;
              print(_Imagem.text);
              if (_Nome.text != null && _Nome.text.isNotEmpty) {
                if (_Imagem.text.contains("https://firebasestorage") !=
                    true) {
                  await uploadStorage(
                      context, File(_Imagem.text), _Nome.text)
                      .then((String result) {
                    print(result);
                    setState(() {
                      TempImagem = result;
                    });
                  });
                } else {
                  TempImagem = _Imagem.text;
                }
                print(TempImagem);
                if (_operacao == 0) {

                  InserirDados(
                      _Nome.text,
                      _Modelo.text,
                      _Marca.text,
                      _Ano.text,
                      _Fabricante.text,
                      _Tipo.text,
                      _Transmissao.text,
                      _Portas.text,
                      _Condicionado.text,
                      _Passageiros.text,
                      _Motor.text,
                      _Status.text,
                      TempImagem);
                } else {
                  Update(
                      widget.documents.reference.documentID,
                      _Nome.text,
                      _Modelo.text,
                      _Marca.text,
                      _Ano.text,
                      _Fabricante.text,
                      _Tipo.text,
                      _Transmissao.text,
                      _Portas.text,
                      _Condicionado.text,
                      _Passageiros.text,
                      _Motor.text,
                      _Status.text,
                      TempImagem);
                }
                Navigator.pop(
                  context,
                );
              } else {
                FocusScope.of(context).requestFocus(_NomeFocus);
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)),
            color: Colors.green,
            elevation: 4,
            child: Icon(Icons.save),
          ),
        );
      }else{
        return Container(
          child: Row(

            children: <Widget>[
              Container(
                width: 158,
                child: RaisedButton(
                  onPressed: () async {
                    String TempImagem;
                    print(_Imagem.text);
                    if (_Nome.text != null && _Nome.text.isNotEmpty) {
                      if (_Imagem.text.contains("https://firebasestorage") !=
                          true) {
                        await uploadStorage(
                            context, File(_Imagem.text), _Nome.text)
                            .then((String result) {
                          print(result);
                          setState(() {
                            TempImagem = result;
                          });
                        });
                      } else {
                        TempImagem = _Imagem.text;
                      }
                      if (_operacao == 0) {
                        //downloadStorage(context, _Nome.text)

                        InserirDados(
                            _Nome.text,
                            _Modelo.text,
                            _Marca.text,
                            _Ano.text,
                            _Fabricante.text,
                            _Tipo.text,
                            _Transmissao.text,
                            _Portas.text,
                            _Condicionado.text,
                            _Passageiros.text,
                            _Motor.text,
                            _Status.text,
                            TempImagem);
                      } else {
                        Update(
                            widget.documents.reference.documentID,
                            _Nome.text,
                            _Modelo.text,
                            _Marca.text,
                            _Ano.text,
                            _Fabricante.text,
                            _Tipo.text,
                            _Transmissao.text,
                            _Portas.text,
                            _Condicionado.text,
                            _Passageiros.text,
                            _Motor.text,
                            _Status.text,
                            TempImagem);
                      }
                      Navigator.pop(
                        context,
                      );
                    } else {
                      FocusScope.of(context).requestFocus(_NomeFocus);
                    }
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: Colors.green,
                  elevation: 4,
                  child: Icon(Icons.save),
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 70)),

              Container(
                width: 158,
                child: RaisedButton(
                  onPressed: () async {
                    Delete(
                        widget.documents.reference.documentID);
                    Navigator.pop(context);
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
                  color: Colors.redAccent,
                  elevation: 4,
                  child: Icon(Icons.delete),
                ),
              ),
            ],
          ),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(_Nome.text ?? "Novo Carro"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
        physics: ScrollPhysics(),
        child: Column(
          children: <Widget>[
            _FormCarro(),
            _Botao()
          ],
        ),
      ),
    );
  }
}
