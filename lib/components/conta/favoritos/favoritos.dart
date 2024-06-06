import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weparty/components/pesquisar/store_page/store_page.dart';
import 'package:weparty/main.dart';

class FavoritosPage extends StatelessWidget {
  const FavoritosPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var favoritos = appState.lojasFavoritas;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Favoritos'),
      ),
      body: ListView.builder(
        itemCount: favoritos.length,
        itemBuilder: (context, index) {
          var storeName = favoritos.keys.elementAt(index);
          var storeData = favoritos[storeName]!;

          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(storeData['imagemUrl']),
            ),
            title: Text(storeName),
            subtitle: Text(storeData['categoria']),
            trailing: IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                appState.removerDosFavoritos(context, storeName);
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SellerPage(
                    storeName: storeName,
                    storeData: storeData,
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
