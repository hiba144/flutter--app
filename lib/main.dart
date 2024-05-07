import 'package:flutter/material.dart';

import 'composant/admin_registre.dart';
import 'composant/ajout_user.dart';
import 'composant/ajouter_video.dart';
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
      '/authenc': (context) => Authen(),
      '/welcome': (context) => LireQRCodePage(),
      '/hello': (context) => Welcomeadmin(),
      '/genere': (context) => genere_qr_code(),
      '/lire': (context) => LireQRCodePage(),
      '/profil': (context) => ProfilePage(),
      '/update': (context) => UpdatePage(),
      '/dec': (context) => onpage(),
      '/contactez-nous': (context) => ContactPage(),
      '/ajout_admin': (context) => AjoutAdmin(),
      '/lutlil': (context) => liste_user(),
      '/video': (context) => VideoQrCode(),
      '/llien': (context) => liste_lien()
    },
  ));
}
