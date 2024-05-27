import 'package:flutter/material.dart';

class CardapioScreen extends StatelessWidget {
  const CardapioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cardápio"),
      ),
      body: const Center(
        child: Text("Tela de Cardápio"),
      ),
    );
  }
}
