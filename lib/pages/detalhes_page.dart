import 'package:flutter/material.dart';
import 'package:valorant_profiles/models/detalhes_personagem.dart';

import '../repositories/personagem_repository.dart';

class DetalhesPage extends StatefulWidget {
  final int idPersonagem;

  DetalhesPage(this.idPersonagem);

  @override
  _DetalhesPageState createState() => _DetalhesPageState();
}

class _DetalhesPageState extends State<DetalhesPage> {
  late PersonagemRepository personagemRepository;
  late DetalhesPersonagem detalhesPersonagem;

  @override
  void initState() {
    super.initState();
    personagemRepository = PersonagemRepository();
    detalhesPersonagem = DetalhesPersonagem(id: 0, descricao: '', nome: '');
    loadPersonagem();
  }

  void loadPersonagem() async {
    await personagemRepository.getPersonagem(widget.idPersonagem);
    setState(() {
      detalhesPersonagem = personagemRepository.personagem;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Detalhes"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              detalhesPersonagem.nome,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 50,
                  color: Colors.red),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              detalhesPersonagem.descricao,
              style: const TextStyle(fontSize: 25, color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }
}