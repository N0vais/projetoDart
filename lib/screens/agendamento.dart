
import 'dart:convert';

import 'package:barbearia_lord_app/provider/dio_provider.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/config.dart';

class AgendamentoPage extends StatefulWidget {
  const AgendamentoPage({super.key});

  @override
  State<AgendamentoPage> createState() => _AgendamentoPageState();
}

enum FilterStatus { proximo, complete, cancelar }

class _AgendamentoPageState extends State<AgendamentoPage> {
  FilterStatus status = FilterStatus.proximo;
  Alignment _alignment = Alignment.centerLeft;
  List<dynamic> schedules = [];

  Future<void> getAgenda() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final agendamento = await DioProvider().getAgenda(token);

    if (agendamento is String && agendamento == 'ERROR') {
      print('erro ao obter os dados');
    } else {
      try {
        //print('Dados recebidos: $agendamento');
        if(agendamento is List) {
          setState(() {
            schedules = agendamento;
            print(schedules);
          });
        }else{
          print( 'resposta inesperada');
        }
      } catch (e) {
        print('Erro ao decodificar JSON: $e');
      }
    }
  }

  @override
  void initState() {
    getAgenda();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Schedules: $schedules');
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      switch(schedule['status']){
        case 'upcoming':
          schedule['status']= FilterStatus.proximo;
        case 'complete':
          schedule['status']= FilterStatus.complete;
        case 'cancelar':
          schedule['status']= FilterStatus.cancelar;
      }
      return schedule['status'] == status;
    }).toList();

    print('Filtered Schedules: $filteredSchedules');

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const Text(
                'Agenda',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Config.spaceSmall,
              Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        for (FilterStatus filterStatus in FilterStatus.values)
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  if (filterStatus == FilterStatus.proximo) {
                                    status = FilterStatus.proximo;
                                    _alignment = Alignment.centerLeft;
                                  } else if (filterStatus == FilterStatus.complete) {
                                    status = FilterStatus.complete;
                                    _alignment = Alignment.center;
                                  } else if (filterStatus == FilterStatus.cancelar) {
                                    status = FilterStatus.cancelar;
                                    _alignment = Alignment.centerRight;
                                  }
                                });
                              },
                              child: Center(
                                child: Text(filterStatus.name),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  AnimatedAlign(
                    alignment: _alignment,
                    duration: const Duration(milliseconds: 200),
                    child: Container(
                      width: 110,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: Text(
                          status.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Config.spaceSmall,

              Expanded(
                child: ListView.builder(
                  itemCount: filteredSchedules.length,
                  itemBuilder: (context, index) {
                    var schedule = filteredSchedules[index];
                    bool isLastElement = filteredSchedules.length - 1 == index;
                    return Card(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      margin: !isLastElement
                          ? const EdgeInsets.only(bottom: 20)
                          : EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                  "http://192.168.15.91:8000${schedule['barbeiro_profile']}",
                                   ),
                                ),
                                const SizedBox(width: 10,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      schedule['barbeiro_name'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      schedule['category'] ?? '',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            CardAgendamento(date: schedule['date'], day: schedule['day'], time: schedule['time'],),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: OutlinedButton(
                                    onPressed: () {},
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(color: Config.primaryColor),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  child: OutlinedButton(
                                    style: OutlinedButton.styleFrom(
                                      backgroundColor: Config.primaryColor,
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      'Reschedule',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
class CardAgendamento extends StatelessWidget {
  const CardAgendamento({super.key, required this.date, required this.day, required this.time});

  final String date;
  final String day;
  final String time;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(0),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Config.primaryColor,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '$day, $date',
            style: const TextStyle(color: Config.primaryColor),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: Config.primaryColor,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
                time,
                style: const TextStyle(color: Config.primaryColor),
              ))
        ],
      ),
    );
  }
}
