import 'package:flutter/material.dart';
import 'package:flora/perfil/profile_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0; // Índice da página selecionada
  bool isFABOpen = false;
  bool isDarkened = false;

  // Páginas a serem exibidas no BottomNavigationBar
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(), // Página inicial (Home)
    ProfilePage(), // Página do perfil
  ];

  // Função para alternar entre as páginas ao clicar nos itens da barra de navegação
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(114, 133, 202, 1),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color.fromRGBO(114, 133, 202, 1),
            ),
          ),
          // Foto de perfil, nome e nome da empresa no canto superior esquerdo
          Positioned(
            top: 40,
            left: 20,
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey,
                  ),
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
                        color: Colors.white70,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Modal flutuante com informações de título e descrição (Precificação)
          AnimatedOpacity(
            opacity: isDarkened ? 0.7 : 0.0,
            duration: Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: () {}, // Evento para fechar os modais
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      // FAB Menu
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Visibility(
              visible: isFABOpen,
              child: Container(
                child: Column(
                  children: [
                    // Adicione os FABs conforme necessário
                  ],
                ),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.022),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.16,
              height: MediaQuery.of(context).size.width * 0.16,
              child: FloatingActionButton(
                onPressed: () {
                  setState(() {
                    isFABOpen = !isFABOpen;
                  });
                },
                child: Icon(
                  isFABOpen ? Icons.close : Icons.add,
                  size: MediaQuery.of(context).size.width * 0.08,
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                backgroundColor: Color.fromRGBO(77, 91, 174, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      MediaQuery.of(context).size.width * 0.08),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation:
          FloatingActionButtonLocation.miniCenterDocked,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(217, 217, 217, 1),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color.fromRGBO(77, 91, 174, 1),
        onTap: _onItemTapped,
      ),
    );
  }

  // Método para construir o modal flutuante
  Widget _buildModal(String title, String description) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4,
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(77, 91, 174, 1),
            ),
          ),
          SizedBox(height: 5),
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
