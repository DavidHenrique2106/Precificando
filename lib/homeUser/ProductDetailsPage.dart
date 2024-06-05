import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ProductDetailsPage extends StatelessWidget {
  final ParseObject product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final String name = product.get<String>('name') ?? 'No Name';
    final double totalCostPrice = product.get<double>('totalCostPrice') ?? 0.0;
    final Map<String, dynamic> ingredients = product.get<Map<String, dynamic>>('ingredients') ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text(name),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Nome: $name', style: TextStyle(fontSize: 20)),
            SizedBox(height: 8.0),
            Text('Preço Total: R\$ ${totalCostPrice.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 16.0),
            Text('Ingredientes:', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8.0),
            Expanded(
              child: ListView.builder(
                itemCount: ingredients.keys.length,
                itemBuilder: (context, index) {
                  final ingredientName = ingredients.keys.elementAt(index);
                  final ingredientData = ingredients[ingredientName] as Map<String, dynamic>;
                  final unitCostPrice = ingredientData['unitCostPrice'] ?? 0.0;
                  final amount = ingredientData['amount'] ?? 0;
                  final selectedUnitType = ingredientData['selectedUnitType'] ?? 'unidades';

                  String quantityLabel = '';
                  String priceLabel = '';

                  switch (selectedUnitType) {
                    case 'kgs':
                      quantityLabel = 'Quantidade em kgs';
                      priceLabel = 'Preço por kg';
                      break;
                    case 'mls':
                      quantityLabel = 'Quantidade em mls';
                      priceLabel = 'Preço por ml';
                      break;
                    case 'unidades':
                      quantityLabel = 'Quantidade de unidades';
                      priceLabel = 'Preço por unidade';
                      break;
                  }

                  return ListTile(
                    title: Text(ingredientName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('$quantityLabel: $amount'),
                        Text('$priceLabel: R\$ ${unitCostPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
