import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:sfds_app/interface/erreur_connexion.dart';
import 'package:sfds_app/main.dart';
import 'package:sfds_app/requetes/base_de_donne.dart';
import 'package:sfds_app/requetes/server_distant_http.dart';
import 'package:sfds_app/requetes/server_distant_mqtt.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Temperature();
  }
}

class _Temperature extends State<Temperature> {
  List<String> labelTemp = ['', '', ''];
  List<int> valTemp = [0, 0, 0];
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
        for (int i = 0; i < 3; i++) {
          if (valTemp[i] != 9999) {
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
                                  labelTemp[i],
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
                              "${valTemp[i].toInt()} °C",
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
                        child: SfRadialGauge(
                          axes: <RadialAxis>[
                            RadialAxis(
                              minimum: 10,
                              maximum: 100,
                              showLabels: false,
                              showTicks: false,
                              axisLineStyle: AxisLineStyle(
                                  gradient: SweepGradient(colors: <Color>[
                                Couleur.violet3,
                                Couleur.violet1,
                              ], stops: const <double>[
                                0,
                                1
                              ])),
                              pointers: <GaugePointer>[
                                NeedlePointer(
                                  value: valTemp[i].toDouble(),
                                  needleLength: 0.7,
                                  needleEndWidth: 3,
                                  needleStartWidth: 1,
                                  needleColor: Colors.white,
                                  tailStyle: const TailStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                              annotations: <GaugeAnnotation>[
                                GaugeAnnotation(
                                  widget: Text(
                                    '10 °C',
                                    style: TextStyle(
                                        color: Couleur.violet1,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  angle: 120,
                                  positionFactor: 1.1,
                                ),
                                GaugeAnnotation(
                                  widget: Text(
                                    '100 °C',
                                    style: TextStyle(
                                        color: Couleur.violet1,
                                        fontWeight: FontWeight.w800),
                                  ),
                                  angle: 60,
                                  positionFactor: 1.1,
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ));
          }
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

      if (retour.isEmpty) {
        retour.add(
          Center(
            child: Container(
              width: 300,
              height: 300,
              margin: EdgeInsets.only(top: hauteur / 2.5),
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: 'Aucun',
                    style: const TextStyle(color: Colors.black, fontSize: 30),
                    children: <TextSpan>[
                      TextSpan(
                          text: ' capteur ',
                          style: TextStyle(
                              color: Couleur.violet1,
                              fontWeight: FontWeight.w800,
                              fontSize: 30)),
                      const TextSpan(
                          text: ' connecté à votre centrale',
                          style: TextStyle(color: Colors.black, fontSize: 30))
                    ]),
              ),
            ),
          ),
        );
      }
    }
    return retour;
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
                        labelTemp[index] = nouveauNomTemp.text;
                        BaseDeDonne.changerNom('capteurTemperature',
                            nouveauNomTemp.text, index + 1);
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
    ServerDistant.centraleOnLine().then(
      (value) {
        if (value != true) {
          BaseDeDonne.getNom('capteurTemperature').then((value) {
            int i = 0;
            for (var element in value) {
              setState(() {
                labelTemp[i] = element['nom'];
              });
              i++;
            }
          });

          ServerDistant.getValeur('V1').then(
            (value) {
              List<String> temp = value.split(' ');
              int i = 0;
              setState(() {
                for (var element in temp) {
                  valTemp[i] = int.parse(element.toString());
                  i++;
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
                  .subscribe('downlink/ds/Temp', MqttQos.atMostOnce);
              mqttService.client.updates!
                  .listen((List<MqttReceivedMessage<MqttMessage>> c) {
                final MqttPublishMessage message =
                    c[0].payload as MqttPublishMessage;
                final payload = MqttPublishPayload.bytesToStringAsString(
                    message.payload.message);

                List<String> temp = payload.split(' ');
                int i = 0;
                setState(() {
                  for (var element in temp) {
                    valTemp[i] = int.parse(element.toString());
                    i++;
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
      },
    );
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
          'Température',
          style: TextStyle(
              color: Colors.white, fontSize: 23, fontWeight: FontWeight.w900),
        ),
        actions: [
          Container(
            padding: const EdgeInsets.all(10),
            child: Image.asset("assets/images/temperatureB.png"),
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
