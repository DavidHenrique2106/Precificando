import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'AddProdutoPage.dart';
import 'EditProdutoPage.dart';
import 'package:flora/homeUser/home_page.dart';

class ProductListPage extends StatefulWidget {
  @override
  ProductListPageState createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {
  int currentTab = 0;
  List<ParseObject> products = [];
  List<ParseObject> filteredProducts = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    _loadProducts();
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
        backgroundColor: Color(0x4d7a2cf8),
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
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.078,
            color: Color.fromRGBO(217, 217, 217, 1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.home,
                    size: MediaQuery.of(context).size.width * 0.14,
                    color: Color.fromRGBO(77, 91, 174, 1),
                  ),
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    );
                  },
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.14),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width * 0.14,
                    color: Color.fromRGBO(77, 91, 174, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      currentTab = 0;
                    });
                  },
                ),
              ],
            ),
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
