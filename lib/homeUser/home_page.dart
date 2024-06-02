import 'package:flutter/material.dart';
import 'package:flora/perfil/profile_page.dart';
import 'package:flora/homeUser/cardapio_screen.dart';
import 'package:flora/ingredientes/model/IngredientsPage.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(), // Página inicial (Home)
    ProfilePage(), // Página do perfil
  ];

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        // Lógica para index 1, se necessário
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      } else {
        _selectedIndex = index;
      }
    });
  }

  Widget _buildIconWithLabel(IconData icon, bool isSelected) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isSelected ? Color.fromRGBO(226, 153, 66, 1) : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 35,
            color: isSelected ? Colors.white : Colors.black,
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe3e3e3),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(114, 133, 202, 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 150,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Flora Matos',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Empresa XYZ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: Color.fromRGBO(226, 153, 66, 1),
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Bem-vindo',
                                style: TextStyle(
                                  color: Color.fromRGBO(114, 133, 202, 1),
                                  fontSize: 33,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Precificando te ajuda na gestão de alimentos seu restaurante',
                                style: TextStyle(
                                  color: Color.fromRGBO(114, 133, 202, 1),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Icon(
                          Icons.store,
                          color: Color.fromRGBO(226, 153, 66, 1),
                          size: 100,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Serviços',
                    style: TextStyle(
                      color: Color.fromRGBO(114, 133, 202, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IngredientListPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 115,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(226, 153, 66, 1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color.fromRGBO(114, 133, 202, 1),
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            'Ingredientes',
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductListPage(),
                        ),
                      );
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.4,
                      height: 115,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(114, 133, 202, 1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: Color.fromRGBO(226, 153, 66, 1),
                          width: 2.0,
                        ),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.shopping_bag,
                            color: Colors.white,
                            size: 50,
                          ),
                          Text(
                            'Produtos',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Planos',
                    style: TextStyle(
                      color: Color.fromRGBO(114, 133, 202, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IngredientListPage(),
                      ),
                    );**/
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(114, 133, 202, 1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color.fromRGBO(226, 153, 66, 1),
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.badge,
                        color: Colors.white,
                        size: 50,
                      ),
                      SizedBox(
                          width: 10), // Espaçamento entre o ícone e o texto
                      Expanded(
                        child: Text(
                          'Conheça nos planos de consultoria de negócios.',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Conheça o App e Dicas',
                    style: TextStyle(
                      color: Color.fromRGBO(114, 133, 202, 1),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: GestureDetector(
                onTap: () {
                  /*Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => IngredientListPage(),
                      ),
                    );**/
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 140,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(226, 153, 66, 1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color.fromRGBO(114, 133, 202, 1),
                      width: 2.0,
                    ),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Aprenda a navegar pelo app e veja nossas dicas na redes',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ),
                      Icon(
                        Icons.map,
                        color: Colors.white,
                        size: 60,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.white),
              ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Color.fromRGBO(114, 133, 202, 1),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildIconWithLabel(Icons.home, _selectedIndex == 0),
                label: 'Home',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: _buildIconWithLabel(
                  Icons.currency_exchange_outlined,
                  _selectedIndex == 1,
                ),
                label: 'Finanças',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: _buildIconWithLabel(Icons.person, _selectedIndex == 2),
                label: 'Perfil',
                backgroundColor: Colors.white,
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
