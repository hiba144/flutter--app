import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _obscurePassword = true; // Pour gérer l'état du masquage du mot de passe

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Ajouter un utilisateur'),
        backgroundColor: Colors.pink,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildTextFieldWithLabel(_firstNameController, 'Prénom'),
              SizedBox(height: 20),
              _buildTextFieldWithLabel(_lastNameController, 'Nom'),
              SizedBox(height: 20),
              _buildTextFieldWithLabel(_emailController, 'Email'),
              SizedBox(height: 20),
              _buildTextFieldWithLabel(_ageController, 'Age'),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: TextField(
                  controller: _passwordController,
                  obscureText:
                      _obscurePassword, // Masquer le texte du mot de passe si true
                  decoration: InputDecoration(
                    labelText: 'Mot de passe',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(12.0),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        // Inverser l'état du masquage du mot de passe
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  _saveProfile(context);
                },
                child: Text('Ajouter utilisateur'),
              ),
            ],
          ),
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

  void _saveProfile(BuildContext context) async {
    String firstName = _firstNameController.text;
    String lastName = _lastNameController.text;
    String email = _emailController.text;
    String age = _ageController.text;
    String password = _passwordController.text;

    // Vérifier que tous les champs sont remplis
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        email.isEmpty ||
        age.isEmpty ||
        password.isEmpty) {
      _showAlertDialog(
          context, 'Champs obligatoires', 'Veuillez remplir tous les champs.');
      return;
    }

    // Préparer les données à envoyer au backend
    Map<String, dynamic> userData = {
      'name': firstName,
      'lastname': lastName,
      'email': email,
      'age': age,
      'password': password,
    };

    // Envoyer les données au backend
    try {
      final response = await http.post(
        Uri.parse('http://192.168.16.1:3000/user/register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData),
      );

      if (response.statusCode == 201) {
        _showAlertDialog(context, 'Profil enregistré',
            'Le profil de $firstName $lastName a été enregistré avec succès.');
      } else {
        _showAlertDialog(context, 'Erreur',
            'Une erreur est survenue lors de l\'enregistrement du profil.');
      }
    } catch (e) {
      print('Error: $e');
      _showAlertDialog(context, 'Erreur',
          'Une erreur est survenue lors de l\'enregistrement du profil.');
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
