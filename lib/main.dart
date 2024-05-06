import 'package:flutter/material.dart';

import 'composant/admin_registre.dart';
import 'composant/ajout_user.dart';
import 'composant/authadmin.dart';
import 'composant/authentication.dart';
import 'composant/contactez_nous.dart';
import 'composant/gener_qr_code.dart';
import 'composant/lire_qr_code.dart';
import 'composant/liste_lien.dart';
import 'composant/liste_utilisateur.dart';
import 'composant/onpage.dart';
import 'composant/update_user.dart';
import 'composant/zonne_admin.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: '/',
    routes: {
      '/': (context) => onpage(),
      '/authentication': (context) => authentication(),
      '/authenc': (context) =>
          Authen(), //hethy f authadminclass class\ authen/  extends StatelessWidget {
      // //hethi f page onpage:   Navigator.pushNamed(context, '/authenc');

      '/welcome': (context) => lire_qr_code(),
      '/hello': (context) => Welcomeadmin(),
      '/genere': (context) => genere_qr_code(),
      '/lire': (context) => lire_qr_code(),
      '/profil': (context) => ProfilePage(),
      '/update': (context) => UpdatePage(),
      '/dec': (context) => onpage(),
      '/contactez-nous': (context) => ContactPage(),
      '/ajout_admin': (context) => AjoutAdmin(),
      '/lutlil': (context) => liste_user(),
      '/llien': (context) => liste_lien()
    },
  ));
}
