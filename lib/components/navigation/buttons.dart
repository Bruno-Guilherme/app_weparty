import "package:flutter/material.dart";

List<Widget> getButtons() {
  return <Widget>[
    const NavigationDestination(
        icon: Icon(Icons.home_outlined),
        selectedIcon: Icon(Icons.home),
        label: 'Início'),
    const NavigationDestination(
      icon: Icon(Icons.search),
      label: 'Buscar',
    ),
    const NavigationDestination(
      icon: Icon(Icons.shopping_cart),
      label: 'Carrinho',
    ),
    const NavigationDestination(
      icon: Icon(Icons.person),
      label: 'Conta',
    ),
    /* NavigationDestination(
            icon: Badge(child: Icon(Icons.notifications_sharp)),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Icon(Icons.messenger_sharp),
            ),
            label: 'Messages',
          ), */
  ];
}
