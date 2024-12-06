
import 'package:barbearia_lord_app/screens/telainicial_Screen.dart';
import 'package:flutter/material.dart';


class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

class _IntroductionState extends State<Introduction> {
  bool animado = true;
  bool clicado = false;
  final width = 50;

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 1), (() {
      setState(() {
        animado = false;
      });
    }));
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: ((context) => const TelaPrincipalScreen())));
    });
    super.initState();
  }

  //fazendo a implementação do state build
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 150),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                AnimatedPadding(
                  padding: EdgeInsets.only(top: animado ? 40 : 30),
                  duration: const Duration(seconds: 5),
                  curve: Curves.easeInOutCubicEmphasized,
                  child: AnimatedOpacity(
                    opacity: animado ? 0 : 1,
                    duration: const Duration(seconds: 5),
                    curve: Curves.easeInCubic,
                    child: const CircleAvatar(
                      radius: 80,
                      foregroundImage: AssetImage(
                          "assets/image1.jpg"),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                AnimatedPadding(
                  padding: EdgeInsets.only(top: animado ? 40 : 30),
                  duration: const Duration(seconds: 5),
                  curve: Curves.easeInOutCubicEmphasized,
                  child: AnimatedOpacity(
                    opacity: animado ? 0 : 1,
                    duration: const Duration(seconds: 5),
                    curve: Curves.easeInCubic,
                    child: const Text(
                      "Lord Barber",
                      style: TextStyle(
                          color: Colors.white38,
                          fontSize: 40,
                          letterSpacing: 1.3,
                          fontStyle: FontStyle.normal,
                          fontWeight: FontWeight.w700),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
