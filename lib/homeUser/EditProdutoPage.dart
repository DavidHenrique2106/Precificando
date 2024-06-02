import 'package:flutter/material.dart';
import 'cardapio_screen.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class EditProductPage extends StatefulWidget {
  final ParseObject product;
  final List<ParseObject> productList;

  EditProductPage(this.product, this.productList);

  @override
  EditProductPageState createState() => EditProductPageState();
}

class EditProductPageState extends State<EditProductPage> {
  late TextEditingController nameController;
  late TextEditingController quantityController;
  late TextEditingController totalCostPriceController;

  double costPricePerUnit = 0.0;
  double totalCostPrice = 0.0;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.product.get<String>('name') ?? '');
    quantityController = TextEditingController(text: widget.product.get<String>('quantity') ?? '');
    totalCostPriceController = TextEditingController(text: widget.product.get<String>('totalCostPrice') ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Produto'),
      ),
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
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantidade'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: totalCostPriceController,
              decoration: InputDecoration(labelText: 'Preço de Venda'),
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

                // Atualizar o produto
                widget.product.set<String>('name', name);
                widget.product.set<String>('quantity', quantity);
                widget.product.set<String>('totalCostPrice', totalCostPrice);

                // Salvar o produto no servidor Parse
                widget.product.save();

                // Voltar para a página anterior
                Navigator.pop(context);
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
