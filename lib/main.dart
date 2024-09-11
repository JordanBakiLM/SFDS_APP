import 'package:flutter/material.dart';
import 'package:sfds_app/interface/acceuil.dart';
import 'package:sfds_app/interface/splashscreen.dart';
import 'package:sfds_app/requetes/base_de_donne.dart';
// import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
  BaseDeDonne.create();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Acceuil(),
    );
  }
}

class Couleur {
  static Color violet1 = const Color.fromRGBO(40, 40, 91, 1);
  static Color violet2 = const Color.fromRGBO(129, 126, 170, 1);
  static Color violet3 = const Color.fromRGBO(204, 203, 221, 1);
  static Color violet4 = const Color.fromRGBO(104, 100, 151, 1);
}
