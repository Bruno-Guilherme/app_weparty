import 'package:flutter/material.dart';
import 'package:weparty/components/carro/addCarrinho.dart';
import 'package:provider/provider.dart';
import 'package:weparty/main.dart';

class SellerPage extends StatelessWidget {
  final String storeName;
  final Map<String, dynamic> storeData;

  const SellerPage({
    Key? key,
    required this.storeName,
    required this.storeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.grey[200],
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Header(storeName: storeName, storeData: storeData),
            Produtos(storeData: storeData),
          ],
        ),
      ),
    );
  }
}

class Produtos extends StatelessWidget {
  final Map<String, dynamic> storeData;

  const Produtos({
    Key? key,
    required this.storeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> produtos = storeData['produtos'];

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 2.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Nossos produtos',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Column(
          children: List.generate(produtos.length, (index) {
            var produto = produtos[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    color: Colors.grey[300],
                    child: Center(
                      child: Image.asset(produto['imagem']),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          produto['nome'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          produto['descricao'],
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'R\$ ${produto['valor']}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddToCartPage(produto: produto),
                        ),
                      );
                    },
                    child: const Text('Adicionar'),
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}

class Header extends StatelessWidget {
  final String storeName;
  final Map<String, dynamic> storeData;

  const Header({
    Key? key,
    required this.storeName,
    required this.storeData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    bool isFavorited = appState.lojasFavoritas.containsKey(storeName);

    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.grey[300],
              backgroundImage: AssetImage(storeData['imagemUrl']),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storeName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text('Personalizados'),
                ],
              ),
            ),
            Column(
              children: [
                Row(
                  children: const [
                    Icon(Icons.star, color: Colors.red, size: 16),
                    Text('4,5 (500)'),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    if (isFavorited) {
                      appState.removerDosFavoritos(context, storeName);
                    } else {
                      appState.adicionarAosFavoritos(
                          context, storeName, storeData);
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
