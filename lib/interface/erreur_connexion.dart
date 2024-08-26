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
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height - 85,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/error.png',
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 20, right: 20),
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
                                text: 'Centrale',
                                style: TextStyle(
                                    color: Couleur.violet1,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w900))
                          ]),
                    ),
                  ),
                ),
                // Container(
                //   margin: const EdgeInsets.only(top: 50),
                //   child: Center(
                //     child: ElevatedButton(
                //       onPressed: () {
                //         reessayerConnexion();
                //       },
                //       style: ElevatedButton.styleFrom(
                //         backgroundColor: Couleur.violet1,
                //         elevation: 5,
                //         fixedSize: const Size(190, 50),
                //         shape: RoundedRectangleBorder(
                //           borderRadius: BorderRadius.circular(15.0),
                //         ),
                //       ),
                //       child: const Text(
                //         'Réessayer',
                //         style: TextStyle(
                //             fontSize: 18,
                //             color: Colors.white,
                //             fontWeight: FontWeight.w700),
                //       ),
                //     ),
                //   ),
                // ),
                // TextButton(
                //   onPressed: () {
                //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Acceuil()));
                //   },
                //   child: const Text('suivant')
                // )
              ],
            )
          ],
        ),
      ),
    );
  }
}
