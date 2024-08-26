import 'package:flutter/material.dart';
import 'package:sfds_app/main.dart';
import 'package:sfds_app/requetes/base_de_donne.dart';

class AirConfig extends StatefulWidget {
  const AirConfig({super.key});

  @override
  State<StatefulWidget> createState() {
    return _AirConfig();
  }
}

class _AirConfig extends State<AirConfig> {
  TextEditingController airInter = TextEditingController();
  TextEditingController airCriti = TextEditingController();

  final FocusNode focusInter = FocusNode();
  final FocusNode focusCritique = FocusNode();

  double eleInter = 0;
  double eleCritique = 0;

  @override
  void initState() {
    super.initState();
    BaseDeDonne.getConfig(['airInter', 'airCriti']).then((value) {
      setState(() {
        airInter.text = value[0]['airInter'];
        airCriti.text = value[0]['airCriti'];
      });
    });

    focusInter.addListener(() {
      setState(() {
        eleInter = focusInter.hasFocus ? 5 : 0;
      });
    });

    focusCritique.addListener(() {
      setState(() {
        eleCritique = focusCritique.hasFocus ? 5 : 0;
      });
    });
  }

  @override
  void dispose() {
    focusCritique.dispose();
    focusInter.dispose();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Gaz',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                  Image.asset(
                    "assets/images/ventB.png",
                    height: 35,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Configurez le seuil intermédiaire et critique du niveau de gaz',
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: largeur / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Intermédiaire (ppb):',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Material(
                          elevation: eleInter,
                          color: Couleur.violet2,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: const Color.fromARGB(255, 82, 79, 79),
                          child: TextField(
                            controller: airInter,
                            focusNode: focusInter,
                            keyboardType: TextInputType.number,
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
                              if (value == " " || value == '') {
                                setState(() {
                                  airInter.text = "";
                                  BaseDeDonne.editConfig(
                                      'airInter', airInter.text, 1);
                                });
                              } else {
                                try {
                                  airInter.text =
                                      int.parse(airInter.text).toString();
                                  BaseDeDonne.editConfig(
                                      'airInter', airInter.text, 1);
                                } catch (e) {
                                  airInter.text = airInter.text
                                      .substring(0, value.length - 1);
                                  BaseDeDonne.editConfig(
                                      'airInter', airInter.text, 1);
                                }
                                if (value.length > 3) {
                                  setState(() {
                                    airInter.text =
                                        airInter.text.substring(0, 3);
                                    BaseDeDonne.editConfig(
                                        'airInter', airInter.text, 1);
                                  });
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: largeur / 2.5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Critique (ppb):',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Material(
                          elevation: eleCritique,
                          color: Couleur.violet2,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: const Color.fromARGB(255, 82, 79, 79),
                          child: TextField(
                            controller: airCriti,
                            focusNode: focusCritique,
                            keyboardType: TextInputType.number,
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
                              if (value == " " || value == "") {
                                setState(() {
                                  airCriti.text = "";
                                  BaseDeDonne.editConfig(
                                      'airCriti', airCriti.text, 1);
                                });
                              } else {
                                try {
                                  airCriti.text =
                                      int.parse(airCriti.text).toString();
                                  BaseDeDonne.editConfig(
                                      'airCriti', airCriti.text, 1);
                                } catch (e) {
                                  airCriti.text = airCriti.text
                                      .substring(0, value.length - 1);
                                  BaseDeDonne.editConfig(
                                      'airCriti', airCriti.text, 1);
                                }
                                if (value.length > 3) {
                                  setState(() {
                                    airCriti.text =
                                        airCriti.text.substring(0, 3);
                                    BaseDeDonne.editConfig(
                                        'airCriti', airCriti.text, 1);
                                  });
                                }
                              }
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
