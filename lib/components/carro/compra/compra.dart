import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weparty/main.dart';

class PaginaCompra extends StatelessWidget {
  const PaginaCompra({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var itensCarrinho = appState.itensCarrinho;
    List<String> keys = appState.itensCarrinho.keys.toList();

    double calcularTotal() {
      double total = 0.0;
      itensCarrinho.forEach((key, item) {
        total += item['valor'] * item['quantidade'];
      });
      return total;
    }

    bool temItensNoCarrinho = itensCarrinho.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumo da Compra'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: itensCarrinho.length,
              itemBuilder: (context, index) {
                String key = keys[index];
                Map<String, dynamic> item = itensCarrinho[key]!;

                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(item['imagem']),
                    backgroundColor: Colors.grey[300],
                  ),
                  title: Text(key),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Descrição: ${item['descricao']}'),
                      Text('Quantidade: ${item['quantidade']}'),
                      Text('Valor unitário: R\$${item['valor']}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      appState.removerProdutoCarrinho(context, key);
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'Total: R\$${calcularTotal().toStringAsFixed(2)}',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: Colors.red,
                  ),
                  onPressed: temItensNoCarrinho
                      ? () {
                          appState.limparCarrinho();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content:
                                    Text('Compra finalizada com sucesso!')),
                          );
                          Navigator.pop(context);
                        }
                      : null, // Desabilita o botão quando não há itens no carrinho
                  child: const Text(
                    'Finalizar Compra',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
