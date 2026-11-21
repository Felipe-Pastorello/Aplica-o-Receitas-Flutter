
import 'package:flutter/material.dart';
import '../models/receitas.dart';

class CartaoReceita extends StatelessWidget {
  final Receitas receita;
  final bool favorito;
  final VoidCallback onTap;
  final VoidCallback onFavorito;

  const CartaoReceita({
    super.key,
    required this.receita,
    required this.favorito,
    required this.onTap,
    required this.onFavorito,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
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
            Container(
              width: 92,
              height: 110,
              decoration: BoxDecoration(
                color: const Color(0xFFEAE6D7),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Center(
                child: Text(
                  receita.imagem,
                  style: const TextStyle(fontSize: 48),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    receita.nome,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF245B49),
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    '${receita.tempo} • ${receita.dificuldade}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF617067),
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    '${receita.avaliacao} / 5',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF245B49),
                    ),
                  ),
                ],
              ),
            ),

            IconButton(
              onPressed: onFavorito,
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
    );
  }
}
