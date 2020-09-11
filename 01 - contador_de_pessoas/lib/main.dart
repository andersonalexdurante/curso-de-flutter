import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: 'Contador de Pessoas', home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _people = 0;
  String _permission = "Pode Entrar!!";

  void _changePeople(int delta) {
    setState(() {
      _people += delta;
      if (_people == 10) {
        _permission = "Lotado!!";
      } else if (_people <= 10 && _people > 0) {
        _permission = "Pode Entrar!!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Image.asset(
        'images/restaurant.jpg',
        fit: BoxFit.cover,
        height: 1000,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Pessoas: $_people",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FlatButton(
                      child: Text("+1",
                          style: TextStyle(fontSize: 40, color: Colors.white)),
                      onPressed: () {
                        _changePeople(1);
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: FlatButton(
                    child: Text("-1",
                        style: TextStyle(fontSize: 40, color: Colors.white)),
                    onPressed: () {
                      _changePeople(-1);
                    },
                  ),
                )
              ],
            ),
          ),
          Text(_permission, style: TextStyle(color: Colors.white, fontSize: 30))
        ],
      ),
    ]);
  }
}
