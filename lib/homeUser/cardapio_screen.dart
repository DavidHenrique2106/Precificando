import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'AddProdutoPage.dart';
import 'EditProdutoPage.dart';
import 'package:flora/homeUser/home_page.dart';
import 'package:flora/perfil/profile_page.dart';

class ProductListPage extends StatefulWidget {
  @override
  ProductListPageState createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {
  int _selectedIndex = 0;
  int currentTab = 0;
  List<ParseObject> products = [];
  List<ParseObject> filteredProducts = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadProducts();
  }

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
            isSelected ? Color.fromRGBO(114, 133, 202, 1) : Colors.transparent,
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

  Future<void> _loadProducts() async {
    QueryBuilder<ParseObject> queryProducts =
        QueryBuilder<ParseObject>(ParseObject('Products'));
    final ParseResponse apiResponse = await queryProducts.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        products = apiResponse.results as List<ParseObject>;
        filteredProducts = products;
      });
    }
  }

  void _filterProducts() {
    setState(() {
      filteredProducts = products.where((product) {
        final name = product.get<String>('name')?.toLowerCase() ?? '';
        return name.contains(searchQuery.toLowerCase());
      }).toList();
    });
  }

  Future<void> _deleteProduct(int index) async {
    final product = filteredProducts[index];
    await product.delete();
    await _loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(114, 133, 202, 1),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("Lista de Produtos")],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                    _filterProducts();
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Pesquisar...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20),
                ),
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: filteredProducts.length,
              itemBuilder: (context, index) {
                final product = filteredProducts[index];
                return ListTile(
                  title: Text(product.get<String>('name') ?? 'No Name'),
                  onTap: () {
                    _showIngredients(product);
                  },
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
                            builder: (context) => EditProductPage(
                                product, products.cast<ParseObject>()),
                          ),
                        ).then((value) {
                          if (value != null && value == true) {
                            _loadProducts();
                          }
                        });
                      } else if (value == 'delete') {
                        _deleteProduct(index);
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
                    MaterialPageRoute(builder: (context) => AddProductPage()),
                  );
                  if (result != null) {
                    await _loadProducts();
                  }
                },
                child: Icon(
                  Icons.add,
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                backgroundColor: Color.fromRGBO(77, 91, 174, 1),
              ),
            ),
            SizedBox(height: 20), // Espaço para rolar a página até o fim
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
            unselectedItemColor: Colors.white70,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _showIngredients(ParseObject product) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => IngredientsPage(product: product),
      ),
    );
  }

  IngredientsPage({required ParseObject product}) async {}
}
