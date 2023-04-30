import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:valorant_profiles/models/detalhes_personagem.dart';

import '../configs.dart';
import '../models/personagem.dart';

class PersonagemRepository with ChangeNotifier {
  int _page = 1;

  final List<Personagem> _personagens = [];
  late DetalhesPersonagem _personagem;

  List<Personagem> get personagens => _personagens;
  DetalhesPersonagem get personagem => _personagem;

  getPersonagens(int limit) async {
      final url = Uri.parse(
        '$BASE_API_ENDPOINT/personagens?_page=$_page&_limit=$limit',
      );
      final response = await http.get(url);
      final results = jsonDecode(response.body);
      for (var i = 0; i < results.length; i++) {
        _personagens.add(Personagem.fromMap(results[i]));
      }
      _page++;
      notifyListeners();
  }

  getPersonagem(int id) async {
    final url = Uri.parse(
      '$BASE_API_ENDPOINT/detalhes/$id',
    );
    final response = await http.get(url);
    final result = jsonDecode(response.body);
    _personagem = DetalhesPersonagem.fromMap(result);

    notifyListeners();
  }
}