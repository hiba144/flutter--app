import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AjoutAdmin extends StatefulWidget {
  @override
  _AjoutAdminState createState() => _AjoutAdminState();
}

class _AjoutAdminState extends State<AjoutAdmin> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter un administrateur'),
        backgroundColor: Colors.pink[700],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTextFieldWithLabel(_firstNameController, 'Prénom'),
            SizedBox(height: 20),
            _buildTextFieldWithLabel(_emailController, 'Adresse email'),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: _obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Mot de passe',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(12.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(_obscurePassword
                      ? Icons.visibility
                      : Icons.visibility_off),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _validateAndSave();
              },
              child: Text('Ajouter administrateur'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextFieldWithLabel(
      TextEditingController controller, String labelText) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12.0),
        ),
      ),
    );
  }

  void _validateAndSave() async {
    if (_firstNameController.text.isEmpty ||
        _emailController.text.isEmpty ||
        _passwordController.text.isEmpty) {
      _showAlertDialog(
          context, 'Remplir les champs', 'Veuillez remplir tous les champs.');
    } else {
      try {
        final response = await http.post(
          Uri.parse('http://192.168.16.1:3000/admin/add'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            'name': _firstNameController.text,
            'email': _emailController.text,
            'password': _passwordController.text,
          }),
        );

        if (response.statusCode == 200) {
          _showAlertDialog(
              context, 'Succès', 'Administrateur ajouté avec succès.');
        } else {
          _showAlertDialog(context, 'Erreur',
              'Une erreur est survenue lors de l\'ajout de l\'administrateur.');
        }
      } catch (e) {
        print('Error: $e');
        _showAlertDialog(context, 'Erreur',
            'Une erreur est survenue lors de l\'ajout de l\'administrateur.');
      }
    }
  }

  void _showAlertDialog(BuildContext context, String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
