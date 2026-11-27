
import 'package:flutter/material.dart';

import 'models/receitas.dart';
import 'telas/tela_detalhes.dart';
import 'telas/tela_favoritos.dart';
import 'telas/tela_pesquisa.dart';
import 'widgets/cartao_receita.dart';
import 'services/receitas_api.dart';
import 'widgets/estados_receitas.dart';

void main() {
  runApp(const SaboreApp());
}

class SaboreApp extends StatelessWidget {
  const SaboreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Receitas de Vó',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F6EF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFC90000),
        ),
        fontFamily: 'Roboto',
      ),
      home: const TelaInicial(),
    );
  }
}

class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  final TextEditingController pesquisaController =
  TextEditingController();

  String? mensagemErro;
  String? termoPesquisado;
  String? erroApi;

  int paginaSelecionada = 0;

  // LISTA DE RECEITAS
  List<Receitas> receitas = [];

  // LISTA DE FAVORITOS
  final List<Receitas> favoritos = [];

  // CONTROLE DE CARREGAMENTO
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    carregarReceitas();
  }

  // Buscar receitas na API
  Future<void> carregarReceitas() async {
    setState(() {
      carregando = true;
      erroApi = null;
    });

    final resposta = await buscarReceitas();

    if (!mounted) return;

    setState(() {
      if (resposta.erro != null) {
        erroApi = resposta.erro;
        receitas = [];
      } else {
        receitas = resposta.receitas.map((item) {
          return Receitas.fromJson(
            Map<String, dynamic>.from(item),
          );
        }).toList();
      }

      carregando = false;
    });
  }

  // Filtros
  List<Receitas> get receitasFiltradas {
    if (termoPesquisado == null ||
        termoPesquisado!.isEmpty) {
      return receitas;
    }

    return receitas.where((receita) {
      return receita.nome.toLowerCase().contains(
        termoPesquisado!.toLowerCase(),
      );
    }).toList();
  }

  // Pesquisar receita
  void pesquisarReceita() {
    final termo = pesquisaController.text.trim();

    setState(() {
      if (termo.isEmpty) {
        mensagemErro =
        'Digite o nome de uma receita para realizar a pesquisa.';
        termoPesquisado = null;
        return;
      }

      mensagemErro = null;
      termoPesquisado = termo;
    });

    FocusScope.of(context).unfocus();

    if (termo.isEmpty) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Pesquisa realizada: $termo'),
      ),
    );
  }

  // Add e Remover dos Favoritos
  void alternarFavorito(Receitas receita) {
    setState(() {
      if (favoritos.contains(receita)) {
        favoritos.remove(receita);
      } else {
        favoritos.add(receita);
      }
    });
  }

  // Tela de Detalhes da Pesquisa
  void abrirReceita(Receitas receita) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaDetalhes(
          receita: receita,
          favorito: favoritos.contains(receita),
          onFavorito: () {
            alternarFavorito(receita);
          },
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }


  void abrirPesquisa() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TelaPesquisa(
          receitas: receitas,
          favoritos: favoritos,
          onFavorito: alternarFavorito,
          onAbrirReceita: abrirReceita,
        ),
      ),
    ).then((_) {
      if (mounted) {
        setState(() {});
      }
    });
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(
                24, 24, 24, 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Receitas de Vó',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFC90000),
                          ),
                        ),
                      ),

                      // Acessar Pesquisa
                    ],
                  ),

                  const SizedBox(height: 16),

                  Container(
                    height: 1,
                    color: const Color(0xFFDCDDD3),
                  ),
                ],
              ),
            ),

            // Main
            Expanded(
              child: paginaSelecionada == 0
                  ? carregando
                  ? const EstadoCarregamento()
                  : erroApi != null
                  ? EstadoErro(
                mensagem: erroApi!,
                onTentarNovamente: carregarReceitas,
              )
                  : telaExplorar()
                  : TelaFavoritos(
                favoritos: favoritos,
                onFavorito: alternarFavorito,
                onAbrirReceita: abrirReceita,
              ),
            ),
          ],
        ),
      ),

      // Footer
      bottomNavigationBar: NavigationBar(
        selectedIndex: paginaSelecionada,
        backgroundColor: Colors.white,
        indicatorColor: const Color(0xFFE7EEE7),
        onDestinationSelected: (int index) {
          setState(() {
            paginaSelecionada = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Explorar',
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }

  // Tela Inicial
  Widget telaExplorar() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Receitas',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC90000),
            ),
          ),

          const SizedBox(height: 24),

          // Campo de Pesquisa
          TextField(
            controller: pesquisaController,
            decoration: InputDecoration(
              labelText: 'Nome da receita',
              hintText: 'Ex: Bolo de cenoura',
              errorText: mensagemErro,
              prefixIcon: const Icon(
                Icons.search,
                color: Color(0xFF617067),
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
              const EdgeInsets.symmetric(vertical: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFDCDDD3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Color(0xFFDCDDD3),
                ),
              ),
            ),
            onChanged: (valor) {
              if (mensagemErro != null) {
                setState(() {
                  mensagemErro = null;
                });
              }
            },
            onSubmitted: (_) => pesquisarReceita(),
          ),

          const SizedBox(height: 12),

          // Botão Pesquisa
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: pesquisarReceita,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFC90000),
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              child: const Text(
                'Pesquisar receita',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Resultados da pesquisa
          if (termoPesquisado != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: const Color(0xFFDCDDD3),
                ),
              ),
              child: Text(
                'Você pesquisou por: "$termoPesquisado"',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF617067),
                ),
              ),
            ),

          const SizedBox(height: 28),

          Text(
            termoPesquisado == null
                ? 'Receitas disponíveis'
                : 'Resultados da pesquisa',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC90000),
            ),
          ),

          const SizedBox(height: 6),

          const Text(
            'Selecione uma receita para ver o preparo.',
            style: TextStyle(
              fontSize: 13,
              color: Color(0xFF617067),
            ),
          ),

          const SizedBox(height: 18),

          // Listar receitas
          if (receitasFiltradas.isEmpty)
            const Center(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Text(
                  'Nenhuma receita encontrada.\nTente outro termo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF617067),
                    fontSize: 15,
                  ),
                ),
              ),
            )
          else
            ...receitasFiltradas.map(
                  (receita) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: CartaoReceita(
                  receita: receita,
                  favorito: favoritos.contains(receita),
                  onTap: () => abrirReceita(receita),
                  onFavorito: () {
                    alternarFavorito(receita);
                  },
                ),
              ),
            ),

          // Limpar Pesquisa
          if (termoPesquisado != null)
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton(
                onPressed: () {
                  setState(() {
                    pesquisaController.clear();
                    termoPesquisado = null;
                    mensagemErro = null;
                  });
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: const Color(0xFFC90000),
                  side: const BorderSide(
                    color: Color(0xFFDCDDD3),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Limpar pesquisa'),
              ),
            ),

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
