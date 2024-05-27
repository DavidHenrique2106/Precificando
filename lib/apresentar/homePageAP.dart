import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flora/loginUser/login_page.dart';

class HomeApresenta extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF8397FF),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/Preci.svg', // caminho para a primeira imagem
                height: 100, // ajuste o tamanho conforme necessário
              ),
              SizedBox(height: 16),
              Text(
                'Bem-vindo ao Precificando',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              SvgPicture.asset(
                'assets/Group.svg', // caminho para a segunda imagem
                height: 100, // ajuste o tamanho conforme necessário
              ),
              SizedBox(height: 16),
              Text(
                'Gerencie suas finanças na palma da sua mão.',
                style: TextStyle(
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  // navegar para a próxima página
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('COMEÇAR'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
