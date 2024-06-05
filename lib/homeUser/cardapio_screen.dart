  import 'package:flutter/material.dart';
  import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
  import 'AddProdutoPage.dart';
  import 'EditProdutoPage.dart';
  import 'ProductDetailsPage.dart';

  class ProductListPage extends StatefulWidget {
    @override
    ProductListPageState createState() => ProductListPageState();
  }

  class ProductListPageState extends State<ProductListPage> {
    int _selectedIndex = 0;
    List<ParseObject> products = [];
    List<ParseObject> filteredProducts = [];
    String searchQuery = "";

    @override
    void initState() {
      super.initState();
      _loadProducts();
    }

    static List<Widget> _widgetOptions = <Widget>[
      // MyHomePage(), // Página inicial (Home)
      // ProfilePage(), // Página do perfil
    ];

    Future<void> _loadProducts() async {
      QueryBuilder<ParseObject> queryProducts = QueryBuilder<ParseObject>(ParseObject('Products'));
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
          title: Text("Lista de Produtos"),
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
                      _showProductDetails(product);
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
                              builder: (context) => EditProductPage(product, products),
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
                  child: Icon(Icons.add),
                ),
              ),
              SizedBox(height: 20), // Espaço para rolar a página até o fim
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: [
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
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      );
    }

    void _showProductDetails(ParseObject product) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProductDetailsPage(product: product),
        ),
      );
    }
  }
