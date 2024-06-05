import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class EditIngredientPage extends StatefulWidget {
  final String objectId; // Identificador único do objeto no Parse
  final String name;
  final int quantity;
  final int totalCost;
  final double unitCostPrice;

  const EditIngredientPage({
    required this.objectId,
    required this.name,
    required this.quantity,
    required this.totalCost,
    required this.unitCostPrice, required String unitType,
  });

  @override
  _EditIngredientPageState createState() => _EditIngredientPageState();
}

class _EditIngredientPageState extends State<EditIngredientPage> {
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late TextEditingController _totalCostController;
  late double _unitCostPrice;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _quantityController = TextEditingController(text: widget.quantity.toString());
    _totalCostController = TextEditingController(text: widget.totalCost.toString());
    _unitCostPrice = widget.unitCostPrice;
    _quantityController.addListener(_updateUnitCostPrice);
    _totalCostController.addListener(_updateUnitCostPrice);
  }

  void _updateUnitCostPrice() {
    final int quantity = int.tryParse(_quantityController.text) ?? 0;
    final int totalCost = int.tryParse(_totalCostController.text) ?? 0;

    setState(() {
      _unitCostPrice = quantity != 0 ? totalCost / quantity : 0.0;
    });
  }

  Future<void> _updateIngredient(BuildContext context, String newName, int newQuantity, int newTotalCost) async {
    final ParseObject ingredient = ParseObject('Ingredients')
      ..objectId = widget.objectId
      ..set<String>('name', newName)
      ..set<int>('quantity', newQuantity)
      ..set<int>('totalCost', newTotalCost)
      ..set<double>('unitCostPrice', _unitCostPrice);

    final ParseResponse response = await ingredient.save();

    if (response.success) {
      // Ingredient updated successfully
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ingrediente atualizado com sucesso.'),
        ),
      );

      // Retornar para a página anterior (lista de ingredientes)
      Navigator.pop(context, true); // Envie true para indicar que as alterações foram feitas com sucesso
    } else {
      // Error updating ingredient
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao atualizar ingrediente: ${response.error!.message}'),
        ),
      );
    }
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
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Nome'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Quantidade'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _totalCostController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Custo Total'),
            ),
            SizedBox(height: 16.0),
            Text('Preço Unitário: ${_unitCostPrice.toStringAsFixed(2)}'),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                String newName = _nameController.text;
                int newQuantity = int.parse(_quantityController.text);
                int newTotalCost = int.parse(_totalCostController.text);

                await _updateIngredient(context, newName, newQuantity, newTotalCost);
              },
              child: Text('Salvar Alterações'),
            ),
          ],
        ),
      ),
    );
  }
}
