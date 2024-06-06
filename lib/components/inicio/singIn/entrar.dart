import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:weparty/components/inicio/cadastro/cadastro.dart';
import 'package:weparty/components/inicio/cadastro/singup.dart';
import 'package:weparty/components/inicio/recuperarSenha/recuperarSenha.dart';
import 'package:weparty/components/navigation/navigation.dart';

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({super.key});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  final myControllerUser = TextEditingController();
  final myControllerPassword = TextEditingController();

  @override
  void dispose() {
    myControllerUser.dispose();
    myControllerPassword.dispose();
    super.dispose();
  }

  void _loginUser() async {
    if (_formKey.currentState!.validate()) {
      final query = QueryBuilder<ParseObject>(ParseObject('Usuario'))
        ..whereEqualTo('email', myControllerUser.text)
        ..whereEqualTo('senha', myControllerPassword.text);

      final ParseResponse response = await query.query();

      if (response.success &&
          response.results != null &&
          response.results!.isNotEmpty) {
        print("Aqui");
        print(response.results);
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text('Login com sucesso')));
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  NavigationBottomBar(dados: response.results)),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Email ou senha inválido')));
      }
    }
  }

  void _goToSignUpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegistrationForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/images/logo/weparty_logo.svg'),
                const Text(
                  'WeParty',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: myControllerUser,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo vázio';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: TextFormField(
                    controller: myControllerPassword,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      labelText: 'Senha',
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo vázio';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Esqueceu sua senha? ',
                        style:
                            const TextStyle(color: Colors.black, fontSize: 10),
                        children: [
                          TextSpan(
                            text: 'Clique aqui!',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontSize: 10,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const ResetPasswordPage()),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _loginUser,
                  style: ElevatedButton.styleFrom(
                    minimumSize:
                        const Size(200, 50), // Largura e altura mínimas
                  ),
                  child: const Text(
                    'Entrar',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: _goToSignUpPage,
                      child: const Text('Cadastre-se'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
