import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

Future<String> uploadStorage(
    BuildContext context, File Arquivo, String NomeCarro) async {
  try {
    String temp;
    await downloadStorage(context, NomeCarro).then((String result) {
      temp = result;
    });
    if (temp != "" && temp != null) {
      DeleteStorage(temp);
    }
    Task task = FirebaseStorage.instance
        .ref('uploads')
        .child('$NomeCarro.png')
        .putFile(Arquivo);
    TaskSnapshot taskSnapshot = await task.snapshot;
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
  }
}

Future<String> downloadStorage(BuildContext context, String NomeCarro) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  try {
    final String url = await FirebaseStorage.instance
        .ref('uploads/$NomeCarro.png')
        .getDownloadURL();
    return url;
  } on FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
  }
}

DeleteStorage(String url) async {
  try {
    await FirebaseStorage.instance.ref().child(url).delete();
  } on FirebaseException catch (e) {
    // e.g, e.code == 'canceled'
  }
}

InserirDados(Nome, Modelo, Marca, Ano, Fabricante, Tipo, Transmissao, Portas,
    Condicionado, Passageiros, Motor, Status, Imagem) {
  FirebaseFirestore.instance.collection("Carros").add({
    "Nome": Nome,
    "Modelo": Modelo,
    "Marca": Marca,
    "Ano": Ano,
    "Fabricante": Fabricante,
    "Tipo": Tipo,
    "Transmissao": Transmissao,
    "Portas": Portas,
    "Condicionado": Condicionado,
    "Passageiros": Passageiros,
    "Motor": Motor,
    "Status": Status,
    "Imagem": Imagem,
    "createdAt": Timestamp.now(),
  });
}

Future<String> currentUserUID(documents) async {
  return documents.reference.documentID;
}

Delete(id) async {
  var snapshots =
      FirebaseFirestore.instance.collection('Carros').document(id).snapshots();

  await snapshots.forEach((document) async {
    document.reference.delete();
  });
}

Update(id, Nome, Modelo, Marca, Ano, Fabricante, Tipo, Transmissao, Portas,
    Condicionado, Passageiros, Motor, Status, Imagem) async {
  var snapshots =
      FirebaseFirestore.instance.collection('Carros').document(id).snapshots();

  await snapshots.forEach((document) async {
    document.reference.update((<String, dynamic>{
      "Nome": Nome,
      "Modelo": Modelo,
      "Marca": Marca,
      "Ano": Ano,
      "Fabricante": Fabricante,
      "Tipo": Tipo,
      "Transmissao": Transmissao,
      "Portas": Portas,
      "Condicionado": Condicionado,
      "Passageiros": Passageiros,
      "Motor": Motor,
      "Status": Status,
      "Imagem": Imagem,
      "createdAt": Timestamp.now(),
    }));
  });
}
