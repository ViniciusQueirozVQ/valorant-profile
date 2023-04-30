import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:valorant_profiles/models/detalhes_personagem.dart';

import '../configs.dart';
import '../models/personagem.dart';

class PersonagemRepository with ChangeNotifier {
  int _page = 0;
  bool lastPage = false;
  final List<Personagem> _personagens = [];
  late DetalhesPersonagem _personagem;

  List<Personagem> get personagens => _personagens;

  DetalhesPersonagem get personagem => _personagem;

  getPersonagens(int limit) async {
    if (!lastPage) {
      final headers = {'Accept-Charset': 'UTF-8'};
      final url = Uri.parse(
          '$BASE_API_ENDPOINT:$PORT_FEEDS/api/personagens?page=$_page&size=$limit');
      final responseRaw = await http.get(url, headers: headers);
      final results = jsonDecode(utf8.decode(responseRaw.bodyBytes));
      final content = results['content'];

      for (var i = 0; i < content.length; i++) {
        _personagens.add(Personagem.fromMap(content[i]));
      }
      lastPage = results['last'];
      _page++;

      notifyListeners();
    }
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
