import 'package:flutter/material.dart';

import 'package:flora/homeUser/home_page.dart'; // Certifique-se de atualizar o caminho

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF4D5BAE), Color(0xFF3C5AB6)],
          ),
        ),
        child: const Text(
          'PRODUTOS',
          style: TextStyle(
            fontSize: 36.0,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
