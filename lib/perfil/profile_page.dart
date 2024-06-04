import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  String _username = "Usuário";
  String _companyName = "Nome da Empresa";
  String _email = "user@example.com";
  String _password = "********";

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

  void _logout() async {
    await ParseUser.currentUser().then((user) async {
      if (user != null) {
        await user.logout();
        Navigator.pushReplacementNamed(context, '/login');
      }
    });
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
                _updateUserDetails();
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _editCompanyName() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final TextEditingController _newCompanyNameController =
            TextEditingController();

        return AlertDialog(
          title: Text('Editar Nome da Empresa'),
          content: TextField(
            controller: _newCompanyNameController,
            decoration: InputDecoration(
              labelText: 'Novo Nome da Empresa',
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
                  _companyName = _newCompanyNameController.text;
                });
                Navigator.of(context).pop(_companyName);
                _updateUserDetails();
              },
              child: Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _updateUserDetails() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      user.set('username', _username);
      user.set('companyName', _companyName);
      await user.save();
    }
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
              Divider(),
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

  Future<void> _fetchCredentials() async {
    final user = await ParseUser.currentUser() as ParseUser?;
    if (user != null) {
      setState(() {
        _username = user.username!;
        _email = user.emailAddress!;
        _companyName = user.get<String>('companyName') ?? 'Nome da Empresa';
        _password = user.password ?? '********';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(114, 133, 202, 1),
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
        title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Perfil'),
        ]),
      ),
      body: Container(
        color: Color.fromRGBO(114, 133, 202, 1),
        child: Padding(
          padding: const EdgeInsets.all(36.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 20),
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: _image != null ? FileImage(_image!) : null,
                    child: _image == null
                        ? Icon(Icons.add_a_photo, size: 60)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _pickImage,
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(226, 153, 66, 1),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 25),
                ),
                child: Text('Escolher Foto', style: TextStyle(fontSize: 18)),
              ),
              SizedBox(height: 40),
              _buildEditableField(
                label: 'Nome de Usuário',
                value: _username,
                onEdit: _editUsername,
              ),
              Divider(color: Colors.white),
              _buildEditableField(
                label: 'Nome da Empresa',
                value: _companyName,
                onEdit: _editCompanyName,
              ),
              Divider(color: Colors.white),
              _buildEditableField(
                label: 'Minhas Credenciais',
                value: '',
                onEdit: _showCredentials,
                showIcon: true,
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: _logout,
                child: Text('Sair / Alterar Conta',
                    style: TextStyle(fontSize: 18)),
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(226, 153, 66, 1),
                  onPrimary: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 25),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField({
    required String label,
    required String value,
    required VoidCallback onEdit,
    bool showIcon = false,
  }) {
    return Row(
      children: [
        Expanded(
          child: Text(
            value.isNotEmpty ? value : label,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
        SizedBox(width: 12),
        IconButton(
          icon: Icon(showIcon ? Icons.visibility : Icons.edit,
              color: Colors.white, size: 28),
          onPressed: onEdit,
        ),
      ],
    );
  }
}
