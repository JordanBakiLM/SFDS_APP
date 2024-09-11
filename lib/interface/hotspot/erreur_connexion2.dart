import 'package:flutter/material.dart';
import 'package:sfds_app/main.dart';

class Erreurconnexion2 extends StatefulWidget {
  const Erreurconnexion2({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Erreurconnexion2();
  }
}

class _Erreurconnexion2 extends State<Erreurconnexion2> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/error.png',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20, top: 70),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text:
                          'Connexion à votre ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: 'boitier d\'alarme incendie ',
                          style: TextStyle(
                            color: Couleur.violet1,
                            fontSize: 20,
                            fontWeight: FontWeight.w900)
                        ),
                        const TextSpan(
                          text: 'échouée. Veuillez vérifier ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: 'votre connexion au hotspot ',
                          style: TextStyle(
                            color: Couleur.violet1,
                            fontSize: 20,
                            fontWeight: FontWeight.w900)
                        ),
                        const TextSpan(
                          text: 'ou ',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                        ),
                        TextSpan(
                          text: 'l\'adresse IP ',
                          style: TextStyle(
                            color: Couleur.violet1,
                            fontSize: 20,
                            fontWeight: FontWeight.w900)
                        ),
                        const TextSpan(
                          text: 'avec laquelle vous vous connecter au serveur de votre boitier',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold)
                        ),
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
