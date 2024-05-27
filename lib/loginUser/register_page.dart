import 'package:flutter/material.dart';
import 'package:flora/loginUser/login_page.dart'; // Importe a página de login

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _establishmentNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: 390,
            height: 844,
            child: Stack(
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
                      color: Color(0xFF3D39FF).withOpacity(0.6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF3D39FF).withOpacity(0.6),
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
                      color: Color(0xFF3C37B7).withOpacity(0.6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF3C37B7).withOpacity(0.6),
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
                // Line
                Positioned(
                  left: 32,
                  top: 604,
                  child: Container(
                    width: 332,
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                // Rectangle
                Positioned(
                  left: 20,
                  top: 170,
                  child: Container(
                    width: 350,
                    height: 500, // Original height
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
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 30),
                            _buildTextField(
                              controller: _nameController,
                              hintText: 'Nome completo',
                              obscureText: false,
                              maxLines: 1, // Allows for more lines
                            ),
                            SizedBox(height: 20), // Added padding
                            _buildTextField(
                              controller: _emailController,
                              hintText: 'Email',
                              obscureText: false,
                              maxLines: 1, // Allows for more lines
                            ),
                            SizedBox(height: 20), // Added padding
                            _buildTextField(
                              controller: _phoneController,
                              hintText: 'Telefone',
                              obscureText: false,
                              maxLines: 1, // Allows for more lines
                            ),
                            SizedBox(height: 20), // Added padding
                            _buildTextField(
                              controller: _establishmentNameController,
                              hintText: 'Nome do estabelecimento',
                              obscureText: false,
                              maxLines: 1, // Allows for more lines
                            ),
                            SizedBox(height: 20), // Added padding
                            _buildTextField(
                              controller: _passwordController,
                              hintText: 'Senha',
                              obscureText: true,
                              maxLines: 1, // Allows for more lines
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  // Implementar lógica de cadastro
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Cadastro bem-sucedido'),
                                    ),
                                  );
                                  // Retorna para a página de login
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginPage()),
                                  );
                                }
                              },
                              child: Container(
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
                                    'Criar Conta',
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
                    ),
                  ),
                ),
                // Já tem conta? Faça o Login
                Positioned(
                  left: 32,
                  top: 629,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Já tem conta? Faça o Login',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w300,
                        fontSize: 16,
                        color: Color(0xFF646464),
                      ),
                    ),
                  ),
                ),
                // Preci Text
                Positioned(
                  left: 32,
                  top: 676,
                  child: Text(
                    'Preci',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 28,
                      color: Color(0xFFE29942),
                    ),
                  ),
                ),
                // Ficando Text
                Positioned(
                  left: 32,
                  top: 702,
                  child: Text(
                    'Ficando',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w700,
                      fontSize: 22,
                      color: Color(0xFF3F53BE),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required int maxLines, // Added maxLines parameter
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      maxLines: maxLines, // Added maxLines
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: Color(0xFFC1C1C1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 18,
        ), // Increased vertical padding
      ),
      style: TextStyle(
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w300,
        fontSize: 18,
        color: Colors.black,
      ),
    );
  }
}
