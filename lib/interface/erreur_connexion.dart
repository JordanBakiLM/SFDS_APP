import 'package:flutter/material.dart';
import 'package:sfds_app/main.dart';

class Erreurconnexion extends StatefulWidget {
  const Erreurconnexion({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Erreurconnexion();
  }
}

class _Erreurconnexion extends State<Erreurconnexion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 40),
      child: Center(
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
                margin: const EdgeInsets.only(left: 20, right: 20, top: 100),
                child: Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text:
                            'Connexion au systeme echoué veuillez verifier votre connexion internet ou celle de votre ',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Boitier d\'alarme incendie',
                              style: TextStyle(
                                  color: Couleur.violet1,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w900))
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
