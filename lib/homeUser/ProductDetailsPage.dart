import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ProductDetailsPage extends StatelessWidget {
  final ParseObject product;

  ProductDetailsPage({required this.product});

  @override
  Widget build(BuildContext context) {
    final productName = product.get<String>('name') ?? 'No Name';
    final totalCostPrice = product.get<double>('totalCostPrice') ?? 0.0;
    final ingredients = product.get<Map<String, dynamic>>('ingredients') ?? {};

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Produto'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nome: $productName',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Preço Total: R\$${totalCostPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 16),
            Text(
              'Ingredientes:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Expanded(
              child: ingredients.isNotEmpty
                  ? ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  final ingredientName = ingredients.keys.elementAt(index);
                  final ingredientData = ingredients[ingredientName];
                  final amount = ingredientData['amount'] ?? 0;
                  final unitCostPrice = ingredientData['unitCostPrice'] ?? 0.0;
                  final totalCostPrice = ingredientData['totalCostPrice'] ?? 0.0;

                  return ListTile(
                    title: Text(ingredientName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Quantidade: $amount'),
                        Text('Custo Unitário: R\$${unitCostPrice.toStringAsFixed(2)}'),
                        Text('Custo Total: R\$${totalCostPrice.toStringAsFixed(2)}'),
                      ],
                    ),
                  );
                },
              )
                  : Center(child: Text('Nenhum ingrediente encontrado')),
            ),
          ],
        ),
      ),
    );
  }
}
