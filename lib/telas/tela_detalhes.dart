
import 'package:flutter/material.dart';
import '../models/receitas.dart';

class TelaDetalhes extends StatefulWidget {
  final Receitas receita;
  final bool favorito;
  final VoidCallback onFavorito;

  const TelaDetalhes({
    super.key,
    required this.receita,
    required this.favorito,
    required this.onFavorito,
  });

  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  late bool favorito;

  @override
  void initState() {
    super.initState();
    favorito = widget.favorito;
  }

  void alternarFavorito() {
    setState(() {
      favorito = !favorito;
    });

    widget.onFavorito();
  }

  @override
  Widget build(BuildContext context) {
    final receita = widget.receita;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // CABEÇALHO
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                    color: const Color(0xFFC90000),
                  ),

                  const Expanded(
                    child: Text(
                      'Receita',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC90000),
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: alternarFavorito,
                    icon: Icon(
                      favorito
                          ? Icons.favorite
                          : Icons.favorite_border,
                      color: const Color(0xFFC90000),
                    ),
                  ),
                ],
              ),
            ),

            // CONTEÚDO
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // IMAGEM
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        receita.imagem,
                        width: double.infinity,
                        height: 280,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: double.infinity,
                            height: 280,
                            color: const Color(0xFFFCE9E9),
                            child: const Center(
                              child: Text(
                                '🍽️',
                                style: TextStyle(fontSize: 70),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 22),

                    // NOME
                    Text(
                      receita.nome,
                      style: const TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC90000),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${receita.categoria} • '
                          '${receita.dificuldade} • '
                          '${receita.avaliacao} / 5',
                      style: const TextStyle(
                        color: Color(0xFF617067),
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 22),

                    // INFORMAÇÕES
                    Row(
                      children: [
                        infoReceita(
                          receita.tempo,
                          'tempo total',
                        ),
                        const SizedBox(width: 10),
                        infoReceita(
                          '${receita.porcoes}',
                          'porções',
                        ),
                        const SizedBox(width: 10),
                        infoReceita(
                          favorito ? 'Sim' : 'Não',
                          'salva',
                        ),
                      ],
                    ),

                    const SizedBox(height: 30),

                    // INGREDIENTES
                    const Text(
                      'Ingredientes',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC90000),
                      ),
                    ),

                    const SizedBox(height: 14),

                    ...receita.ingredientes.map(
                          (ingrediente) => Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(
                                color: Color(0xFFC90000),
                                fontSize: 18,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ingrediente,
                                style: const TextStyle(
                                  color: Color(0xFF617067),
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 26),

                    // MODO DE PREPARO
                    const Text(
                      'Modo de preparo',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC90000),
                      ),
                    ),

                    const SizedBox(height: 16),

                    ...receita.preparo.asMap().entries.map(
                          (entrada) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 18,
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                const Color(0xFFFCE9E9),
                                child: Text(
                                  '${entrada.key + 1}',
                                  style: const TextStyle(
                                    color: Color(0xFFC90000),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              Expanded(
                                child: Text(
                                  entrada.value,
                                  style: const TextStyle(
                                    color: Color(0xFF617067),
                                    height: 1.5,
                                    fontSize: 15,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // INFORMAÇÕES DA RECEITA
  Widget infoReceita(String valor, String descricao) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 14,
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFFCE9E9),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              valor,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFFC90000),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              descricao,
              style: const TextStyle(
                fontSize: 10,
                color: Color(0xFF617067),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
