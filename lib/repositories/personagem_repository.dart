import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:valorant_profiles/models/detalhes_personagem.dart';

import '../models/personagem.dart';

class PersonagemRepository with ChangeNotifier {
  int _page = 1;
  final int _limit = 5;
  final int _totalItems = 21;

  final List<Personagem> _personagens = [];
  late final DetalhesPersonagem _personagem;

  List<Personagem> get personagens => _personagens;

  DetalhesPersonagem get personagem => _personagem;

  getPersonagens() async {
    int totalPages =
        (_totalItems / _limit).ceil(); // Calcular o número total de páginas

    if (_page <= totalPages) {
      // Verificar se ainda há páginas para exibir
      final String responseString =
          await rootBundle.loadString('assets/feeds.json');
      var response = json.decode(responseString);
      var personagensResponse = response["content"];
      var startIndex = (_page - 1) * _limit;
      var endIndex = startIndex + _limit;

      // Tratar o caso da última página
      if (endIndex > _totalItems) {
        endIndex = _totalItems;
      }

      var subListA = personagensResponse.sublist(startIndex, endIndex);

      for (int i = 0; i < subListA.length; i++) {
        _personagens.add(Personagem.fromMap(subListA[i]));
      }

      _page++;
      notifyListeners();
    }
  }

  getPersonagem(int id) async {
    final String responseString =
        await rootBundle.loadString('assets/detalhes.json');
    var response = json.decode(responseString);
    var personagensResponse = response["content"];

    var personagemResponse = personagensResponse
        .firstWhere((personagem) => personagem["id"] == id, orElse: () => null);

    if (personagemResponse != null) {
      _personagem = DetalhesPersonagem.fromMap(personagemResponse);
      notifyListeners();
    }
  }
}
