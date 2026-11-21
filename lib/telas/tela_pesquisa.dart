
import 'package:flutter/material.dart';
import '../models/receitas.dart';
import '../widgets/cartao_receita.dart';

class TelaPesquisa extends StatefulWidget {
  final List<Receitas> receitas;
  final List<Receitas> favoritos;
  final Function(Receitas) onFavorito;
  final Function(Receitas) onAbrirReceita;

  const TelaPesquisa({
    super.key,
    required this.receitas,
    required this.favoritos,
    required this.onFavorito,
    required this.onAbrirReceita,
  });

  @override
  State<TelaPesquisa> createState() => _TelaPesquisaState();
}

class _TelaPesquisaState extends State<TelaPesquisa> {
  final TextEditingController pesquisaController =
  TextEditingController();

  String? termoPesquisado;

  List<Receitas> get resultados {
    if (termoPesquisado == null) return [];

    return widget.receitas.where((receita) {
      return receita.nome.toLowerCase().contains(
        termoPesquisado!.toLowerCase(),
      );
    }).toList();
  }

  void pesquisar() {
    setState(() {
      termoPesquisado = pesquisaController.text.trim();
    });

    FocusScope.of(context).unfocus();
  }

  @override
  void dispose() {
    pesquisaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Text(
                    'Pesquisar receitas',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF245B49),
                    ),
                  ),
                ],
              ),
            ),

            const Divider(color: Color(0xFFDCDDD3)),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Nome da receita',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF245B49),
                      ),
                    ),

                    const SizedBox(height: 10),

                    TextField(
                      controller: pesquisaController,
                      decoration: InputDecoration(
                        hintText: 'Buscar pelo nome',
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      onSubmitted: (_) => pesquisar(),
                    ),

                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: pesquisar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF245B49),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Pesquisar'),
                      ),
                    ),

                    const SizedBox(height: 28),

                    if (termoPesquisado != null) ...[
                      Text(
                        'Resultados para "$termoPesquisado"',
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF245B49),
                        ),
                      ),

                      const SizedBox(height: 18),

                      if (termoPesquisado!.isEmpty)
                        const Text(
                          'Digite um nome para pesquisar.',
                          style: TextStyle(
                            color: Color(0xFF617067),
                          ),
                        )
                      else if (resultados.isEmpty)
                        const Text(
                          'Nenhum resultado encontrado. Tente outro termo.',
                          style: TextStyle(
                            color: Color(0xFF617067),
                          ),
                        )
                      else
                        ...resultados.map(
                              (receita) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 14,
                            ),
                            child: CartaoReceita(
                              receita: receita,
                              favorito: widget.favoritos
                                  .contains(receita),
                              onTap: () =>
                                  widget.onAbrirReceita(receita),
                              onFavorito: () =>
                                  widget.onFavorito(receita),
                            ),
                          ),
                        ),

                      const SizedBox(height: 16),

                      OutlinedButton(
                        onPressed: () {
                          setState(() {
                            pesquisaController.clear();
                            termoPesquisado = null;
                          });
                        },
                        child: const Text('Limpar pesquisa'),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
