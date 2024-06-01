import 'package:flora/perfil/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flora/homeUser/home_page.dart';
import 'package:flora/homeUser/cardapio_screen.dart';
import 'package:flora/loginUser/login_page.dart';
import 'package:flora/loginUser/register_page.dart';
import 'package:flora/apresentar/homePageAP.dart';
import 'package:flora/ingredientes/model/AddIngredientPage.dart';
import 'package:flora/ingredientes/model/EditIngredientPage.dart';
import 'package:flora/ingredientes/model/IngredientsPage.dart';
import 'package:flora/perfil/profile_page.dart';

void main() async {
  {
    WidgetsFlutterBinding.ensureInitialized();
    final keyApplicationId = 'MGrlk40ufPq0FndIImuk7VlzJb7FSsj1NHHgtuVP';
    final keyClientKey = 'ZeIrpHMzxeruZCcYQFOmvI5duT6wpGLUJVOWMsMQ';
    final keyParseServerUrl = 'https://parseapi.back4app.com';

    await Parse().initialize(keyApplicationId, keyParseServerUrl,
        clientKey: keyClientKey, autoSendSessionId: true);
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      routes: {
        '/home': (context) => MyHomePage(),
        '/ingredientes': (context) => IngredientListPage(),
        '/cardapio': (context) => ProductListPage(),
        '/login': (context) => LoginPage(),
        '/register': (context) => RegisterPage(),
        '/profile': (context) => ProfilePage(),
      },
    );
  }
}
