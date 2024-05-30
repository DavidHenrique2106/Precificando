import 'package:flutter/material.dart';
import 'package:flora/homeUser/home_page.dart';
import 'package:flora/homeUser/cardapio_screen.dart';
import 'package:flora/loginUser/login_page.dart';
import 'package:flora/loginUser/register_page.dart';
import 'package:flora/apresentar/homePageAP.dart';
import 'package:flora/ingredientes/model/AddIngredientPage.dart';
import 'package:flora/ingredientes/model/EditIngredientPage.dart';
import 'package:flora/ingredientes/model/IngredientsPage.dart';

import 'package:flora/graficos/dashbord.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeApresenta(),
      routes: {
        '/home': (context) => MyHomePage(),
        '/ingredientes': (context) => IngredientListPage(),
        '/cardapio': (context) => CardapioScreen(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
      },
    );
  }
}
