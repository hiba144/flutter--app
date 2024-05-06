import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class liste_lien extends StatefulWidget {
  @override
  _ListeLienState createState() => _ListeLienState();
}

class _ListeLienState extends State<liste_lien> {
  List<String> urls = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text('Liste des liens'),
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
            onPressed: fetchLiens,
            child: Text('Afficher tous les liens'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: urls.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      title: Text(urls[index]),
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

  Future<void> fetchLiens() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.16.1:3000/lien/alllien'));
      if (response.statusCode == 200) {
        final liens = json.decode(response.body);
        final List<String> extractedUrls =
            liens.map<String>((lien) => lien['url'] as String).toList();
        setState(() {
          urls = extractedUrls;
        });
      } else {
        throw Exception('Failed to load liens');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
