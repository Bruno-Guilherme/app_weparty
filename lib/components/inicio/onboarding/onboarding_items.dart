import 'package:weparty/components/inicio/onboarding/onboarding_info.dart';

class OnboardingItems {
  /// Dados que serão montados a partir da estrutura de dados da classe info.

  List<OnboardingInfo> items = [
    OnboardingInfo(
        titulo: "Bem-vido ao WeParty!",
        descricao:
            "Conectamos você a fornecedores talentosos para transformar suas ideias em realidade",
        image: 'assets/images/onboarding/onboard1.svg'),
    OnboardingInfo(
        titulo: "Proporcionamos facilidade!",
        descricao: "Simplifique seu planejamento de eventos agora",
        image: 'assets/images/onboarding/onboard2.svg'),
    OnboardingInfo(
        titulo: "Encontre seus fornecedores!",
        descricao:
            "Explore perfis de fornecedores, veja avaliações e portfólios em apenas alguns cliques",
        image: 'assets/images/onboarding/onboard3.svg'),
  ];
}
