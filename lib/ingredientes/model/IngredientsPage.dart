import 'package:flutter/material.dart';
import 'AddIngredientPage.dart';
import 'EditIngredientPage.dart';
import 'package:flora/homeUser/home_page.dart';
import 'package:flora/graficos/dashbord.dart';

class IngredientListPage extends StatefulWidget {
  @override
  _IngredientListPageState createState() => _IngredientListPageState();
}

class _IngredientListPageState extends State<IngredientListPage> {
  List<String> ingredients = [];

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
          return ListTile(
            title: Text(ingredients[index]),
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
                  // Navegar para a tela de edição do ingrediente
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditIngredientPage(index, ingredients),
                    ),
                  ).then((value) {
                    // Atualizar a lista de ingredientes com os novos valores após a edição
                    if (value != null) {
                      setState(() {
                        ingredients = value;
                      });
                    }
                  });
                } else if (value == 'delete') {
                  setState(() {
                    ingredients.removeAt(index);
                  });
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height *
              0.03, // Posição vertical ajustável
          left: MediaQuery.of(context).size.width *
              0.05, // Preenchimento esquerdo ajustável
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.022), // Espaço entre o botão flutuante e a animação
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.16,
              height: MediaQuery.of(context).size.width * 0.16,
              child: FloatingActionButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddIngredientPage()),
                  );

                  if (result != null) {
                    setState(() {
                      ingredients.add(result);
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
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => MyHomePage()),
                    ); //adicione aqui o direcionamento para a página home
                  },
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.14,
                ), // Espaçamento entre os ícones
                IconButton(
                  icon: Icon(
                    Icons.person,
                    size: MediaQuery.of(context).size.width * 0.14,
                    color: Color.fromRGBO(77, 91, 174, 1),
                  ),
                  onPressed: () {
                    setState(() {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RelatoriosScreen()),
                      );
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
