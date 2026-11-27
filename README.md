# Receitas de Vó 

## Descrição

O Receitas de Vó é um aplicativo desenvolvido em Flutter que permite aos usuários explorar receitas culinárias, visualizar seus ingredientes e instruções de preparo, pesquisar receitas e salvar suas favoritas.

As receitas são obtidas por meio da API [DummyJSON](https://dummyjson.com/recipes).

## Funcionalidades

- **Explorar receitas:** visualizar uma lista de receitas disponíveis.
- **Pesquisar receitas:** buscar receitas pelo nome.
- **Detalhes da receita:** visualizar imagem, ingredientes, tempo de preparo, dificuldade e instruções.
- **Favoritos:** adicionar e remover receitas da lista de favoritas.
- **Carregamento e erros:** apresentar mensagens durante o carregamento e permitir tentar novamente caso ocorra uma falha na conexão com a API.

## Tecnologias e dependências

- **Flutter:** framework utilizado para o desenvolvimento do aplicativo.
- **Dart:** linguagem de programação utilizada.
- **HTTP:** dependência utilizada para realizar requisições à API.
- **DummyJSON API:** serviço utilizado para obter os dados das receitas.

## SDK utilizado

- Flutter SDK: versão instalada no ambiente de desenvolvimento.
- Dart SDK: versão compatível com o Flutter utilizado.

## Como executar o projeto

### Pré-requisitos

- Flutter SDK instalado.
- Android Studio instalado.
- Emulador Android ou dispositivo físico configurado.
- Conexão com a internet.

### Passos para execução

1. Clone o repositório ou faça o download do projeto.
2. Abra a pasta do projeto no Android Studio.
3. Abra o terminal na raiz do projeto.
4. Execute o comando para instalar as dependências:

```bash
flutter pub get
```

5. Verifique se o Flutter está configurado corretamente:

```bash
flutter doctor
```

6. Inicie um emulador Android ou conecte um dispositivo físico.
7. Execute o aplicativo:

```bash
flutter run
```

## Estrutura do projeto

```text
lib/
├── main.dart
├── models/
│   └── receitas.dart
├── services/
│   └── receitas_api.dart
├── telas/
│   ├── tela_detalhes.dart
│   ├── tela_favoritos.dart
│   └── tela_pesquisa.dart
└── widgets/
    ├── cartao_receita.dart
    └── estados_receitas.dart
```

## API utilizada

Os dados das receitas são obtidos por meio da DummyJSON:

https://dummyjson.com/recipes