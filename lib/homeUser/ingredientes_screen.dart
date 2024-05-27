import 'package:flutter/material.dart';

class IngredientesScreen extends StatelessWidget {
  const IngredientesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ingredientes"),
      ),
      body: const Center(
        child: Text("Tela de Ingredientes"),
      ),
    );
  }
}
