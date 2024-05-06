import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class liste_user extends StatefulWidget {
  @override
  _ListeUtilisateursState createState() => _ListeUtilisateursState();
}

class _ListeUtilisateursState extends State<liste_user> {
  List<Map<String, dynamic>> utilisateurs = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Liste des utilisateurs'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: fetchUtilisateurs,
            child: Text('Afficher tous les utilisateurs'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: utilisateurs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white, // Couleur du cadre noir
                    ),
                    child: ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Nom: ${utilisateurs[index]['name']}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              'Email: ${utilisateurs[index]['email']}',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> fetchUtilisateurs() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.16.1:3000/user/all'));
      if (response.statusCode == 200) {
        final users = json.decode(response.body);
        setState(() {
          utilisateurs = List<Map<String, dynamic>>.from(users);
        });
      } else {
        throw Exception('Failed to load utilisateurs');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
