import 'dart:convert';
import 'package:http/http.dart' as http;

// Resposta da API
class RespostaReceitas {
  final List receitas;
  final String? erro;

  RespostaReceitas(this.receitas, this.erro);
}

// Buscar receitas na API
Future<RespostaReceitas> buscarReceitas() async {
  try {
    final resposta = await http.get(
      Uri.parse('https://dummyjson.com/recipes'),
    );

    if (resposta.statusCode != 200) {
      return RespostaReceitas(
        [],
        'Erro ao buscar as receitas (código ${resposta.statusCode}).',
      );
    }

    final dados = jsonDecode(resposta.body);
    final lista = dados['recipes'];

    if (lista == null || lista.isEmpty) {
      return RespostaReceitas(
        [],
        'Nenhuma receita encontrada.',
      );
    }

    return RespostaReceitas(lista, null);

  } catch (e) {
    return RespostaReceitas(
      [],
      'Não foi possível conectar. Verifique sua conexão.',
    );
  }
}
