import 'package:flutter/material.dart';
import 'package:flora/ingredientes/model/IngredientsPage.dart';
import 'package:flora/ingredientes/model/AddIngredientPage.dart';
import 'AddProdutoPage.dart';
import 'EditProdutoPage.dart';

class ProductListPage extends StatefulWidget {
  @override
  ProductListPageState createState() => ProductListPageState();
}

class ProductListPageState extends State<ProductListPage> {
  int currentTab = 0;
  List<String> product = [];

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(60, 90, 182, 0.3),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("Lista de Produtos")],
        ),
      ),
      body: ListView.builder(
        itemCount: product.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(product[index]),
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
                      builder: (context) => EditProductPage(index, product),
                    ),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        product = value;
                      });
                    }
                  });
                } else if (value == ' delete') {
                  setState(() {
                    product.remove(index);
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height * 0.03,
          left: MediaQuery.of(context).size.width * 0.05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.022),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.16,
              height: MediaQuery.of(context).size.width * 0.16,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddProductPage()),
                  );
                  if (result != null) {
                    setState(() {
                      product.add(result);
                    });
                  }
                },
                child: Icon(
                  Icons.add,
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
                    setState(() {
                      currentTab = 0;
                    });
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
}
