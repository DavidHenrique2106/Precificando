import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:flora/homeUser/home_page.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  int _selectedIndex = 0;
  File? _image;
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _companyNameController = TextEditingController();
  String _username = "Usuário";
  String _companyName = "Nome da Empresa";
  String _email = "user@example.com";
  String _password = "********";

  Widget _buildIconWithLabel(IconData icon, bool isSelected) {
    return Container(
      width: 30,
      height: 30,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color:
            isSelected ? Color.fromRGBO(226, 153, 66, 1) : Colors.transparent,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 25,
            color: isSelected ? Colors.white : Colors.black,
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
        
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage()),
        );
      } else {
        _selectedIndex = index;
      }
    });
  }

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
          automaticallyImplyLeading: false,
          backgroundColor: Color.fromRGBO(114, 133, 202, 1),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Perfil'),
            ],
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 24,
          )),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
                      backgroundImage:
                          _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(Icons.add_a_photo, size: 60)
                          : null,
                    ),
                  ),
                ),
                SizedBox(height: 50),
            ElevatedButton(
              onPressed: _pickImage,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 25),
              ).copyWith(
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (Set<MaterialState> states) {
                    return Color.fromRGBO(226, 153, 66, 1);
                  },
                ),

              ),
              child: Text('Escolher Foto', style: TextStyle(fontSize: 18)),
            ),
                SizedBox(height: 30),
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
                SizedBox(height: 50),
                ElevatedButton(
                  onPressed: _logout,
                  child: Text('Sair / Alterar Conta', style: TextStyle(fontSize: 18)),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 25),
                  ).copyWith(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                          (Set<MaterialState> states) {
                        return Color.fromRGBO(226, 153, 66, 1);
                      },
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          textTheme: Theme.of(context).textTheme.copyWith(
                bodySmall: TextStyle(color: Colors.white),
              ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Color.fromRGBO(114, 133, 202, 1),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: _buildIconWithLabel(Icons.home, _selectedIndex == 0),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithLabel(
                Icons.currency_exchange_outlined,
                _selectedIndex == 1,
              ),
              label: 'Finanças',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: _buildIconWithLabel(Icons.person, _selectedIndex == 2),
              label: 'Perfil',
              backgroundColor: Colors.white,
            ),
          ],
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
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
      InkWell(
        onTap: onEdit,
        child: Icon(showIcon ? Icons.visibility : Icons.edit,
            color: Colors.white, size: 28),
      ),
    ],
  );
}
