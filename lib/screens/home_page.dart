import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/card_agenda.dart';
import '../components/card_agendamento.dart';
import '../components/card_barbeiro.dart';
import '../provider/dio_provider.dart';
import '../utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> user = {};
  Map<String, dynamic> barbeiro = {};

  List<Map<String, dynamic>> estilos = [
    {
      "icon": FontAwesomeIcons.usersViewfinder,
      "category": "Barba",
    },
    {
      "icon": FontAwesomeIcons.userCheck,
      "category": "Corte Social",
    },
    {
      "icon": FontAwesomeIcons.crosshairs,
      "category": "Corte Modelo",
    },
    {
      "icon": FontAwesomeIcons.person,
      "category": "Cortes Longos",
    },
    {
      "icon": FontAwesomeIcons.personBooth,
      "category": "Depilador(a)",
    },
  ];

  Future<void> getData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    if (token.isNotEmpty) {
      final response = await DioProvider().getUser(token);
      if (response != null) {
        setState(() {
          user = json.decode(response) as Map<String, dynamic>;
          //print(user);

          for (var barberData in user ['barbeiro']){
            if(barberData ['appointments'] != null){
              barbeiro = barberData;
            }
          }
        });
      }
    }
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: user.isEmpty
      ? const Center(
        child: CircularProgressIndicator(),
      )
      : Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      user['name']?? '...',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      child: CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage('https://thumbs.dreamstime.com/z/desenhos-animados-do-barbeiro-84283111.jpg'),
                      ),
                    ),
                  ],
                ),
                Config.spaceMedian,
                const Text(
                  'Categoria',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                SizedBox(
                  height: Config.heightSize * 0.05,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List<Widget>.generate(estilos.length, (index) {
                      return Card(
                        margin: const EdgeInsets.only(right: 20),
                        color: Colors.blueGrey.shade700,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              FaIcon(
                                estilos[index]['icon'],
                                color: Colors.grey.shade200,
                              ),
                              const SizedBox(width: 20),
                              Text(
                                estilos[index]['category'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                Config.spaceSmall,
                const Text(
                  'Agendamento',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                barbeiro.isNotEmpty
                ? CardAgendamento(barbeiro: barbeiro,
                  color: Config.primaryColor,)
                : Container(
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                  ),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        'Nao tem agendamentos para hoje!!!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                Config.spaceSmall,
                const Text(
                  'Barbeiros Lord',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Config.spaceSmall,
                Column(
                  children: List.generate(user['barbeiro'].length, (index) {
                    return CardBarbeiro(
                        route: 'detalhe_barber',
                        barbeiro: user['barbeiro'][index],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
