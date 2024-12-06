
import 'package:flutter/material.dart';

import 'package:barbearia_lord_app/components/card_agenda.dart';
import '../utils/config.dart';

class CardAgendamento extends StatefulWidget {
  const CardAgendamento({super.key, required this.barbeiro, required this.color, });

final Map<String, dynamic>barbeiro;
final Color color;

  @override
  State<CardAgendamento> createState() => _CardAgendamentoState();
}

class _CardAgendamentoState extends State<CardAgendamento> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: widget.color,     //color
        borderRadius: BorderRadius.circular(0),
      ),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage("http://127.0.0.1:8000${widget.barbeiro['barbeiro_profile']}"),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "${widget.barbeiro['barbeiro_name']}",
                        style: const TextStyle(color: Colors.white),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                      Text(
                        widget.barbeiro['category'],
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                ],
              ),
              Config.spaceSmall,
              //adicionando o card agenda
              const CardAgenda(agendamento: {}, color: Config.primaryColor, ),
              Config.spaceSmall,

              //açao do botao
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Cancelar',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: (){},
                  ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Complete',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: (){},
                  ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
