import 'package:flutter/material.dart';
import 'package:weparty/components/pesquisar/store_page/store_page.dart';
import 'package:provider/provider.dart';
import 'package:weparty/main.dart';

class BuscarPage extends StatelessWidget {
  final Map<String, Map<String, dynamic>> todasAsLojas;

  const BuscarPage({Key? key, required this.todasAsLojas}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar Lojas'),
      ),
      body: Buscar(todasAsLojas: todasAsLojas),
    );
  }
}

class Buscar extends StatefulWidget {
  final Map<String, Map<String, dynamic>> todasAsLojas;

  const Buscar({Key? key, required this.todasAsLojas}) : super(key: key);

  @override
  _BuscarState createState() => _BuscarState();
}

class _BuscarState extends State<Buscar> {
  List<String> lojasFiltradas = [];

  @override
  void initState() {
    super.initState();
    lojasFiltradas = widget.todasAsLojas.keys.toList();
  }

  void filtrarLojas(String filtro) {
    setState(() {
      if (filtro.isEmpty) {
        lojasFiltradas = widget.todasAsLojas.keys.toList();
      } else {
        lojasFiltradas = widget.todasAsLojas.keys
            .where((nomeLoja) =>
                nomeLoja.toLowerCase().contains(filtro.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: filtrarLojas,
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              hintText: 'Buscar em todas as lojas',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Os mais buscados perto de você',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: lojasFiltradas.length,
            itemBuilder: (context, index) {
              String nomeLoja = lojasFiltradas[index];
              Map<String, dynamic> storeData = widget.todasAsLojas[nomeLoja]!;

              bool isFavorited = appState.lojasFavoritas.containsKey(nomeLoja);

              return Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(storeData['imagemUrl']),
                      backgroundColor: Colors.grey[300],
                    ),
                    title: Text(nomeLoja),
                    subtitle: Row(
                      children: const [
                        Icon(Icons.star, color: Colors.red, size: 16),
                        Icon(Icons.star, color: Colors.red, size: 16),
                        Icon(Icons.star, color: Colors.red, size: 16),
                        Icon(Icons.star, color: Colors.red, size: 16),
                        Icon(Icons.star_half, color: Colors.red, size: 16),
                      ],
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        isFavorited ? Icons.favorite : Icons.favorite_border,
                        color: isFavorited ? Colors.red : null,
                      ),
                      onPressed: () {
                        if (isFavorited) {
                          appState.removerDosFavoritos(context, nomeLoja);
                        } else {
                          appState.adicionarAosFavoritos(
                              context, nomeLoja, storeData);
                        }
                      },
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SellerPage(
                            storeName: nomeLoja,
                            storeData: storeData,
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
