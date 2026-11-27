class Receitas {
  final String nome;
  final String categoria;
  final String dificuldade;
  final String tempo;
  final String avaliacao;
  final int porcoes;
  final String imagem;
  final List<String> ingredientes;
  final List<String> preparo;

  Receitas({
    required this.nome,
    required this.categoria,
    required this.dificuldade,
    required this.tempo,
    required this.avaliacao,
    required this.porcoes,
    required this.imagem,
    required this.ingredientes,
    required this.preparo,
  });

  // Converter JSON da API em Receita
  factory Receitas.fromJson(Map<String, dynamic> json) {
    final preparoMinutos = json['prepTimeMinutes'] ?? 0;
    final cozimentoMinutos = json['cookTimeMinutes'] ?? 0;

    return Receitas(
      nome: json['name'] ?? 'Sem nome',

      categoria: json['cuisine'] ?? 'Não informada',

      dificuldade: json['difficulty'] ?? 'Não informada',

      tempo: '${preparoMinutos + cozimentoMinutos} min',

      avaliacao: (json['rating'] ?? 0).toStringAsFixed(1),

      porcoes: json['servings'] ?? 1,

      imagem: json['image'] ?? '',

      ingredientes: List<String>.from(
        json['ingredients'] ?? [],
      ),

      preparo: List<String>.from(
        json['instructions'] ?? [],
      ),
    );
  }
}
