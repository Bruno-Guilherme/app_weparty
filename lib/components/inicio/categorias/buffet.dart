import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weparty/components/pesquisar/store_page/store_page.dart';
import 'package:weparty/main.dart';

class CategoriaBuffet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var todasAsLojas = appState.todasAsLojas;
    List<String> lojasBuffet = todasAsLojas.entries
        .where((entry) => entry.value['categoria'] == 'Buffet')
        .map((entry) => entry.key)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Buffet'),
      ),
      body: ListView.builder(
        itemCount: lojasBuffet.length,
        itemBuilder: (context, index) {
          String nomeLoja = lojasBuffet[index];
          Map<String, dynamic> dadosLoja = todasAsLojas[nomeLoja]!;
          return ListTile(
            leading: Image.asset(dadosLoja['imagemUrl']),
            title: Text(nomeLoja),
            subtitle: Text(dadosLoja['produtos']
                .map((produto) => produto['nome'])
                .join(', ')),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SellerPage(
                    storeName: nomeLoja,
                    storeData: dadosLoja,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
