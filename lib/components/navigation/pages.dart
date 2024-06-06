import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:weparty/components/carro/carrinho/cart.dart';
import 'package:weparty/components/inicio/home_page/home.dart';
import 'package:weparty/components/pesquisar/pesquisar.dart';
import 'package:weparty/components/conta/profile/profile.dart';
import 'package:weparty/main.dart';

List<Widget> getPages(ThemeData theme, BuildContext context, dados) {
  // Obter todas as lojas do Provider
  var todasAsLojas = Provider.of<MyAppState>(context).todasAsLojas;

  return <Widget>[
    const HomeScreen(),
    Buscar(todasAsLojas: todasAsLojas), // Passando os dados das lojas
    const Carrinho(),
    Perfil(
      dados: dados,
    ),
  ];
}
