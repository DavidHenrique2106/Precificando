import 'package:flutter/material.dart';
import 'package:flora/ingredientes/model/AddIngredientPage.dart';

import 'package:flora/ingredientes/model/EditIngredientPage.dart';

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
                // Obter os novos valores dos campos
                String name = nameController.text;
                String quantity = quantityController.text;
                String ingredient =
                    '$name - $quantity - R\$$totalCostPrice - R\$$costPricePerUnit';
                // Adicionar à lista de ingredientes e voltar para a página anterior
                Navigator.pop(context, ingredient);
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
}
