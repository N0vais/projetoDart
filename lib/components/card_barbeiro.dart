import 'package:flutter/material.dart';
import '../utils/config.dart';
import 'dart:convert';


class CardBarbeiro extends StatelessWidget{
  const CardBarbeiro({Key? key, required this.route,required this.barbeiro});

  final String route;
  final Map<String, dynamic> barbeiro;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    final imageUrl = "http://192.168.15.91:8000${barbeiro['barbeiro_profile']}";
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child: Card(
          elevation: 5,
          color: Colors.white,
          child: Row(
            children: [
              SizedBox(
                width: Config.widthSize * 0.33,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.fill,
                  errorBuilder: (context, error, stackTrace) { return const Icon( Icons.person, size: 30, ); },
                ),
              ),
               Flexible(
                  child: Padding(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${barbeiro['barbeiro_name']}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${barbeiro['category']}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        const Spacer(),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Icon(
                              Icons.star_border,
                              color: Colors.yellow,
                              size: 16,
                            ),
                            Spacer(
                              flex: 1,
                            ),
                            Text('4.5'),
                            Spacer(
                              flex: 1,
                            ),
                            Text('Reviews'),
                            Spacer(
                              flex: 1,
                            ),
                            Text('(20)'),
                            Spacer(
                              flex: 7,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ))
            ],
          ),
        ),
        onTap: (){
          Navigator.of(context).pushNamed(route, arguments: barbeiro);
        },
      ),
    );
  }
}
