import 'package:flutter/material.dart';
import 'package:flora/loginUser/register_page.dart';
import 'package:flora/homeUser/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Ellipses with Blur Effect
          Positioned(
            left: 186,
            top: 297,
            child: Container(
              width: 204,
              height: 163,
              decoration: BoxDecoration(
                color: Color(0xFF0029FF).withOpacity(0.6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF0029FF).withOpacity(0.6),
                    blurRadius: 125,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -25,
            top: 231,
            child: Container(
              width: 204,
              height: 163,
              decoration: BoxDecoration(
                color: Color(0xFFE29942).withOpacity(0.6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE29942).withOpacity(0.6),
                    blurRadius: 125,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -47,
            top: 482,
            child: Container(
              width: 204,
              height: 163,
              decoration: BoxDecoration(
                color: Color(0xFFE29942).withOpacity(0.6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE29942).withOpacity(0.6),
                    blurRadius: 125,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: -214,
            top: 943,
            child: Container(
              width: 204,
              height: 163,
              decoration: BoxDecoration(
                color: Color(0xFF0029FF).withOpacity(0.6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF0029FF).withOpacity(0.6),
                    blurRadius: 150,
                    spreadRadius: 50,
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: Container(
              width: 350,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    spreadRadius: 7,
                    blurRadius: 4,
                    offset: Offset(7, 7),
                  ),
                ],
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Alinhar no início
                children: [
                  Text(
                    'Entrar',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                      height: 1.5,
                      color: Color(0xFF1E1D1D),
                      shadows: [
                        Shadow(
                          offset: Offset(0, 4),
                          blurRadius: 4,
                          color: Color(0x40000000),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: 299,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFC1C1C1),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: _emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                fontSize: 24,
                                color: Colors.black,
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu email';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          width: 299,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFC1C1C1),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                hintText: 'Senha',
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(horizontal: 10),
                              ),
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.w300,
                                fontSize: 24,
                                color: Colors.black,
                              ),
                              obscureText: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira sua senha';
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GestureDetector(
                          onTap: () {
                            if (_formKey.currentState!.validate()) {
                              // Implementar lógica de login
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text('Login bem-sucedido')));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MyHomePage()),
                              );
                            }
                          },
                          child: Container(
                            width: 299,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Color(0xFF5966AB),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  spreadRadius: 0,
                                  blurRadius: 30,
                                  offset: Offset(0, 30),
                                ),
                              ],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                            child: Center(
                              child: Text(
                                'Entrar',
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300,
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    width: 332,
                    height: 1,
                    color: Colors.black,
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage()),
                      );
                    },
                    child: Text(
                      'Não tem conta? Cadastre-se',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color(0xFF646464),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
