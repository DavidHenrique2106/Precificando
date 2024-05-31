import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flora/loginUser/register_page.dart';
import 'package:flora/homeUser/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final keyApplicationId = 'MGrlk40ufPq0FndIImuk7VlzJb7FSsj1NHHgtuVP';
  final keyClientKey = 'ZeIrpHMzxeruZCcYQFOmvI5duT6wpGLUJVOWMsMQ';
  final keyParseServerUrl = 'https://parseapi.back4app.com';

  await Parse().initialize(keyApplicationId, keyParseServerUrl,
      clientKey: keyClientKey, debug: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login/Logout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  bool isLoading = false;
  bool isLoggedIn = false;

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
            top: 230,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                              controller: controllerEmail,
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
                          width: 300,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Color(0xFFC1C1C1),
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          child: Center(
                            child: TextFormField(
                              controller: controllerPassword,
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
                              doUserLogin();
                            }
                          },
                          child: Container(
                            width: 300,
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

  void showSuccess(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Boa!"),
          content: Text(message),
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
          title: const Text("Erro!"),
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

  void doUserLogin() async {
    // Obtenha o email e a senha dos controladores de texto
    final email = controllerEmail.text.trim();
    final password = controllerPassword.text.trim();

    try {
      // Crie uma nova instância de ParseUser

      final user = ParseUser(email, password, null);

      // Chame o método de login na instância de ParseUser
      final response = await user.login();

      // Verifique se o login foi bem-sucedido
      if (response.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        showSuccess("Usuário logado com sucesso!");
        setState(() {
          isLoggedIn = true;
        });
      } else {
        // Se o login não for bem-sucedido, exiba uma mensagem de erro
        showError(response.error!.message ?? "Erro durante o login");
      }
    } catch (e) {
      // Em caso de erro durante o login, exiba uma mensagem de erro genérica
      showError("Ocorreu um erro durante o login.");
    }
  }
}
