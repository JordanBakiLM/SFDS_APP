import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sfds_app/interface/acceuil.dart';
import 'package:sfds_app/main.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Splashscreen();
  }
}

class _Splashscreen extends State<Splashscreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const Acceuil()));
    });
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: Container(
              margin: EdgeInsets.only(
                left: largeur / 7,
                right: largeur / 7,
                top: hauteur / 4
              ),
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/Logo_sans_texte.png',
              ),
            ),
          ),
          Center(
            child: Container(
              margin: EdgeInsets.only(bottom: hauteur / 19),
              color: Colors.transparent,
              child: RichText(
                text: TextSpan(
                    text: 'By',
                    style: const TextStyle(color: Colors.black, fontSize: 22),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' SFDS Team',
                          style: TextStyle(
                              color: Couleur.violet1,
                              fontWeight: FontWeight.w800,
                              fontSize: 22))
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
