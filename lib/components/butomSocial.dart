import 'package:flutter/material.dart';

import '../utils/config.dart';

class ButomSocial extends StatelessWidget {
  const ButomSocial({super.key, required this.social});

  final String social;

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10),
        side: const BorderSide(width: 1, color: Colors.black),
      ),
      onPressed: () {},
      child: SizedBox(
        width: Config.widthSize * 0.4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Image.asset(
                'assets/$social.png',
                width: 40,
                height: 40,
              ),
            ),
            Expanded(
              child: Text(
                social.toUpperCase(),
                style: const TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
