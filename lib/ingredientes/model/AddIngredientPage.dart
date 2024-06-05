import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class AddIngredientPage extends StatefulWidget {
  @override
  _AddIngredientPageState createState() => _AddIngredientPageState();
}

class _AddIngredientPageState extends State<AddIngredientPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController totalCostPriceController = TextEditingController();

  double costPricePerUnit = 0.0;
  double totalCostPrice = 0.0;
  String selectedUnitType = 'kgs';

  final List<String> unitTypes = ['kgs', 'mls', 'unidades'];

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
            DropdownButtonFormField<String>(
              value: selectedUnitType,
              items: unitTypes.map((String unitType) {
                return DropdownMenuItem<String>(
                  value: unitType,
                  child: Text(unitType),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedUnitType = newValue!;
                  calculateCostPricePerUnit();
                });
              },
              decoration: InputDecoration(labelText: 'Tipo de Quantitativo'),
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
            Text('Preço por ${selectedUnitType.substring(0, selectedUnitType.length - 1)}: R\$ ${costPricePerUnit.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
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

  void addIngredientToParse() async {
    try {
      final currentUser = await ParseUser.currentUser();

      if (currentUser != null) {
        String name = nameController.text;
        double quantity = double.tryParse(quantityController.text) ?? 0.0;
        double totalCostPrice = double.tryParse(totalCostPriceController.text) ?? 0.0;

        final ingredient = ParseObject('Ingredients')
          ..set('name', name)
          ..set('quantity', quantity)
          ..set('totalCost', totalCostPrice) // Salva o preço total de compra
          ..set('costPricePerUnit', costPricePerUnit) // Salva o custo unitário calculado
          ..set('unitType', selectedUnitType); // Salva o tipo de quantitativo

        final acl = ParseACL(owner: currentUser);
        ingredient.setACL(acl);

        final response = await ingredient.save();
        if (response.success) {
          // Retornar um indicador de sucesso sem enviar o nome do ingrediente
          Navigator.pop(context, true);
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
