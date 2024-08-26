import 'package:flutter/material.dart';
import 'package:sfds_app/interface/temp_reel/alarme.dart';
import 'package:sfds_app/interface/temp_reel/gaz.dart';
import 'package:sfds_app/interface/temp_reel/temperature.dart';
import 'package:sfds_app/main.dart';

class TempReel extends StatefulWidget {
  const TempReel({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TempReel();
  }
}

class _TempReel extends State<TempReel> {

  List<String> titre = ['Température', 'Gaz', 'Alarme'];
  List<String> sousTtitre = [
    'Visualiser la température de votre maison en temps réel',
    'Visualiser le niveau de gaz de votre maison en temps réel',
    'Désactiver l\'alarme de votre maison à distance'
  ];
  List<String> image = [
    'temperatureN.png',
    'ventN.png',
    'alarme-incendieN.png'
  ];

  List<Widget> loadItem(double largeur) {
    List<Widget> retour = [];
    for (int i = 0; i < 3; i++) {
      retour.add(Container(
        margin: EdgeInsets.only(
          top: 30,
          bottom: 30,
          left: (largeur - (largeur / 1.1)) / 2,
          right: (largeur - (largeur / 1.1)) / 2,
        ),
        child: Material(
          color: Couleur.violet2,
          borderRadius: BorderRadius.circular(25),
          shadowColor: const Color.fromARGB(255, 82, 79, 79),
          elevation: 10,
          child: InkWell(
            splashColor: Couleur.violet2,
            borderRadius: BorderRadius.circular(25),
            onTap:() {
              if (i == 0) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Temperature()));
              }
              else if (i == 1) {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Gaz()));
              }
              else {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Alarme()));
              }
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.transparent,
              ),
              width: largeur / 1.1,
              height: 120,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 15, bottom: 10),
                    width: largeur / 1.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          titre[i],
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700),
                        ),
                        Text(
                          sousTtitre[i],
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w500),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    width: (largeur / 1.1) - (largeur / 1.7),
                    child: Image.asset(
                      "assets/images/${image[i]}",
                      height: 60,
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ));
    }

    return retour;
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    return Container(
      color: Couleur.violet3,
      child: Scrollbar(
        thickness: 5,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: loadItem(largeur),
          ),
        ),
      ),
    );
  }
}
