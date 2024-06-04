import 'package:flutter/material.dart';
import 'AddIngredientPage.dart';
import 'EditIngredientPage.dart';
import 'package:flora/homeUser/home_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flora/perfil/profile_page.dart';

class IngredientListPage extends StatefulWidget {
  @override
  _IngredientListPageState createState() => _IngredientListPageState();
}

class _IngredientListPageState extends State<IngredientListPage> {
  int _selectedIndex = 0;
  List<ParseObject> ingredients = [];
  List<ParseObject> filteredIngredients = [];
  String searchQuery = "";

  static List<Widget> _widgetOptions = <Widget>[
    MyHomePage(), // Página inicial (Home)
    ProfilePage(), // Página do perfil
  ];

  Widget _buildIconWithLabel(IconData icon, bool isSelected) {
    return Container(
      width: 30,
      height: 30,
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
            size: 25,
            color: isSelected ? Colors.black : Colors.black,
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );

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

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  Future<void> _loadIngredients() async {
    QueryBuilder<ParseObject> queryIngredients =
        QueryBuilder<ParseObject>(ParseObject('Ingredients'));
    final ParseResponse apiResponse = await queryIngredients.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        ingredients = apiResponse.results as List<ParseObject>;
        // Inicializar a lista filtrada com todos os ingredientes
        filteredIngredients = List.from(ingredients);
      });
    }
  }

  // Método para filtrar os ingredientes com base na consulta de pesquisa
  void _filterIngredients(String query) {
    setState(() {
      searchQuery = query;
      filteredIngredients = ingredients.where((ingredient) {
        final name = ingredient.get<String>('name')?.toLowerCase() ?? '';
        return name.contains(searchQuery.toLowerCase());
      }).toList();
    });
  }

  void _deleteIngredient(int index) async {
    final ingredient = ingredients[index];
    await ingredient.delete();
    await _loadIngredients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(226, 153, 66, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Lista de Ingredientes",
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: _filterIngredients,
                decoration: InputDecoration(
                  labelText: 'Pesquisar',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
            // Lista de Ingredientes
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredIngredients.length,
              itemBuilder: (context, index) {
                final ingredient = filteredIngredients[index];
                return ListTile(
                  title: Text(ingredient.get<String>('name') ?? 'No Name'),
                  trailing: PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('Editar'),
                        value: 'edit',
                      ),
                      PopupMenuItem(
                        child: Text('Excluir'),
                        value: 'delete',
                      ),
                    ],
                    onSelected: (value) {
                      if (value == 'edit') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                EditIngredientPage(index, ingredients.cast()),
                          ),
                        ).then((value) {
                          if (value != null) {
                            _loadIngredients();
                          }
                        });
                      } else if (value == 'delete') {
                        _deleteIngredient(index);
                      }
                    },
                  ),
                );
              },
            ),
            SizedBox(height: 20), // Espaço entre a lista e o botão
            Center(
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddIngredientPage()),
                  );
                  if (result != null) {
                    await _loadIngredients();
                  }
                },
                child: Icon(
                  Icons.add,
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                backgroundColor: Color.fromRGBO(226, 153, 66, 1),
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
            backgroundColor: Color.fromRGBO(226, 153, 66, 1),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                  child: _buildIconWithLabel(Icons.home, _selectedIndex == 0),
                ),
                label: 'Home',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () {},
                  child: _buildIconWithLabel(
                    Icons.currency_exchange_outlined,
                    _selectedIndex == 1,
                  ),
                ),
                label: 'Finanças',
                backgroundColor: Colors.white,
              ),
              BottomNavigationBarItem(
                icon: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProfilePage()),
                    );
                  },
                  child: _buildIconWithLabel(Icons.person, _selectedIndex == 2),
                ),
                label: 'Perfil',
                backgroundColor: Colors.white,
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white70,
            currentIndex: _selectedIndex,
          ),
        ),
      ),
    );
  }
}
