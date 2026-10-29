import 'package:flutter/material.dart';

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

  int paginaSelecionada = 0;

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
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Receitas de Vó',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC90000),
                    ),
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
              child: SingleChildScrollView(
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

                    // Busca
                    TextField(
                      controller: pesquisaController,
                      decoration: InputDecoration(
                        hintText: 'Buscar Receitas',
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
                    ),

                    const SizedBox(height: 12),

                    // Botão de busca
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: () {
                          FocusScope.of(context).unfocus();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                pesquisaController.text.trim().isEmpty
                                    ? 'Digite o nome de uma receita.'
                                    : 'Pesquisa: ${pesquisaController.text}',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC90000),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Text(
                          'Buscar',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Receitas disponíveis',
                      style: TextStyle(
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

                    // Cartão da receita
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: const Color(0xFFDCDDD3),
                        ),
                      ),
                      child: Row(
                        children: [
                          // Imagem
                          Container(
                            width: 92,
                            height: 110,
                            decoration: BoxDecoration(
                              color: const Color(0xFFEAE6D7),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: const Center(
                              child: Text(
                                '🍔',
                                style: TextStyle(fontSize: 48),
                              ),
                            ),
                          ),

                          const SizedBox(width: 14),

                          // Informações da receita
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Hamburguer',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC90000),
                                  ),
                                ),

                                const SizedBox(height: 18),

                                const Text(
                                  '25 min  •  Fácil',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF617067),
                                  ),
                                ),

                                const SizedBox(height: 10),

                                const Text(
                                  '5 / 5',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFFC90000),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Ícone de favorito
                          IconButton(
                            onPressed: () {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Receita adicionada aos favoritos!',
                                  ),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Color(0xFFC90000),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
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
}