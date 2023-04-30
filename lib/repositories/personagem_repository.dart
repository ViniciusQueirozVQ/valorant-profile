import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:valorant_profiles/models/detalhes_personagem.dart';

import '../configs.dart';
import '../models/personagem.dart';

class PersonagemRepository with ChangeNotifier {
  int _page = 0;

  final List<Personagem> _personagens = [];
  late DetalhesPersonagem _personagem;

  List<Personagem> get personagens => _personagens;
  DetalhesPersonagem get personagem => _personagem;

  getPersonagens(int limit) async {
    final headers = {'Accept-Charset': 'UTF-8'};
    final url = Uri.parse(
        '$BASE_API_ENDPOINT:$PORT_FEEDS/api/personagens?page=$_page&size=$limit');
    final responseRaw = await http.get(url, headers: headers);
    final response = utf8.decode(responseRaw.bodyBytes);
    final results = jsonDecode(response)['content'];

    for (var i = 0; i < results.length; i++) {
      _personagens.add(Personagem.fromMap(results[i]));
    }
    _page++;
    notifyListeners();
  }

  getPersonagem(int id) async {
    final headers = {'Accept-Charset': 'UTF-8'};
    final url = Uri.parse(
      '$BASE_API_ENDPOINT:$PORT_DETALHES/api/detalhes/$id',
    );
    final responseRaw = await http.get(url, headers: headers);
    final response = utf8.decode(responseRaw.bodyBytes);
    _personagem = DetalhesPersonagem.fromMap(jsonDecode(response));

    notifyListeners();
  }
}