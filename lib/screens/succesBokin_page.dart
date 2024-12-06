import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../components/butomLogin.dart';

class SuccesbokinPage extends StatelessWidget {
  const SuccesbokinPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Lottie.asset('assets/success.json'),
          ),
          Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: const Text(
              'Agendado com Sucesso',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            child: Butomlogin(
                width: double.infinity,
                title: 'voltar, homepage',
                onPressed: () => Navigator.of(context).pushNamed('main'),
                disable: false),
          )
        ],
      )),
    );
  }
}
