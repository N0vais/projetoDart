import 'package:barbearia_lord_app/provider/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main.dart';
import '../models/model_autentication.dart';
import '../utils/config.dart';
import 'butomLogin.dart';

class CadastroForm extends StatefulWidget {
  const CadastroForm({super.key});

  @override
  State<CadastroForm> createState() => _CadastroFormState();
}

class _CadastroFormState extends State<CadastroForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  bool obsecurePass = true;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Nome',
              labelText: 'Nome',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.person_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            cursorColor: Config.primaryColor,
            decoration: const InputDecoration(
              hintText: 'Email Address',
              labelText: 'Email',
              alignLabelWithHint: true,
              prefixIcon: Icon(Icons.email_outlined),
              prefixIconColor: Config.primaryColor,
            ),
          ),
          Config.spaceSmall,
          TextFormField(
            controller: _passController,
            keyboardType: TextInputType.visiblePassword,
            cursorColor: Config.primaryColor,
            obscureText: obsecurePass,
            decoration: InputDecoration(
                hintText: 'Password',
                labelText: 'Password',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.lock_outline),
                prefixIconColor: Config.primaryColor,
                suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        obsecurePass = !obsecurePass;
                      });
                    },
                    icon: obsecurePass
                        ? const Icon(
                            Icons.visibility_off_outlined,
                            color: Colors.black87,
                          )
                        : const Icon(
                            Icons.visibility_outlined,
                            color: Config.primaryColor,
                          ))),
          ),
          Config.spaceSmall,
          Consumer<ModelAutentication>(
            builder: (context, valor, child) {
              return Butomlogin(
                width: double.infinity,
                title: 'Cadastrar',
                onPressed: () async {
                  try {
                    final userRegister = await DioProvider()
                        .registerUser(_nameController.text, _emailController.text, _passController.text);

                    if(userRegister == true) {
                      try {
                        final token = await DioProvider()
                            .getToken(_emailController.text, _passController.text);

                        if (token != null) { // Verifique se o token não é nulo
                          valor.loginSuccess();
                          MyApp.navigatorKey.currentState!.pushNamed('main');
                        } else {
                          print('Falha ao obter token');
                        }
                      } catch (e) {
                        print('Erro ao obter token: $e');
                      }
                    } else {
                      print('Não foi registrado');
                    }
                  } catch (e) {
                    print('Erro ao registrar usuário: $e');
                  }
                },

                disable: false,
              );
            },
          ),
        ],
      ),
    );
  }
}
