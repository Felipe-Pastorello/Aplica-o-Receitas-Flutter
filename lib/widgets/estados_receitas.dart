import 'package:flutter/material.dart';

class EstadoCarregamento extends StatelessWidget {
  const EstadoCarregamento({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: Color(0xFF245B49),
          ),
          SizedBox(height: 20),
          Text(
            'Carregando receitas...',
            style: TextStyle(
              color: Color(0xFF617067),
            ),
          ),
        ],
      ),
    );
  }
}

class EstadoErro extends StatelessWidget {
  final VoidCallback onTentarNovamente;

  const EstadoErro({
    super.key,
    required this.onTentarNovamente,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Color(0xFFE7EEE7),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.priority_high,
                size: 48,
                color: Color(0xFF245B49),
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Não foi possível carregar as receitas.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF245B49),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Verifique sua conexão e tente novamente.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF617067),
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: onTentarNovamente,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF245B49),
                  foregroundColor: Colors.white,
                ),
                child: const Text('Tentar novamente'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
