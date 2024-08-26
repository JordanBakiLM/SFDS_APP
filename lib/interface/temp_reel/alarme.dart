import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:sfds_app/interface/erreur_connexion.dart';
import 'package:sfds_app/main.dart';
import 'package:sfds_app/requetes/base_de_donne.dart';
import 'package:sfds_app/requetes/server_distant_http.dart';
import 'package:sfds_app/requetes/server_distant_mqtt.dart';

// Visibility gestion des choses manquantes

class Alarme extends StatefulWidget {
  const Alarme({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Alarme();
  }
}

class _Alarme extends State<Alarme> {
  List<String> labelAlar = [''];
  List<bool> isSwitch = [false];
  List<String> valAlar = ['Eteinte'];
  TextEditingController nouveauNomTemp = TextEditingController();
  bool fin = false;
  bool connect = true;

  late MqttService mqttService;

  List<Widget> loadItem(double largeur, hauteur) {
    List<Widget> retour = [];
    if (connect == false) {
      retour.add(const Erreurconnexion());
    } else {
      if (fin == true) {
        for (int i = 0; i < 1; i++) {
          retour.add(Container(
            margin: EdgeInsets.only(
                top: 25,
                bottom: 25,
                left: (largeur - (largeur / 1.1)) / 2,
                right: (largeur - (largeur / 1.1)) / 2),
            child: Material(
              color: Couleur.violet2,
              borderRadius: BorderRadius.circular(25),
              shadowColor: const Color.fromARGB(255, 82, 79, 79),
              elevation: 10,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.transparent,
                ),
                width: largeur / 1.1,
                height: 140,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(left: 15, bottom: 10),
                      width: largeur / 1.8,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                labelAlar[i],
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w800),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: Colors.white,
                                iconSize: 22,
                                onPressed: () {
                                  editNom(i);
                                },
                              )
                            ],
                          ),
                          Text(
                            valAlar[i],
                            style: TextStyle(
                                color: Couleur.violet1,
                                fontSize: 30,
                                fontWeight: FontWeight.w900),
                          )
                        ],
                      ),
                    ),
                    Container(
                        padding: const EdgeInsets.all(8),
                        width: (largeur / 1.1) - (largeur / 1.8),
                        child: Switch(
                          activeColor: Couleur.violet3,
                          activeTrackColor: Couleur.violet1,
                          inactiveThumbColor: Couleur.violet1,
                          inactiveTrackColor: Couleur.violet3,
                          value: isSwitch[i],
                          onChanged: (value) {
                            setState(() {
                              if (value == true) {
                                alertAllarme();
                              } else {
                                valAlar[0] = 'Eteinte';
                                isSwitch[i] = !isSwitch[i];
                                ServerDistant.switchAlarm(0);
                              }
                            });
                          },
                        ))
                  ],
                ),
              ),
            ),
          ));
        }
      } else {
        retour.add(
          Center(
            child: Container(
              width: 60,
              height: 60,
              margin: EdgeInsets.only(top: hauteur / 2.5),
              child: CircularProgressIndicator(
                strokeWidth: 8,
                color: Couleur.violet1,
                backgroundColor: Couleur.violet2,
              ),
            ),
          ),
        );
      }
    }
    return retour;
  }

  Future<void> alertAllarme() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Couleur.violet2,
            content: const Text(
              'Vous ne pouvez pas activer l\'alarme à travers l\'application mobile',
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

  Future<void> editNom(index) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Couleur.violet2,
            title: const Text('Nouveau nom'),
            content: TextField(
              autofocus: true,
              maxLength: 12,
              controller: nouveauNomTemp,
              style: const TextStyle(fontSize: 20),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(Radius.circular(15.0)),
                  borderSide: BorderSide(color: Couleur.violet1, width: 1.0),
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    if (nouveauNomTemp.text != "") {
                      setState(() {
                        labelAlar[index] = nouveauNomTemp.text;
                        BaseDeDonne.changerNom(
                            'alarme', nouveauNomTemp.text, index + 1);
                        nouveauNomTemp.text = '';
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: Text(
                    'VALIDER',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Couleur.violet1),
                  )),
              TextButton(
                  onPressed: () {
                    setState(() {
                      nouveauNomTemp.text = '';
                    });
                    Navigator.pop(context);
                  },
                  child: Text(
                    'ANNULER',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Couleur.violet1),
                  )),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    ServerDistant.centraleOnLine().then((value) {
      if (value == true) {
        BaseDeDonne.getNom('alarme').then((value) {
          int i = 0;
          for (var element in value) {
            setState(() {
              labelAlar[i] = element['nom'];
            });
            i++;
          }
        });

        ServerDistant.getValeur('V0').then(
          (value) {
            setState(() {
              if (int.parse(value.toString()) == 1) {
                valAlar[0] = 'Allumée';
                isSwitch[0] = true;
              } else {
                valAlar[0] = 'Eteinte';
                isSwitch[0] = false;
              }
              fin = true;
            });
          },
        );

        mqttService = MqttService();
        mqttService.connect().then(
          (value) {
            mqttService.client.connectionMessage = MqttConnectMessage()
                .withClientIdentifier('sfds-clent_mqtt')
                .withWillQos(MqttQos.atLeastOnce);
            mqttService.client
                .subscribe('downlink/ds/Alarme', MqttQos.atMostOnce);
            mqttService.client.updates!
                .listen((List<MqttReceivedMessage<MqttMessage>> c) {
              final MqttPublishMessage message =
                  c[0].payload as MqttPublishMessage;
              final payload = MqttPublishPayload.bytesToStringAsString(
                  message.payload.message);

              setState(() {
                if (int.parse(payload.toString()) == 1) {
                  valAlar[0] = 'Allumée';
                  isSwitch[0] = true;
                } else {
                  valAlar[0] = 'Eteinte';
                  isSwitch[0] = false;
                }
                fin = true;
              });
            });
          },
        );
      } else {
        setState(() {
          connect = false;
        });
      }
    });
  }

  @override
  void dispose() {
    try {
      mqttService.disConnect();
    } catch (e) {}
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    double hauteur = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Couleur.violet3,
      appBar: AppBar(
        backgroundColor: Couleur.violet1,
        leading: const BackButton(
          color: Colors.white,
        ),
        title: const Text(
          'Alarme',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.w900),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset("assets/images/alarme-incendieB.png"),
          )
        ],
      ),
      body: Scrollbar(
        thickness: 5,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: loadItem(largeur, hauteur),
          ),
        ),
      ),
    );
  }
}
