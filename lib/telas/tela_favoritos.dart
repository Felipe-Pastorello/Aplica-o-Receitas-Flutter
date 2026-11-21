
import 'package:flutter/material.dart';
import '../models/receitas.dart';
import '../widgets/cartao_receita.dart';

class TelaFavoritos extends StatelessWidget {
  final List<Receitas> favoritos;
  final Function(Receitas) onFavorito;
  final Function(Receitas) onAbrirReceita;

  const TelaFavoritos({
    super.key,
    required this.favoritos,
    required this.onFavorito,
    required this.onAbrirReceita,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Favoritos',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color(0xFF245B49),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Receitas salvas nesta sessão.',
            style: TextStyle(
              color: Color(0xFF617067),
            ),
          ),

          const SizedBox(height: 24),

          if (favoritos.isEmpty)
            estadoVazio(context)
          else
            ...favoritos.map(
                  (receita) => Padding(
                padding: const EdgeInsets.only(bottom: 14),
                child: CartaoReceita(
                  receita: receita,
                  favorito: true,
                  onTap: () => onAbrirReceita(receita),
                  onFavorito: () => onFavorito(receita),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget estadoVazio(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 80),

        Container(
          width: 110,
          height: 110,
          decoration: const BoxDecoration(
            color: Color(0xFFE7EEE7),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.favorite_border,
            size: 44,
            color: Color(0xFF245B49),
          ),
        ),

        const SizedBox(height: 24),

        const Text(
          'Nenhum favorito',
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF245B49),
          ),
        ),

        const SizedBox(height: 16),

        const Text(
          'Marque uma receita como favorita para encontrá-la aqui.',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Color(0xFF617067),
          ),
        ),

        const SizedBox(height: 40),

        SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF245B49),
              foregroundColor: Colors.white,
            ),
            child: const Text('Explorar receitas'),
          ),
        ),
      ],
    );
  }
}
