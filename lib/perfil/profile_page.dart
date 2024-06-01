import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  String _username = "Usuário";
  String _email = "user@example.com"; // Placeholder email
  String _password = "********"; // Placeholder password

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  void _logout() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _editUsername() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _newUsernameController =
            TextEditingController();

        return AlertDialog(
          title: Text('Editar Nome de Usuário'),
          content: TextField(
            controller: _newUsernameController,
            decoration: InputDecoration(
              labelText: 'Novo Nome de Usuário',
              border: OutlineInputBorder(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _username = _newUsernameController.text;
                });
                Navigator.of(context).pop();
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _showCredentials() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Minhas Credenciais'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Email: $_email'),
              Text('Senha: $_password'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  // Função placeholder para buscar credenciais do BD
  Future<void> _fetchCredentials() async {
    // Lógica para buscar credenciais do BD será implementada aqui.
    // Por enquanto, estamos usando placeholders.
  }

  @override
  void initState() {
    super.initState();
    _fetchCredentials(); // Buscar credenciais quando a página é inicializada
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: _pickImage,
          child: CircleAvatar(
            backgroundImage: _image != null ? FileImage(_image!) : null,
            child: _image == null ? Icon(Icons.add_a_photo) : null,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _username,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: _editUsername,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Minhas Credenciais',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.visibility),
                  onPressed: _showCredentials,
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _logout,
              child: Text('Sair / Alterar Conta'),
            ),
          ],
        ),
      ),
    );
  }
}
