class Personagem {
  int id;
  String nome;
  String nacionalidade;
  String classe;
  String avatar;

  Personagem({required this.id, required this.nome, required this.nacionalidade, required this.classe, required this.avatar});

  factory Personagem.fromMap(Map<String, dynamic> map) {
    return Personagem(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      nacionalidade: map['nacionalidade'] ?? '',
      classe: map['classe'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }
}
