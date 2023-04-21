class DetalhesPersonagem {
  int id;
  String nome;
  String descricao;

  DetalhesPersonagem({required this.id, required this.nome, required this.descricao});

  factory DetalhesPersonagem.fromMap(Map<String, dynamic> map) {
    return DetalhesPersonagem(
      id: map['id'] ?? 0,
      nome: map['nome'] ?? '',
      descricao: map['descricao'] ?? '',
    );
  }
}
