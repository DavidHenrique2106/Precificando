import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AddIngredientPage extends StatefulWidget {
  @override
  _AddIngredientPageState createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController totalCostPriceController =
      TextEditingController();

  double costPricePerUnit = 0.0;
  double totalCostPrice = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar Ingrediente'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome do Ingrediente'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantidade Comprada'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                calculateTotalCostPrice();
              },
            ),
            TextField(
              controller: totalCostPriceController,
              decoration: InputDecoration(labelText: 'Preço de Compra Total'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                calculateCostPricePerUnit();
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                addIngredientToParse();
              },
              child: Text('Adicionar Ingrediente'),
            ),
          ],
        ),
      ),
    );
  }

  void calculateCostPricePerUnit() {
    setState(() {
      double quantity = double.tryParse(quantityController.text) ?? 0.0;
      totalCostPrice = double.tryParse(totalCostPriceController.text) ?? 0.0;
      if (quantity != 0.0) {
        costPricePerUnit = totalCostPrice / quantity;
      } else {
        costPricePerUnit = 0.0;
      }
    });
  }

  void calculateTotalCostPrice() {
    setState(() {
      double quantity = double.tryParse(quantityController.text) ?? 0.0;
      double price = double.tryParse(totalCostPriceController.text) ?? 0.0;
      totalCostPrice = quantity * price;
    });
  }

  void addIngredientToParse() async {
    try {
      final currentUser = await ParseUser.currentUser();

      if (currentUser != null) {
        String name = nameController.text;
        double quantity = double.tryParse(quantityController.text) ?? 0.0;
        double totalCostPrice =
            double.tryParse(totalCostPriceController.text) ?? 0.0;

        final ingredient = ParseObject('Ingredients')
          ..set('name', name)
          ..set('quantity', quantity)
          ..set('totalCostPrice', totalCostPrice);

        final acl = ParseACL(owner: currentUser);
        ingredient.setACL(acl);

        final response = await ingredient.save();
        if (response.success) {
          // Adicionando o ingrediente à lista e retornando à página IngredientListPage
          Navigator.pop(context, name);
        }
      } else {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Erro'),
            content: Text('Ocorreu um erro ao inserir o ingrediente.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Erro'),
          content: Text('Ocorreu um erro ao inserir o ingrediente.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
}
