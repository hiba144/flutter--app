import 'package:flutter/material.dart';

class Welcomeadmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('bienvenu'),
        backgroundColor: Colors.pink,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.pink,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'QR_FIT',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.qr_code),
              title: Text('Générer QR Code'),
              onTap: () {
                Navigator.pushNamed(context, '/genere');
              },
            ),
            ListTile(
              leading: Icon(Icons.qr_code_scanner),
              title: Text('Lire QR Code'),
              onTap: () {
                Navigator.pushNamed(context, '/lire');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Ajouter un utilisateur'),
              onTap: () {
                Navigator.pushNamed(context, '/profil');
              },
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('ajouter un admin'),
              onTap: () {
                Navigator.pushNamed(context, '/ajout_admin');
              },
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Mettre à jour l\'utilisateur'),
              onTap: () {
                Navigator.pushNamed(context, '/update');
              },
            ),
            ListTile(
              leading: Icon(Icons
                  .check_circle_rounded), // Use check_circle_rounded instead of Icons.edit
              title: Text('Liste des utilisateurs'),
              onTap: () {
                Navigator.pushNamed(context, '/lutlil');
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle_rounded),
              title: Text('listes des liens'),
              onTap: () {
                Navigator.pushNamed(context, '/llien');
              },
            ),
            ListTile(
              leading: Icon(Icons.check_circle_rounded),
              title: Text('Ajouter_Video'),
              onTap: () {
                Navigator.pushNamed(context, '/video');
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Déconnexion'),
              onTap: () {
                Navigator.pushNamed(context, '/dec');
                // Ajouter ici la logique de déconnexion
              },
            ),
          ],
        ),
      ),
    );
  }
}
