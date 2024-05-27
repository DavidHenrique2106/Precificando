import 'package:flutter/material.dart';

import 'IngredientsPage.dart';

import 'AddIngredientPage.dart';

class EditIngredientPage extends StatefulWidget {
  final int index;
  final List<String> ingredients;

  EditIngredientPage(this.index, this.ingredients);

  @override
  _EditIngredientPageState createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController totalCostPriceController;

  double costPricePerUnit = 0.0;
  double totalCostPrice = 0.0;

  @override
  void initState() {
    super.initState();
    List<String> ingredientParts =
        widget.ingredients[widget.index].split(' - ');
    nameController = TextEditingController(text: ingredientParts[0]);
    quantityController = TextEditingController(text: ingredientParts[1]);
    totalCostPriceController =
        TextEditingController(text: ingredientParts[2].replaceAll(' ', ''));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Ingrediente'),
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
                calculateCostPricePerUnit();
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
                String totalCostPrice = totalCostPriceController.text;

                // Montar o ingrediente atualizado
                String updatedIngredient =
                    '$name - $quantity - $totalCostPrice - $costPricePerUnit';
                // Atualizar a lista de ingredientes com o ingrediente atualizado
                widget.ingredients[widget.index] = updatedIngredient;
                // Voltar para a página anterior com a lista atualizada de ingredientes
                Navigator.pop(context, widget.ingredients);
              },
              child: Text('Salvar'),
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
}
