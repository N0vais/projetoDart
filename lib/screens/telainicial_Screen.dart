import 'package:flutter/material.dart';

import 'authentication.dart';

class TelaPrincipalScreen extends StatefulWidget {
  const TelaPrincipalScreen({super.key});

  @override
  State<TelaPrincipalScreen> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipalScreen> {
  final ScrollController controller = ScrollController();
  int index = 0;
  bool isReverse = false;
  bool isHovering = false;
  bool isClicked = false;

  // Lista de URLs das imagens
  List<String> imgUrl = [
    "https://th.bing.com/th/id/R.be33406513127ab0615f95914188e762?rik=ECKQ14B%2fFgbqvA&riu=http%3a%2f%2fwww.estudioroxo.com.br%2fwp-content%2fuploads%2fpost-blog-estudio-roxo-o-sucesso-das-barbearias-4-4-2.jpg&ehk=poRRwHds7RIOKIBDzxMIVmgBbvXAg6PzruuYeycVAQk%3d&risl=&pid=ImgRaw&r=0",
    "https://img.pikbest.com/png-images/20240906/barbers-hairdresser-cutting-hair-cartoon-illustration-_10808678.png!f305cw",
    "https://media.gettyimages.com/id/165767509/pt/vetorial/mulher-barber.jpg?s=612x612&w=gi&k=20&c=HKFSBQqBDLTLgmVd5RAVQRg1FELWqw6anBZD9c8rmCE=",
  ];

  @override
  void initState() {
    super.initState();
    startCarousel();
  }

  void startCarousel() {
    Future.delayed(const Duration(seconds: 5), () {
      if (controller.hasClients) {
        if (index == imgUrl.length - 1) {
          setState(() {
            index = 0;
            controller.jumpTo(0); // Volta para a primeira imagem
          });
        } else {
          setState(() {
            index++;
            controller.animateTo(MediaQuery.of(context).size.width * index,
                duration: const Duration(seconds: 1), curve: Curves.easeIn);
          });
        }
      }
      startCarousel(); // Chama a funçao para continuar o loop
    });
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SingleChildScrollView(
            reverse: isReverse,
            controller: controller,
            scrollDirection: Axis.horizontal,
            child: Row(
              children: imgUrl
                  .map((e) => BannerImages(
                height: height,
                width: width,
                image: e,
              ))
                  .toList(),
            ),
          ),
          // Barra de progresso do carrossel
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(imgUrl.length, (i) {
              return AnimatedContainer(
                duration: const Duration(seconds: 2),
                curve: Curves.easeIn,
                height: 5,
                width: 30,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(0),
                  color: index == i
                      ? const Color(0xffffffff).withOpacity(0.8)
                      : Colors.grey.withOpacity(0.8),
                ),
              );
            }),
          ),
          const Text(
            "O profissional que você busca",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 26,
                fontWeight: FontWeight.normal),
          ),
          const Text(
            "Escolha um estilo,\nTudo para o seu visual",
            style: TextStyle(
                color: Colors.grey,
                fontSize: 20,
                fontWeight: FontWeight.normal),
          ),
          MouseRegion(
            onEnter: (_) {
              setState(() {
                isHovering = true;
              });
            },
            onExit: (_) {
              setState(() {
                isHovering = false;
              });
            },
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isClicked = !isClicked;
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) =>AutenticationPage() ),
                );
              },
              // Configuração do botão da tela principal
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: 30),
                height:  50,
                width:  250,
                decoration: BoxDecoration(
                  border: const Border(
                      top: BorderSide(),
                      bottom: BorderSide(),
                      left: BorderSide(),
                      right: BorderSide()),
                  borderRadius: BorderRadius.circular(0),
                  color: isClicked ? const Color(0xffadabad).withOpacity(0.7) : const Color(0xff721c85),
                  gradient: const LinearGradient(
                    colors: [
                      // Cor do botão
                      Color(0xffaeacae),
                      Color.fromARGB(255, 100, 103, 169),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    if (isHovering)
                      BoxShadow(
                        color: Colors.blueAccent.withOpacity(0.5),
                        blurRadius: 5.0,
                        offset: const Offset(0, 8),
                      ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Bora lá !!!",
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class BannerImages extends StatelessWidget {
  final String image;
  const BannerImages({
    super.key,
    required this.image,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.5 * (height / 3),
      width: width,
      child: Image.network(
        image,
        fit: BoxFit.cover,
      ),
    );
  }
}
