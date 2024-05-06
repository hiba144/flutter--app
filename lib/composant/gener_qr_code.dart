import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';

class genere_qr_code extends StatefulWidget {
  @override
  _GenereQRCodeState createState() => _GenereQRCodeState();
}

class _GenereQRCodeState extends State<genere_qr_code> {
  late String _url; // Lien URL pour le code QR

  @override
  void initState() {
    super.initState();
    _url = ''; // Initialiser avec une chaîne vide
  }

  // Méthode pour envoyer le lien au backend
  Future<void> _enregistrerLien(String url) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.16.1:3000/lien/addlien'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'url': url}),
      );

      if (response.statusCode == 201) {
        // L'enregistrement a réussi
        print('Lien enregistré avec succès');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Lien enregistré avec succès'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // L'enregistrement a échoué
        print(
            'Erreur lors de l\'enregistrement du lien: ${response.statusCode}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Erreur lors de l\'enregistrement du lien: ${response.statusCode}'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (error) {
      print('Erreur: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur: $error'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('QR Code Generator'),
        backgroundColor: Colors.pink,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: _url,
                version: QrVersions.auto,
                size: 200.0,
              ),
              SizedBox(height: 20.0),
              Text(
                'Scan the QR code',
                style: TextStyle(fontSize: 20.0),
              ),
              SizedBox(height: 20.0),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Enter URL',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _url = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _enregistrerLien(_url);
                    },
                    child: Text('Enregistrer'),
                  ),
                  SizedBox(width: 20.0), // Espacement entre les boutons
                  ElevatedButton(
                    onPressed: () {
                      // Ajoutez ici la logique pour le bouton imprimer
                    },
                    child: Text('Imprimer'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
