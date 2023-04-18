import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class DetalhesPage extends StatefulWidget {
  final int idPersonagem;

  DetalhesPage(this.idPersonagem);

  @override
  _DetalhesPage createState() => _DetalhesPage();
}

class _DetalhesPage extends State<DetalhesPage> {
  Future<dynamic> _getPersonagem() async {
    final String response = await rootBundle.loadString('assets/detalhes.json');
    Map<String, dynamic> personagem = json.decode(response);
    List<dynamic> content = personagem["content"];
    return content
        .where((item) => item['id'] == widget.idPersonagem)
        .toList()
        .first;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Detalhes"),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: _getPersonagem(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Container();
              else
                return Column(
                  children: [
                    Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          snapshot.data["nome"],
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                              color: Colors.red),
                        )),
                    Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          snapshot.data["descricao"],
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.black),
                        )),
                  ],
                );
            }));
  }
}
