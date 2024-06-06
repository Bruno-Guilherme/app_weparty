import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

// AIzaSyD7WErquuINWhYjDOPMm88TZJJCs_dW_Vk
import 'package:weparty/components/inicio/onboarding/onboarding_view.dart';

import 'components/pesquisar/store_page/store_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const keyApplicationId = 'NdRhReEWkw5qlw1rLVZ0q0ob0HE8TmMI06klzPt3';
  const keyClientKey = '7PramkwCgKCCN3jJhHHRzCYpyLYKWKEY6XUOOGpr';
  const keyParseServerUrl = 'https://parseapi.back4app.com/parse';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'WeParty',
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
                seedColor: const Color.fromRGBO(255, 82, 82, 1)),
          ),
          home: const SafeArea(child: OnboardingView())),
      //home: const SafeArea(child: onboarding()),
    );
  }
}

class MyAppState extends ChangeNotifier {
  // Lojas
  Map<String, Map<String, dynamic>> todasAsLojas = {
    'Loja A': {
      'imagemUrl': 'assets/images/lojas/loja_01.png',
      'categoria': 'Personalizados',
      'produtos': [
        {
          'nome': 'Produto A1',
          'valor': 50.0,
          'imagem': 'assets/images/lojas/loja_01.png',
          'descricao': 'Descrição do Produto A1',
        },
        {
          'nome': 'Produto A2',
          'valor': 70.0,
          'imagem': 'assets/images/lojas/loja_02.png',
          'descricao': 'Descrição do Produto A2',
        },
      ],
    },
    'Loja B': {
      'imagemUrl': 'assets/images/lojas/loja_02.png',
      'categoria': 'Buffet',
      'produtos': [
        {
          'nome': 'Produto B1',
          'valor': 45.0,
          'imagem': 'assets/images/lojas/loja_03.png',
          'descricao': 'Descrição do Produto B1',
        },
        {
          'nome': 'Produto B2',
          'valor': 65.0,
          'imagem': 'assets/images/lojas/loja_04.png',
          'descricao': 'Descrição do Produto B2',
        },
      ],
    },
    'Loja C': {
      'imagemUrl': 'assets/images/lojas/loja_03.png',
      'categoria': 'Decoração',
      'produtos': [
        {
          'nome': 'Produto C1',
          'valor': 55.0,
          'imagem': 'assets/images/lojas/loja_01.png',
          'descricao': 'Descrição do Produto C1',
        },
        {
          'nome': 'Produto C2',
          'valor': 75.0,
          'imagem': 'assets/images/lojas/loja_02.png',
          'descricao': 'Descrição do Produto C2',
        },
      ],
    },
    'Loja D': {
      'imagemUrl': 'assets/images/lojas/loja_04.png',
      'categoria': 'Cerimonial',
      'produtos': [
        {
          'nome': 'Produto D1',
          'valor': 60.0,
          'imagem': 'assets/images/lojas/loja_03.png',
          'descricao': 'Descrição do Produto D1',
        },
        {
          'nome': 'Produto D2',
          'valor': 80.0,
          'imagem': 'assets/images/lojas/loja_04.png',
          'descricao': 'Descrição do Produto D2',
        },
      ],
    },
    'Loja E': {
      'imagemUrl': 'assets/images/lojas/loja_01.png',
      'categoria': 'Outros',
      'produtos': [
        {
          'nome': 'Produto E1',
          'valor': 40.0,
          'imagem': 'assets/images/lojas/loja_01.png',
          'descricao': 'Descrição do Produto E1',
        },
        {
          'nome': 'Produto E2',
          'valor': 60.0,
          'imagem': 'assets/images/lojas/loja_02.png',
          'descricao': 'Descrição do Produto E2',
        },
      ],
    },
  };

  void adicionarProduto(
      BuildContext context, String loja, Map<String, dynamic> novoProduto) {
    if (todasAsLojas.containsKey(loja)) {
      todasAsLojas[loja]!['produtos'].add(novoProduto);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Produto adicionado à $loja')),
      );
    } else {
      todasAsLojas[loja] = {
        'imagemUrl': 'assets/images/lojas/nova_loja.png',
        'produtos': [novoProduto],
      };
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loja $loja criada e produto adicionado')),
      );
    }

    notifyListeners();
  }

  void removerProduto(BuildContext context, String loja, String nomeProduto) {
    if (todasAsLojas.containsKey(loja)) {
      int tamanhoAnterior = todasAsLojas[loja]!['produtos'].length;
      todasAsLojas[loja]!['produtos']
          .removeWhere((produto) => produto['nome'] == nomeProduto);
      int tamanhoAtual = todasAsLojas[loja]!['produtos'].length;

      if (tamanhoAnterior > tamanhoAtual) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Produto $nomeProduto removido de $loja')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Produto $nomeProduto não encontrado em $loja')),
        );
      }

      // Remove a chave da loja se a lista de produtos estiver vazia.
      if (todasAsLojas[loja]!['produtos'].isEmpty) {
        todasAsLojas.remove(loja);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Loja $loja removida por estar vazia')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loja $loja não encontrada')),
      );
    }

    notifyListeners();
  }

  // Carrinho
  Map<String, Map<String, dynamic>> itensCarrinho = {
    /*'Produto A1': {
      'nome': 'Produto A1',
      'valor': 50.0,
      'imagem': 'assets/images/lojas/loja_01.png',
      'descricao': 'Descrição do Produto A1',
      'quantidade': 1,
    },
    'Produto B1': {
      'nome': 'Produto B1',
      'valor': 45.0,
      'imagem': 'assets/images/lojas/loja_02.png',
      'descricao': 'Descrição do Produto B1',
      'quantidade': 1,
    },
    'Produto C1': {
      'nome': 'Produto C1',
      'valor': 55.0,
      'imagem': 'assets/images/lojas/loja_03.png',
      'descricao': 'Descrição do Produto C1',
      'quantidade': 1,
    },
    'Produto D1': {
      'nome': 'Produto D1',
      'valor': 60.0,
      'imagem': 'assets/images/lojas/loja_04.png',
      'descricao': 'Descrição do Produto D1',
      'quantidade': 1,
    },
    'Produto A2': {
      'nome': 'Produto A2',
      'valor': 70.0,
      'imagem': 'assets/images/lojas/loja_01.png',
      'descricao': 'Descrição do Produto A2',
      'quantidade': 1,
    },*/
  };

  void adicionarProdutoCarrinho(
      BuildContext context, String nomeProduto, Map<String, dynamic> produto) {
    if (itensCarrinho.containsKey(nomeProduto)) {
      itensCarrinho[nomeProduto]!['quantidade'] += 1;
    } else {
      produto['quantidade'] = 1;
      itensCarrinho[nomeProduto] = produto;
    }

    notifyListeners();
  }

  void removerProdutoCarrinho(BuildContext context, String produtoNome) {
    itensCarrinho.remove(produtoNome);
    notifyListeners();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Produto removido do carrinho!')),
    );
  }

  void limparCarrinho() {
    itensCarrinho.clear();
    notifyListeners();
  }

  void diminuirQuantidadeProduto(BuildContext context, String key) {
    if (itensCarrinho.containsKey(key)) {
      itensCarrinho[key]!['quantidade'] -= 1;
      if (itensCarrinho[key]!['quantidade'] <= 0) {
        itensCarrinho.remove(key);
      }
    }
    notifyListeners();
  }

  // Lojas Favoritas
  Map<String, Map<String, dynamic>> lojasFavoritas = {};

  void adicionarAosFavoritos(
      BuildContext context, String loja, Map<String, dynamic> lojaInfo) {
    if (!lojasFavoritas.containsKey(loja)) {
      lojasFavoritas[loja] = lojaInfo;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loja $loja adicionada aos favoritos')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loja $loja já está nos favoritos')),
      );
    }
    notifyListeners();
  }

  void removerDosFavoritos(BuildContext context, String loja) {
    if (lojasFavoritas.containsKey(loja)) {
      lojasFavoritas.remove(loja);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loja $loja removida dos favoritos')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Loja $loja não está nos favoritos')),
      );
    }
    notifyListeners();
  }
}
