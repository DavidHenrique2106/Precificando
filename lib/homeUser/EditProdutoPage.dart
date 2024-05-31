import 'package:flutter/material.dart';
import 'cardapio_screen.dart';

class EditProductPage extends StatefulWidget {
  final int index;
  final List<String> products;
  EditProductPage(this.index, this.products);
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
    List<String> productParts = widget.products[widget.index].split(' - ');
    nameController = TextEditingController(text: productParts[0]);
    quantityController = TextEditingController(text: productParts[1]);
    totalCostPriceController =
        TextEditingController(text: productParts[2].replaceAll(' ', ''));
  }

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
                // Montar o ingrediente atualizado
                String updatedIngredient =
                    '$name - $quantity - $totalCostPrice - $costPricePerUnit';
                // Atualizar a lista de ingredientes com o ingrediente atualizado
                widget.products[widget.index] = updatedIngredient;
                // Voltar para a página anterior com a lista atualizada de ingredientes
                Navigator.pop(context, widget.products);
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
