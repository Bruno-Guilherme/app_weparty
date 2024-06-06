import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weparty/main.dart';

class AddToCartPage extends StatefulWidget {
  final Map<String, dynamic> produto;

  const AddToCartPage({Key? key, required this.produto}) : super(key: key);

  @override
  _AddToCartPageState createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage> {
  int _quantidade = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar ao Carrinho'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.produto['nome'],
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Image.asset(widget.produto['imagem']),
            SizedBox(height: 8),
            Text(
              widget.produto['descricao'],
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'R\$ ${widget.produto['valor']}',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.green),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: () {
                    setState(() {
                      if (_quantidade > 1) {
                        _quantidade--;
                      }
                    });
                  },
                ),
                Text(
                  '$_quantidade',
                  style: TextStyle(fontSize: 20),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      _quantidade++;
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                for (int i = 0; i < _quantidade; i++) {
                  Provider.of<MyAppState>(context, listen: false)
                      .adicionarProdutoCarrinho(
                          context, widget.produto['nome'], widget.produto);
                }
                Navigator.pop(context, 'Produto adicionado ao carrinho!');
              },
              child: Text('Adicionar ao Carrinho'),
            ),
          ],
        ),
      ),
    );
  }
}
