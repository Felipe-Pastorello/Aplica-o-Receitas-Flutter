
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
                  ),

                  const Expanded(
                    child: Text(
                      'Receita',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF245B49),
                      ),
                    ),
                  ),

                  IconButton(
                    onPressed: widget.onFavorito,
                    icon: Icon(
                      widget.favorito
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
                    Container(
                      width: double.infinity,
                      height: 190,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEAE6D7),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          receita.imagem,
                          style: const TextStyle(fontSize: 100),
                        ),
                      ),
                    ),

                    const SizedBox(height: 18),

                    // NOME
                    Text(
                      receita.nome,
                      style: const TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF245B49),
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${receita.categoria} • '
                          '${receita.dificuldade} • '
                          '${receita.avaliacao} / 5',
                      style: const TextStyle(
                        color: Color(0xFF617067),
                      ),
                    ),

                    const SizedBox(height: 20),

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
                          widget.favorito ? 'Sim' : 'Não',
                          'salva',
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // INGREDIENTES
                    const Text(
                      'Ingredientes',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF245B49),
                      ),
                    ),

                    const SizedBox(height: 12),

                    ...receita.ingredientes.map(
                          (ingrediente) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Row(
                          children: [
                            const Text(
                              '• ',
                              style: TextStyle(
                                color: Color(0xFF245B49),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                ingrediente,
                                style: const TextStyle(
                                  color: Color(0xFF617067),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // MODO DE PREPARO
                    const Text(
                      'Modo de preparo',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF245B49),
                      ),
                    ),

                    const SizedBox(height: 14),

                    ...receita.preparo.asMap().entries.map(
                          (entrada) {
                        return Padding(
                          padding: const EdgeInsets.only(
                            bottom: 16,
                          ),
                          child: Row(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor:
                                const Color(0xFF245B49),
                                child: Text(
                                  '${entrada.key + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
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
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoReceita(String valor, String descricao) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 6,
        ),
        decoration: BoxDecoration(
          color: const Color(0xFFE7EEE7),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(
              valor,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF245B49),
              ),
            ),
            const SizedBox(height: 4),
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
