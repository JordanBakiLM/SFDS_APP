import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sfds_app/interface/configuration/air_conf.dart';
import 'package:sfds_app/interface/configuration/contact_conf.dart';
import 'package:sfds_app/interface/configuration/temp_conf.dart';
import 'package:sfds_app/interface/configuration/wifi_conf.dart';
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

    try {
      client = WebSocketChannel.connect(Uri.parse('ws://192.168.4.1/ws'));

      client.stream.listen((message) {
        configOK();
      });
    } catch (e) {}
  }

  @override
  void dispose() {
    client.sink.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Couleur.violet3,
      child: Scrollbar(
        thickness: 5,
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
          ]),
        ),
      ),
    );
  }

  void sendConfifOk() {
    BaseDeDonne.setConfig().then((value) {
      client.sink.add(jsonEncode(value[0].toString()));
    },);
  }
}
