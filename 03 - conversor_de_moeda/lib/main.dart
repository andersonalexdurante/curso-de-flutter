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
  final realController = TextEditingController();
  final dolarController = TextEditingController();
  final euroController = TextEditingController();

  double dolar;
  double euro;

  void _realChanged(String value) {
    print(value);
  }

  void _dolarChanged(String value) {
    print(value);
  }

  void _euroChanged(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
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
                dolar = snapshot.data["results"]["currencies"]["USD"]["buy"];
                euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];
                return SingleChildScrollView(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Icon(
                        Icons.monetization_on,
                        size: 150,
                      ),
                      buildTextField(
                          'Reais', 'R\$: ', realController, _realChanged),
                      Divider(),
                      buildTextField(
                          'Dólares', 'US\$: ', dolarController, _dolarChanged),
                      Divider(),
                      buildTextField(
                          'Euros', '£: ', euroController, _euroChanged),
                    ],
                  ),
                );
              }
          }
        },
      ),
    );
  }

  Widget buildTextField(String label, String prefix,
      TextEditingController controller, Function changeValue) {
    return TextField(
      keyboardType: TextInputType.number,
      controller: controller,
      decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Colors.black45, fontSize: 20),
          border: OutlineInputBorder(),
          prefixText: prefix),
      onChanged: changeValue,
    );
  }
}
