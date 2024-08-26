import 'package:flutter/material.dart';
import 'package:sfds_app/main.dart';
import 'package:sfds_app/requetes/base_de_donne.dart';

class TempConfig extends StatefulWidget {
  const TempConfig({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TempConfig();
  }
}

class _TempConfig extends State<TempConfig> {
  TextEditingController tempInter = TextEditingController();
  TextEditingController tempCriti = TextEditingController();

  final FocusNode focusInter = FocusNode();
  final FocusNode focusCritique = FocusNode();

  double eleInter = 0;
  double eleCritique = 0;

  @override
  void initState() {
    super.initState();
    BaseDeDonne.getConfig(['tempInter', 'tempCriti']).then((value) {
      setState(() {
        tempInter.text = value[0]['tempInter'];
        tempCriti.text = value[0]['tempCriti'];
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
                    'Température',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                  Image.asset(
                    "assets/images/temperatureB.png",
                    height: 35,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Configurez le seuil intermédiaire et critique de la température',
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
                          'Intermédiaire (°C):',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Material(
                          elevation: eleInter,
                          color: Couleur.violet2,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: const Color.fromARGB(255, 82, 79, 79),
                          child: TextField(
                            controller: tempInter,
                            focusNode: focusInter,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                  tempInter.text = "";
                                  BaseDeDonne.editConfig(
                                      'tempInter', tempInter.text, 1);
                                });
                              } else {
                                try {
                                  tempInter.text =
                                      int.parse(tempInter.text).toString();
                                  BaseDeDonne.editConfig(
                                      'tempInter', tempInter.text, 1);
                                } catch (e) {
                                  tempInter.text = tempInter.text
                                      .substring(0, value.length - 1);
                                  BaseDeDonne.editConfig(
                                      'tempInter', tempInter.text, 1);
                                }
                                if (value.length > 2) {
                                  setState(() {
                                    tempInter.text =
                                        tempInter.text.substring(0, 2);
                                    BaseDeDonne.editConfig(
                                        'tempInter', tempInter.text, 1);
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
                          'Critique (°C):',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Material(
                          elevation: eleCritique,
                          color: Couleur.violet2,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: const Color.fromARGB(255, 82, 79, 79),
                          child: TextField(
                            controller: tempCriti,
                            focusNode: focusCritique,
                            keyboardType: TextInputType.number,
                            style: const TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
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
                                  tempCriti.text = "";
                                  BaseDeDonne.editConfig(
                                      'tempCriti', tempCriti.text, 1);
                                });
                              } else {
                                try {
                                  tempCriti.text =
                                      int.parse(tempCriti.text).toString();
                                  BaseDeDonne.editConfig(
                                      'tempCriti', tempCriti.text, 1);
                                } catch (e) {
                                  tempCriti.text = tempCriti.text
                                      .substring(0, value.length - 1);
                                  BaseDeDonne.editConfig(
                                      'tempCriti', tempCriti.text, 1);
                                }
                                if (value.length > 2) {
                                  setState(() {
                                    tempCriti.text =
                                        tempCriti.text.substring(0, 2);
                                    BaseDeDonne.editConfig(
                                        'tempCriti', tempCriti.text, 1);
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
