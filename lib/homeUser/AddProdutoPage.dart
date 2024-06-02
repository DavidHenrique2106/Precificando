import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AddProductPage extends StatefulWidget {
  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController totalCostPriceController = TextEditingController();
  List<ParseObject> ingredients = [];
  Map<String, Map<String, dynamic>> selectedIngredients = {};

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

  Future<void> _saveProduct() async {
    final name = nameController.text;
    final totalCostPrice = totalCostPriceController.text;

    if (name.isEmpty || totalCostPrice.isEmpty) {
      // Mostrar mensagem de erro
      return;
    }

    final product = ParseObject('Products')
      ..set('name', name)
      ..set('totalCostPrice', double.tryParse(totalCostPrice) ?? 0.0)
      ..set('ingredients', selectedIngredients);

    final response = await product.save();

    if (response.success) {
      Navigator.pop(context, true);
    } else {
      // Mostrar mensagem de erro
    }
  }

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
              child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = ingredients[index];
                  final ingredientName = ingredient.get<String>('name') ?? 'No Name';
                  return Column(
                    children: [
                      CheckboxListTile(
                        title: Text(ingredientName),
                        value: selectedIngredients.containsKey(ingredientName),
                        onChanged: (bool? value) {
                          if (value != null) {
                            setState(() {
                              if (value) {
                                selectedIngredients[ingredientName] = {
                                  'unit': 'g',
                                  'amount': 0
                                };
                              } else {
                                selectedIngredients.remove(ingredientName);
                              }
                            });
                          }
                        },
                      ),
                      if (selectedIngredients.containsKey(ingredientName))
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
                                          selectedIngredients[ingredientName]![
                                          'amount'] =
                                              int.tryParse(value) ?? 0;
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 16.0),
                                  DropdownButton<String>(
                                    value: selectedIngredients[
                                    ingredientName]!['unit'],
                                    onChanged: (String? newValue) {
                                      if (newValue != null) {
                                        setState(() {
                                          selectedIngredients[ingredientName]![
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
                },
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text('Adicionar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
