import 'package:flutter/material.dart';
import 'package:weparty/components/navigation/buttons.dart';
import 'package:weparty/components/navigation/pages.dart';

class NavigationBottomBar extends StatefulWidget {
  final dados;
  const NavigationBottomBar({super.key, required this.dados});

  @override
  State<NavigationBottomBar> createState() => _NavigationBottomBarState();
}

class _NavigationBottomBarState extends State<NavigationBottomBar> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
          child: getPages(theme, context, widget.dados)[currentPageIndex]),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.deepOrange,
        selectedIndex: currentPageIndex,
        destinations: getButtons(),
      ),
    );
  }
}
