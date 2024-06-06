import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weparty/components/carro/compra/compra.dart';
import 'package:weparty/main.dart';

class Carrinho extends StatelessWidget {
  const Carrinho({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var itensCarrinho = appState.itensCarrinho;
    List<String> keys = appState.itensCarrinho.keys.toList();

    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Itens adicionados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: itensCarrinho.length,
            itemBuilder: (context, index) {
              String key = keys[index];
              Map<String, dynamic> item = itensCarrinho[key]!;

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(item['imagem']),
                          backgroundColor: Colors.grey[300],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                key,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Descrição: ${item['descricao']}',
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              Text(
                                'Valor: R\$${item['valor']}',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            appState.removerProdutoCarrinho(context, key);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          color: Colors.red,
                          onPressed: () {
                            if (item['quantidade'] > 1) {
                              appState.diminuirQuantidadeProduto(context, key);
                            } else {
                              appState.removerProdutoCarrinho(context, key);
                            }
                          },
                        ),
                        Text('${item['quantidade']}'),
                        IconButton(
                          icon: const Icon(Icons.add),
                          color: Colors.red,
                          onPressed: () {
                            appState.adicionarProdutoCarrinho(
                                context, key, item);
                          },
                        ),
                      ],
                    ),
                    const Divider(),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const PaginaCompra()),
              );
            },
            child: const Text(
              'Comprar',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ],
    );
  }
}
