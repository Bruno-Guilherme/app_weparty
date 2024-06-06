import 'package:flutter/material.dart';
import 'package:weparty/components/conta/favoritos/favoritos.dart';
import 'package:weparty/components/inicio/onboarding/onboarding_view.dart';

class Perfil extends StatelessWidget {
  final dados;
  const Perfil({
    super.key,
    required this.dados,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey[300],
            backgroundImage:
                const AssetImage('assets/images/perfil/profile_avatar.png')),
        const SizedBox(height: 10),
        Text(
          dados[0]['nome'],
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        /*ListTile(
          leading: const Icon(Icons.person),
          title: const Text('Dados da conta'),
          subtitle: const Text('Minhas informações da conta'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Implementar navegação para Dados da conta
          },
        ),*/
        const Divider(),
        ListTile(
          leading: const Icon(Icons.favorite),
          title: const Text('Favoritos'),
          subtitle: const Text('Meus fornecedores favoritos'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FavoritosPage(),
              ),
            );
          },
        ),
        const Divider(),
        /*
        ListTile(
          leading: const Icon(Icons.history),
          title: const Text('Histórico de Pedidos'),
          subtitle: const Text('Histórico de pedidos já feitos'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            // Implementar navegação para Histórico de Pedidos
          },
        ),
        const Divider(),
        */
        ListTile(
          leading: const Icon(Icons.exit_to_app),
          title: const Text('Sair'),
          subtitle: const Text('Sair da conta'),
          trailing: const Icon(Icons.arrow_forward_ios),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SafeArea(child: OnboardingView()),
              ),
            );
          },
        ),
        const Divider(),
      ],
    );
  }
}
