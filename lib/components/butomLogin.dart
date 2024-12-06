
import 'package:flutter/material.dart';

import '../utils/config.dart';

class Butomlogin extends StatelessWidget {
  const Butomlogin(
      {super.key,
        required this.width,
        required this.title,
        required this.onPressed,
        required this.disable});

  final double width;
  final String title;
  final bool disable;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.grey,
          foregroundColor: Config.primaryColor,

        ),
        onPressed: disable ? null : onPressed,
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
