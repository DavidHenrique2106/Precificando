import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  RegisterPageState createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final cepController = TextEditingController();
  final cpfController = TextEditingController();

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
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SizedBox(height: 30),
                            TextField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                hintText: 'Nome completo',
                              ),
                              obscureText: false,
                              maxLines: 1,
                              // Allows for more lines
                            ),
                            SizedBox(height: 20), // Added padding
                            TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                hintText: 'Email',
                              ),
                              obscureText: false,
                              maxLines: 1, // Allows for more lines
                            ),
                            SizedBox(height: 20), // Added padding
                            TextField(
                              controller: cpfController,
                              decoration: InputDecoration(
                                hintText: 'CPF',
                              ),
                              obscureText: false,
                              maxLines: 1,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.-]')), // Only allows numbers
                                LengthLimitingTextInputFormatter(
                                    14), // Limits input to 11 characters
                              ],
                            ),
                            SizedBox(height: 20), // Added padding
                            TextField(
                              controller: cepController,
                              decoration: InputDecoration(
                                hintText: 'CEP',
                              ),
                              obscureText: false,
                              maxLines: 1,
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[0-9.-]')),
                                LengthLimitingTextInputFormatter(10),
                              ], // Allows for more lines
                            ),
                            SizedBox(height: 20), // Added padding
                            TextField(
                              controller: passwordController,
                              decoration: InputDecoration(hintText: 'Senha'),
                              obscureText: true,
                              maxLines: 1, // Allows for more lines
                            ),
                            SizedBox(height: 20),
                            GestureDetector(
                              onTap: () {
                                if (formKey.currentState!.validate()) {
                                  doUserRegistration();
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
                                    'Criar conta',
                                    style: TextStyle(color: Colors.white),
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
                // Already have an account? Go to Login
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

  void showSuccess() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Sucesso!"),
          content: const Text("Seu cadastro foi realizado!"),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void showError(String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error!"),
          content: Text(errorMessage),
          actions: <Widget>[
            new TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void doUserRegistration() async {
    final username = usernameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final cep = cepController.text.trim();
    final cpf = cpfController.text.trim();

    final user = ParseUser.createUser(username, password, email);

    user.set<String>('cep', cep);
    user.set<String>('cpf', cpf);

    var response = await user.signUp();

    if (response.success) {
      showSuccess();
    } else {
      showError(response.error!.message);
    }
  }
}
