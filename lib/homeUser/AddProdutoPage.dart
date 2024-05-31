// lib/telas/AddProductPage.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flora/ingredientes/model/IngredientsPage.dart';
import 'package:flora/ingredientes/model/AddIngredientPage.dart';

class Ingredient {
  final String name;
  final double quantity;
  final double costPrice;

  Ingredient(this.name, this.quantity, this.costPrice);
}

class AddProductPage extends StatefulWidget {
  final List<Ingredient>? ingredients; // Tornando a lista opcional

  AddProductPage({this.ingredients}); // Removendo o required

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController totalCostPriceController =
      TextEditingController();

  Map<String, Map<String, dynamic>> selectedIngredients = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Adicionar Produto')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Nome do Produto'),
            ),
            TextField(
              controller: totalCostPriceController,
              decoration: InputDecoration(labelText: 'Preço de Venda'),
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
              ],
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: ListView(
                children: (widget.ingredients ?? []).map((ingredient) {
                  return Column(
                    children: [
                      CheckboxListTile(
                        title: Text(ingredient.name),
                        value: selectedIngredients.containsKey(ingredient.name),
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              if (value) {
                                selectedIngredients[ingredient.name] = {
                                  'unit': 'g',
                                  'amount': 0
                                };
                              } else {
                                selectedIngredients.remove(ingredient.name);
                              }
                            });
                          }
                        },
                      ),
                      if (selectedIngredients.containsKey(ingredient.name))
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      decoration: InputDecoration(
                                        labelText: 'Quantidade',
                                      ),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.allow(
                                            RegExp(r'[0-9]')),
                                      ],
                                      onChanged: (value) {
                                        setState(() {
                                          selectedIngredients[ingredient.name]![
                                                  'amount'] =
                                              int.tryParse(value) ?? 0;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  DropdownButton<String>(
                                    value: selectedIngredients[
                                        ingredient.name]!['unit'],
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          selectedIngredients[ingredient.name]![
                                              'unit'] = newValue;
                                        });
                                      }
                                    },
                                    items: <String>['g', 'ml']
                                        .map<DropdownMenuItem<String>>(
                                            (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String name = nameController.text;
                String product = '$name - Ingredientes:\n';
                selectedIngredients.forEach((ingredient, details) {
                  product +=
                      '$ingredient: ${details['amount']}${details['unit']}\n';
                });
                product +=
                    'Preço de Venda: R\$${totalCostPriceController.text}';
                Navigator.pop(context, product);
              },
              child: Text('Adicionar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
