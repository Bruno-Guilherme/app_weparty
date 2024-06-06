import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:weparty/components/inicio/categorias/buffet.dart';
import 'package:weparty/components/inicio/categorias/cerimonial.dart';
import 'package:weparty/components/inicio/categorias/decoracao.dart';
import 'package:weparty/components/inicio/categorias/personalizados.dart';
import 'package:weparty/components/inicio/categorias/vermais.dart';

import 'package:weparty/main.dart';
import '../../pesquisar/store_page/store_page.dart'; // Certifique-se de ajustar o caminho conforme necessário

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Placeholder for main banner
            const BannerFull(),
            const SizedBox(height: 32),
            const Text(
              'Categorias',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Category placeholders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryPlaceholder(
                  context,
                  'Decoração',
                  'assets/images/categorias/cat01.png',
                  CategoriaDecoracao(),
                ),
                const SizedBox(width: 8),
                _buildCategoryPlaceholder(
                  context,
                  'Personalizados',
                  'assets/images/categorias/cat02.png',
                  CategoriaPersonalizados(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildCategoryPlaceholder(
                  context,
                  'Buffet',
                  'assets/images/categorias/cat05.png',
                  CategoriaBuffet(),
                ),
                const SizedBox(width: 8),
                _buildCategoryPlaceholder(
                  context,
                  'Cerimonial',
                  'assets/images/categorias/cat06.png',
                  CategoriaCerimonial(),
                ),
                const SizedBox(width: 8),
                _buildCategoryPlaceholder(
                  context,
                  'Ver mais',
                  'assets/images/categorias/cat01.png',
                  CategoriaOutros(),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Os mais próximos de você',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            // Nearby placeholders
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                for (var loja in appState.todasAsLojas.entries.take(4))
                  _buildNearbyPlaceholder(context, loja.key, loja.value),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryPlaceholder(
    BuildContext context,
    String text,
    String imageUrl,
    Widget page, // Adicionando o parâmetro da página
  ) {
    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNearbyPlaceholder(
      BuildContext context, String storeName, Map<String, dynamic> storeData) {
    String imageUrl = storeData['imagemUrl'] ?? 'assets/images/default.png';
    //List<Map<String, dynamic>> storeProducts = storeData['produtos'];

    return Expanded(
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SellerPage(
                        storeName: storeName,
                        storeData: storeData,
                      )));
        },
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
              image: AssetImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}

class BannerFull extends StatefulWidget {
  const BannerFull({
    super.key,
  });

  @override
  State<BannerFull> createState() => _BannerState();
}

class _BannerState extends State<BannerFull> {
  final controller = BannerItems();
  final bannerController = PageController();

  @override
  void dispose() {
    bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 4,
          child: PageView.builder(
            controller: bannerController,
            itemCount: controller.items.length,
            itemBuilder: (context, index) {
              return controller.items[index];
            },
          ),
        ),
        const SizedBox(height: 16),
        SmoothPageIndicator(
          controller: bannerController,
          count: controller.items.length,
          onDotClicked: (index) => bannerController.animateToPage(
            index,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeIn,
          ),
          effect: const WormEffect(
              dotHeight: 12, dotWidth: 12, activeDotColor: Colors.redAccent),
        ),
      ],
    );
  }
}

class BannerItems {
  List items = [
    Container(
      height: 150,
      decoration: BoxDecoration(
        color: Color.fromARGB(235, 67, 40, 218),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/images/banner/banner01.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 9, 172, 23),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/images/banner/banner02.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
    Container(
      height: 150,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 158, 3, 3),
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage('assets/images/banner/banner03.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  ];
}
