import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flora/perfil/profile_page.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  String _username = "Usuário";
  String _companyName = "Nome da Empresa";

  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(), // Página inicial (Home)
    ProfilePage(), // Página do perfil
  ];

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      setState(() {
        _username = user.username!;
        _companyName = user.get<String>('companyName') ?? 'Nome da Empresa';
      });
    }
  }

  void _onItemTapped(int index) async {
    if (index == 2) {
      final newCompanyName = await Navigator.push<String>(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
      if (newCompanyName != null) {
        setState(() {
          _companyName = newCompanyName;
        });
      }
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
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
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
              child: Center(
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Colors.white,
                  child: Center(
                    child: Text(
                      'Container Centralizado',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
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
                        _username,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        _companyName,
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
          ),
        ],
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
              ),
              BottomNavigationBarItem(
                icon: _buildIconWithLabel(
                  Icons.currency_exchange_outlined,
                  _selectedIndex == 1,
                ),
                label: 'Finanças',
              ),
              BottomNavigationBarItem(
                icon: _buildIconWithLabel(Icons.person, _selectedIndex == 2),
                label: 'Perfil',
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }
}
