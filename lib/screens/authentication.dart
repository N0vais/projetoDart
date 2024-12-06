
import 'package:barbearia_lord_app/components/cadastro_form.dart';
import 'package:flutter/material.dart';

import '../components/butomSocial.dart';
import '../components/form_login.dart';
import '../utils/config.dart';
import '../utils/text.dart';

class AutenticationPage extends StatefulWidget {
  const AutenticationPage({super.key});

  @override
  State<AutenticationPage> createState() => _AutenticationPage();
}

class _AutenticationPage extends State<AutenticationPage> {
  bool isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            reverse: true,
      child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 15,
      ),
      child: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              AppText.enText['welcome_text']!,
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            Config.spaceSmall,
            Text(
              isSignIn
                  ? AppText.enText['signIn_text']!
                  : AppText.enText['register_text']!,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            Config.spaceSmall,

            //adicionando o widget do formulario
            isSignIn ? const FormLogin() :
            const CadastroForm(),
            Config.spaceSmall,

            isSignIn ? Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  AppText.enText['forgot-password']!,
                  style: const TextStyle(
                    fontSize: 16,
                    //fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ) : Container(),

            const SizedBox(height: 20),
            Center(
              child: Text(
                AppText.enText['social-login']!,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                  color: Colors.white38,
                ),
              ),
            ),
            Config.spaceSmall,
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ButomSocial(social: 'google'),
                ButomSocial(social: 'facebook'),
              ],
            ),
            Config.spaceSmall,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  isSignIn
                      ? AppText.enText['signUp_text']!
                      : AppText.enText['registered_text']!,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      isSignIn = !isSignIn;
                    });
                  },
                  child: Text(
                    isSignIn ? 'Cadastrar' : 'Entrar',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                )
              ],
            )
          ],
        ),
                )
      )
      ),
    ));
  }
}
