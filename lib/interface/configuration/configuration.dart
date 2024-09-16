import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sfds_app/interface/configuration/air_conf.dart';
import 'package:sfds_app/interface/configuration/contact_conf.dart';
import 'package:sfds_app/interface/configuration/temp_conf.dart';
import 'package:sfds_app/interface/configuration/wifi_conf.dart';
import 'package:sfds_app/interface/hotspot/erreur_connexion2.dart';
import 'package:sfds_app/main.dart';
import 'package:sfds_app/requetes/base_de_donne.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Configuration extends StatefulWidget {
  const Configuration({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Configuration();
  }
}

class _Configuration extends State<Configuration> {
  late WebSocketChannel client;
  late String adresseIP;

  late List<Widget> containerOK;
  late List<Widget> containerConn;
  late List<Widget> containerErreur;
  late List<Widget> containerAffiche;

  Future<void> configOK() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Couleur.violet2,
            content: const Text(
              'Votre configuration a été éffectuée avec succès',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.white),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Couleur.violet1),
                  ))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();

    containerOK = [
      const TempConfig(),
      const AirConfig(),
      const ContactConfig(),
      const WifiConfig(),
      Container(
        margin: const EdgeInsets.only(top: 10, bottom: 30),
        child: Center(
          child: ElevatedButton(
            onPressed: () {
              sendConfifOk();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Couleur.violet4,
              elevation: 5,
              fixedSize: const Size(190, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Text(
              'Valider',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    ];

    containerConn = [
      Center(
        child: Column(
          children: [
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                strokeWidth: 8,
                color: Couleur.violet1,
                backgroundColor: Couleur.violet2,
              ),
            ),
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 30),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text: 'Connexion a votre ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                            text: 'boitier d\'alarme incendie',
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
    ];

    containerErreur = [const Erreurconnexion2()];

    containerAffiche = containerConn;

    BaseDeDonne.getAdresseIP().then(
      (value) {
        setState(() {
          adresseIP = value[0]['adresseIP'].toString();
        });
      },
    );

    try {
      client = WebSocketChannel.connect(Uri.parse('ws://$adresseIP/ws'));

      setState(() {
        containerAffiche = containerOK;
      });

      client.stream.listen(
        (message) {
          configOK();
        },
        onDone: () {
          print('connexion lost');
        },
      );
    } catch (e) {
      setState(() {
        containerAffiche = containerErreur;
      });
    }
  }

  @override
  void dispose() {
    try {
      client.sink.close();
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: Couleur.violet3,
        child: Scrollbar(
          thickness: 5,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: containerAffiche,
              // children: [
              //   const TempConfig(),
              //   const AirConfig(),
              //   const ContactConfig(),
              //   const WifiConfig(),
              //   const HotspotConfig(),
              //   Container(
              //     margin: const EdgeInsets.only(top: 10, bottom: 30),
              //     child: Center(
              //       child: ElevatedButton(
              //         onPressed: () {
              //           sendConfifOk();
              //         },
              //         style: ElevatedButton.styleFrom(
              //           backgroundColor: Couleur.violet4,
              //           elevation: 5,
              //           fixedSize: const Size(190, 50),
              //           shape: RoundedRectangleBorder(
              //             borderRadius: BorderRadius.circular(15.0),
              //           ),
              //         ),
              //         child: const Text(
              //           'Valider',
              //           style: TextStyle(
              //               fontSize: 18,
              //               color: Colors.white,
              //               fontWeight: FontWeight.w700),
              //         ),
              //       ),
              //     ),
              //   ),
              // ]
            ),
          ),
        ),
      ),
    );
  }

  void sendConfifOk() {
    FocusScope.of(context).unfocus();
    BaseDeDonne.setConfig().then(
      (value) {
        client.sink.add(jsonEncode(value[0].toString()));
      },
    );
  }
}
