import 'package:flutter/material.dart';
import 'AddIngredientPage.dart';
import 'EditIngredientPage.dart';
import 'package:flora/homeUser/home_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class IngredientListPage extends StatefulWidget {
  @override
  _IngredientListPageState createState() => _IngredientListPageState();
}

class _IngredientListPageState extends State<IngredientListPage> {
  List<ParseObject> ingredients = [];

  @override
  void initState() {
    super.initState();
    _loadIngredients();
  }

  Future<void> _loadIngredients() async {
    QueryBuilder<ParseObject> queryIngredients = QueryBuilder<ParseObject>(ParseObject('Ingredients'));
    final ParseResponse apiResponse = await queryIngredients.query();

    if (apiResponse.success && apiResponse.results != null) {
      setState(() {
        ingredients = apiResponse.results as List<ParseObject>;
      });
    }
  }

  Future<void> _deleteIngredient(int index) async {
    final ingredient = ingredients[index];
    await ingredient.delete();
    await _loadIngredients(); // Recarregar os ingredientes após deletar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(60, 90, 182, 0.3),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const Text("Lista de Ingredientes")],
        ),
      ),
      body: ListView.builder(
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
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
                      builder: (context) => EditIngredientPage(index, ingredients.cast()),
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
                    MaterialPageRoute(builder: (context) => AddIngredientPage()),
                  );

                  if (result != null && result == true) {
                    await _loadIngredients();
                  }
                },
                child: Icon(
                  Icons.add,
                  size: MediaQuery.of(context).size.width * 0.08,
                  color: Color.fromRGBO(217, 217, 217, 1),
                ),
                backgroundColor: Color.fromRGBO(77, 91, 174, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(MediaQuery.of(context).size.width * 0.08),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniCenterDocked,
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
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.14,
                ),
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width * 0.14,
                    color: Color.fromRGBO(77, 91, 174, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      // Adicione aqui a ação desejada ao pressionar o ícone de perfil
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
