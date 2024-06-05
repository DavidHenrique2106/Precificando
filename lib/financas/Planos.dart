import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flora/perfil/profile_page.dart';
import 'package:flora/homeUser/home_page.dart';
import 'package:flora/financas/Planos.dart';
import 'package:flora/financas/dashboard.dart';
import 'package:flutter/widgets.dart';

class CarouselScreen extends StatefulWidget {
  @override
  _CarouselScreenState createState() => _CarouselScreenState();
}

class _CarouselScreenState extends State<CarouselScreen> {
  final CarouselController _controller = CarouselController();
  int _currentIndex = 0;
  int _selectedIndex = 0;

  final List<Map<String, dynamic>> plans = [
    {
      'title': 'Plano Básico',
      'price': 'Gratuito',
      'benefits': [
        'Análise de mercado para determinar preços competitivos.',
        'Suporte via video-chamada para dúvidas e consultas básicas.',
        'Acesso a recursos educacionais online sobre estratégias de precificação.',
      ],
    },
    {
      'title': 'Plano Padrão',
      'price': 'R\$ 29,90/mês',
      'benefits': [
        'Avaliação abrangente da estrutura de preços e custos operacionais.',
        'Desenvolvimento de estratégias personalizadas de precificação.',
      ],
    },
    {
      'title': 'Plano Premium',
      'price': 'R\$ 39,90/mês',
      'benefits': [
        'Consultoria presencial para revisão detalhada da operação e precificação.',
        'Implementação de ferramentas de análise de dados para monitoramento contínuo de desempenho.',
        'Treinamento personalizado para equipe de gestão sobre técnicas avançadas de precificação.',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16.0),
                    bottomRight: Radius.circular(16.0),
                  ),
                  color: Color.fromRGBO(114, 133, 202, 1),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top:
                                  42.0), // Adicione o valor desejado para o padding top
                          height: 200,
                          width: 200,
                          child: Image.asset('lib/assets/preci.png'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              FittedBox(
                child: Text(
                  plans[_currentIndex]['title'],
                  style: TextStyle(
                    fontSize: 24, // Tamanho original do título
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                plans[_currentIndex]['price'],
                style: TextStyle(
                  fontSize: 20, // Tamanho original do preço
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(114, 133, 202, 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      icon:
                          Icon(Icons.arrow_back, size: 30, color: Colors.white),
                      onPressed: () => _controller.previousPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      ),
                      splashRadius: 25,
                      padding: EdgeInsets.all(0),
                      iconSize: 50,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: CarouselSlider.builder(
                        carouselController: _controller,
                        options: CarouselOptions(
                          height: 400.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          aspectRatio: 16 / 9,
                          autoPlayInterval: Duration(seconds: 3),
                          autoPlayAnimationDuration:
                              Duration(milliseconds: 800),
                          autoPlayCurve: Curves.fastOutSlowIn,
                          pauseAutoPlayOnTouch: true,
                          viewportFraction: 0.8,
                          onPageChanged: (index, reason) {
                            setState(() {
                              _currentIndex = index;
                            });
                          },
                        ),
                        itemCount: plans.length,
                        itemBuilder: (context, index, realIndex) {
                          final plan = plans[index];
                          return PlanCard(
                            benefits: plan['benefits'],
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(114, 133, 202, 1),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_forward,
                          size: 30, color: Colors.white),
                      onPressed: () => _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.linear,
                      ),
                      splashRadius: 25,
                      padding: EdgeInsets.all(0),
                      iconSize: 50,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ação para escolher o plano
                  print('Plano escolhido: ${plans[_currentIndex]['title']}');
                },
                child: Text(
                  'Escolher Plano',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0C9239),
                ),
              ),
              SizedBox(height: 80),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
                caption: TextStyle(color: Colors.white),
              ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
          child: BottomNavigationBar(
            backgroundColor: Color.fromRGBO(114, 133, 202, 1),
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: _buildIconWithLabel(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: _buildIconWithLabel(Icons.attach_money),
                label: 'Finanças',
              ),
              BottomNavigationBarItem(
                icon: _buildIconWithLabel(Icons.person),
                label: 'Perfil',
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DashboardPage()),
        );

      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      }
    });
  }

  Widget _buildIconWithLabel(IconData icon) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: Colors.black,
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  final List<String> benefits;

  PlanCard({
    required this.benefits,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: Color.fromRGBO(114, 133, 202, 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: benefits.map((benefit) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                children: [
                  Icon(Icons.check, color: Colors.green),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      benefit,
                      style: TextStyle(
                        fontSize:
                            15, // Aumentando o tamanho da fonte dos benefícios
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
