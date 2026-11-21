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
}
