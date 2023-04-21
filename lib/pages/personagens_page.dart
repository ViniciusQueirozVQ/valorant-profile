import 'package:flutter/material.dart';
import 'package:valorant_profiles/widgets/personagem_list.dart';

class UsuariosPage extends StatelessWidget {
  const UsuariosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Valorant: Profiles'),
        centerTitle: true,
      ),
      body: PersonagemList(),
    );
  }
}
