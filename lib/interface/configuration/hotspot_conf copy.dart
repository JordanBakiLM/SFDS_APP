import 'package:flutter/material.dart';
import 'package:sfds_app/main.dart';
import 'package:sfds_app/requetes/base_de_donne.dart';

class HotspotConfig extends StatefulWidget {
  const HotspotConfig({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HotspotConfig();
  }
}

class _HotspotConfig extends State<HotspotConfig> {
  TextEditingController nomHotspot = TextEditingController();
  TextEditingController passHotspot = TextEditingController();

  final FocusNode focusNom = FocusNode();
  final FocusNode focusPass = FocusNode();

  double eleNom = 0;
  double elePass = 0;

  @override
  void initState() {
    super.initState();
    BaseDeDonne.getConfig(['nomHotspot', 'passHotspot']).then((value) {
      setState(() {
        nomHotspot.text = value[0]['nomHotspot'];
        passHotspot.text = value[0]['passHotspot'];
      });
    });

    focusNom.addListener(() {
      if (focusNom.hasFocus == true) {
        setState(() {
          eleNom = 5;
        });
      } else {
        setState(() {
          eleNom = 0;
        });
      }
    });

    focusPass.addListener(() {
      if (focusPass.hasFocus == true) {
        setState(() {
          elePass = 5;
        });
      } else {
        setState(() {
          elePass = 0;
        });
      }
    });
  }

  @override
  void dispose() {
    focusPass.dispose();
    focusNom.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double largeur = MediaQuery.of(context).size.width;
    return Container(
      width: largeur / 1.1,
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
        child: Container(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Hotspot',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.wifi_tethering,
                    size: 35,
                    color: Colors.white,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Configurez le SSID et le mot de passe pour vous connecter au boitier d\'alarme incendie',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Divider(
                color: Couleur.violet3,
                thickness: 0.4,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'SSID:',
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      Material(
                        elevation: eleNom,
                        color: Couleur.violet2,
                        borderRadius: BorderRadius.circular(10),
                        shadowColor: const Color.fromARGB(255, 82, 79, 79),
                        child: TextField(
                          controller: nomHotspot,
                          focusNode: focusNom,
                          style: const TextStyle(fontSize: 18),
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20.0),
                            enabledBorder: const OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10.0)),
                              borderSide: BorderSide(
                                  color: Color.fromRGBO(112, 112, 112, 1),
                                  width: 1.5),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Couleur.violet1, width: 2),
                              borderRadius: const BorderRadius.all(
                                  Radius.circular(10.0)),
                            ),
                          ),
                          onChanged: (value) {
                            if (value == " ") {
                              setState(() {
                                nomHotspot.text = "";
                              });
                            }
                            BaseDeDonne.editConfig('nomHotspot', nomHotspot.text, 1);
                          },
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top : 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Mot de passe:',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Material(
                          elevation: elePass,
                          color: Couleur.violet2,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: const Color.fromARGB(255, 82, 79, 79),
                          child: TextField(
                            controller: passHotspot,
                            focusNode: focusPass,
                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 20.0),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(
                                    color: Color.fromRGBO(112, 112, 112, 1),
                                    width: 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Couleur.violet1, width: 2),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(10.0)),
                              ),
                            ),
                            onChanged: (value) {
                              if (value == " ") {
                                setState(() {
                                  passHotspot.text = "";
                                });
                              }
                              BaseDeDonne.editConfig('passHotspot', passHotspot.text, 1);
                            },
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
