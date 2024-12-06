
import 'package:flutter/material.dart';

import '../screens/agendamento.dart';
import '../screens/home_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}
class _MainLayoutState extends State<MainLayout>{
  //variaveis de controle
  int currentPage = 0;
  final PageController _page = PageController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _page,
        onPageChanged: ((value) {
          setState(() {
            //atualiza a pagina index quando o enter for precionado
            currentPage =value;
          });
        }),
        children: <Widget>[
          const HomePage(),
          const AgendamentoPage(),
        ],
      ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentPage,
          onTap: (page){
            setState(() {
              currentPage = page;
              _page.animateToPage(
                  page, duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
              );
            });
          }, 
          items: const <BottomNavigationBarItem> [
            BottomNavigationBarItem(
                icon: Icon(Icons.home, color: Color(0xffcacaca),
                ),
              label: 'Home',
            ),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.favorite, color: Color(0xffcacaca),
            //     ),
            //   label: 'Favorite',
            //),
            BottomNavigationBarItem(
                icon: Icon(Icons.edit_calendar_outlined, color: Color(0xffcacaca),
                ),
              label: 'Agendamento',
            ),
            // BottomNavigationBarItem(
            //     icon: Icon(Icons.person, color: Color(0xffcacaca),
            //     ),
            //   label: 'Perfil',
            // )
          ],
        )
    );
  }

}