import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

const request = "https://api.hgbrasil.com/finance?format=json&key=18b65089";
void main() {
  runApp(MaterialApp(
    home: Home(),
    debugShowCheckedModeBanner: false,
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.yellow,
          centerTitle: true,
          title: Text(
            "\$ Conversor de Moedas \$",
            style: TextStyle(color: Colors.black),
          )),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return Center(
                child: Text('Carregando dados...'),
              );
            default:
              if (snapshot.hasError) {
                return Center(
                  child: Text('Erro ao carregar os dados.'),
                );
              } else {
                return Container(color: Colors.amber);
              }
          }
        },
      ),
    );
  }
}
