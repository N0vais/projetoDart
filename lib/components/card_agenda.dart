
import 'package:flutter/material.dart';

class CardAgenda extends StatelessWidget {
  const CardAgenda({super.key, required this.agendamento, required this.color});

  final Map<String, dynamic>agendamento;
  final Color color;
  @override
  Widget build(BuildContext context) {
    //card incluido da agenda do barbeiro
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Icon(
            Icons.calendar_today,
            color: Colors.black,
            size: 15,
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            '${agendamento['day']}, ${agendamento['date']}',
            style: const TextStyle(color: Colors.black38),
          ),
          const SizedBox(
            width: 20,
          ),
          const Icon(
            Icons.access_alarm,
            color: Colors.black,
            size: 17,
          ),
          const SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
                agendamento['time'],
                style: const TextStyle(color: Colors.black38),
              ))
        ],
      ),
    );
  }
}
