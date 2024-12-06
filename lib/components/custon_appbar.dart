import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/config.dart';

class CustonAppbar extends StatefulWidget implements PreferredSizeWidget {
  const CustonAppbar(
      {super.key, this.appTitle, this.route, this.icon, this.actions});

  @override
  Size get preferredSize => const Size.fromHeight(60); //altura padrao do appbar

  final String? appTitle;
  final String? route;
  final FaIcon? icon;
  final List<Widget>? actions;

  @override
  State<CustonAppbar> createState() => _CustonAppbarState();
}

class _CustonAppbarState extends State<CustonAppbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        widget.appTitle!,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      leading: widget.icon != null
          ? Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(0),
          color: Config.primaryColor,
        ),
        child: IconButton(
          onPressed: () {
            //se a rota for fornecida, este botão de ícone navegará por essa rota
            if (widget.route != null) {
              Navigator.of(context).pushNamed(widget.route!);
            } else {
              //se nao voltara para a pagina anterior.
              Navigator.of(context).pop();
            }
          },
          icon: widget.icon!,
          iconSize: 16,
          color: Colors.white38,
        ),
      )
          : null,
      //se a acao ester vazia retarna nulo
      actions: widget.actions,
    );
  }
}
