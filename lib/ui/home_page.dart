import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valorant_profiles/ui/detalhes_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _offset = 0;

  Future<Map> _getPersonagens() async {
    final String response = await rootBundle.loadString('assets/feeds.json');
    return await json.decode(response);
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
          title: Text("Valorant: Profiles"),
          centerTitle: true,
        ),
        body: FutureBuilder(
          future: _getPersonagens(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Container();
            else {
              return ListView.builder(
                  padding: EdgeInsets.all(10.0),
                  itemCount: _getCount(snapshot.data!["content"]),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            children: [
                              Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: AssetImage(snapshot.data!["content"]
                                            [index]["avatar"] ??
                                        'assets/person.png'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      snapshot.data!["content"][index]["nome"],
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data!["content"][index]
                                          ["classe"],
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      snapshot.data!["content"][index]
                                          ["nacionalidade"],
                                      style: TextStyle(
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetalhesPage(
                                    snapshot.data!["content"][index]["id"])));
                      },
                    );
                  });
            }
          },
        ));
  }

  int _getCount(List data) {
    return data.length ?? 0;
  }
}
