
import 'package:barbearia_lord_app/models/model_autentication.dart';
import 'package:barbearia_lord_app/screens/barberDetail_page.dart';
import 'package:barbearia_lord_app/screens/bookin_screen.dart';
import 'package:barbearia_lord_app/screens/introduction.dart';
import 'package:barbearia_lord_app/screens/succesBokin_page.dart';
import 'package:barbearia_lord_app/utils/config.dart';
import 'package:barbearia_lord_app/utils/main_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

//statc navigator pucha a navegação
  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //pre definindo o themeData
    return ChangeNotifierProvider<ModelAutentication>(
      create: (context)=>ModelAutentication(),
      child: MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Barber Lord',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //pre define os inputs
          inputDecorationTheme: const InputDecorationTheme(
            focusColor: Config.primaryColor,
            border: Config.outlinedBorder,
            focusedBorder: Config.focusBorder,
            errorBorder: Config.errorBorder,
            enabledBorder: Config.outlinedBorder,
            floatingLabelStyle: TextStyle(color: Config.primaryColor),
            prefixIconColor: Colors.black,
          ),

          scaffoldBackgroundColor: Colors.brown.shade100,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: Config.primaryColor,
            selectedItemColor: Colors.black12,
            showSelectedLabels: true,
            showUnselectedLabels: false,
            unselectedItemColor: Colors.grey.shade700,
            elevation: 40,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        initialRoute: 'intro',
        routes: {
          'intro': (context) => const Introduction(),
          'main':(context)=> const MainLayout(),
          'detalhe_barber': (context)=> const BarberDetail(),
          'bookin': (context)=> const BookinScreen(),
          'succes_bookin': (context)=> const SuccesbokinPage(),
        },

      ),
    );

  }
}
