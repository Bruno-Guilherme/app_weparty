import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weparty/components/inicio/onboarding/onboarding_items.dart';
import 'package:weparty/components/inicio/singIn/entrar.dart';
import 'package:weparty/components/inicio/singIn/singin.dart';

/// ARQUIVO DE DESENVOLVIMENTO DO ONBOARDIN PAGE.

class OnboardingView extends StatefulWidget {
  /// Classe com estado para maniuplação de dados dinâmicos.
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems(); // Itens que irão ser montados
  final pageController = PageController(); // Controle da página
  bool isLastPage = false; // Verifica se está na última página

  @override
  void dispose() {
    // Limpeza de memória
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: controller.items.isEmpty
            ? const Center(child: Text("Nenhum item de onboarding encontrado"))
            : PageView.builder(
                onPageChanged: (index) => setState(
                    () => isLastPage = controller.items.length - 1 == index),
                itemCount: controller.items.length,
                controller: pageController,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Imagem
                      SvgPicture.asset(controller.items[index].image),
                      const SizedBox(
                        height: 15,
                      ),
                      // Título
                      Text(
                        controller.items[index].titulo,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 15,
                      ),

                      // Descrição
                      Text(
                        controller.items[index].descricao,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                }),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        child: isLastPage
            ? getStarted()
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => pageController.jumpToPage(
                      controller.items.length - 1,
                    ),
                    child: const Text("Pular"),
                  ),
                  SmoothPageIndicator(
                    controller: pageController,
                    count: controller.items.length,
                    onDotClicked: (index) => pageController.animateToPage(
                      index,
                      duration: const Duration(milliseconds: 600),
                      curve: Curves.easeIn,
                    ),
                    effect: const WormEffect(
                        dotHeight: 12,
                        dotWidth: 12,
                        activeDotColor: Colors.redAccent),
                  ),
                  TextButton(
                      onPressed: () => pageController.nextPage(
                          duration: const Duration(milliseconds: 600),
                          curve: Curves.easeIn),
                      child: const Text("Próximo")),
                ],
              ),
      ),
    );
  }

  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: Colors.red),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
        onPressed: () async {
          try {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setBool("onboarding", true);

            if (!mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const MyCustomForm()),
            );
          } catch (e) {
            print("Erro ao salvar preferências ou navegar: $e");
          }
        },
        child: const Text("Iniciar", style: TextStyle(color: Colors.black)),
      ),
    );
  }
}
