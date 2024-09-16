import 'package:flutter/material.dart';
import 'package:sfds_app/main.dart';
import 'package:sfds_app/requetes/base_de_donne.dart';

class ConfigurationHotspot extends StatefulWidget {
  const ConfigurationHotspot({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ConfigurationHotspot();
  }
}

class _ConfigurationHotspot extends State<ConfigurationHotspot> {
  TextEditingController part1 = TextEditingController();
  TextEditingController part2 = TextEditingController();
  TextEditingController part3 = TextEditingController();
  TextEditingController part4 = TextEditingController();

  FocusNode focusPart1 = FocusNode();
  FocusNode focusPart2 = FocusNode();
  FocusNode focusPart3 = FocusNode();
  FocusNode focusPart4 = FocusNode();

  @override
  void initState() {
    super.initState();
    BaseDeDonne.getAdresseIP().then(
      (value) {
        String adr = value[0]['adresseIP'].toString();
        List<String> part = adr.split('.');
        if (part.length == 4){
          setState(() {
            part1.text = part[0];
            part2.text = part[1];
            part3.text = part[2];
            part4.text = part[3];
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 30, left: 50, right: 50),
              color: Colors.transparent,
              child: Image.asset(
                'assets/images/local.png',
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      text:
                          'Renseigner l\'adresse IP à laquelle vous devez vous connecter à votre ',
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
                            fontWeight: FontWeight.w900
                          )
                        ),
                      ]),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Center(
                child: TextButton(
                  onPressed: () { 
                    print('svxann');
                  },
                  child: Text(
                    'Scanner le Qr code',
                    style: TextStyle(
                      color: Couleur.violet4,
                      fontSize: 18
                    ),
                  ),
                  
                )
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: part1,
                        focusNode: focusPart1,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(112, 112, 112, 1),
                                width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Couleur.violet1, width: 3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onChanged: (value) {
                          if (value == " " || value == "") {
                            setState(() {
                              part1.text = "";
                            });
                          } else {
                            try {
                              part1.text = int.parse(part1.text).toString();
                            } catch (e) {
                              part1.text =
                                  part1.text.substring(0, value.length - 1);
                            }
                            if (value.length > 2) {
                              if (int.parse(part1.text) > 255 &&
                                  part1.text.length < 4) {
                                setState(() {
                                  part1.text = part1.text.substring(0, 2);
                                });
                              }
                              if (value.length > 3) {
                                setState(() {
                                  part1.text = part1.text.substring(0, 3);
                                });
                              }
                              if (part1.text.length == 3) {
                                focusPart2.requestFocus();
                              }
                            }
                          }
                        },
                      ),
                    ),
                    Image.asset(
                      'assets/images/dot.png',
                      width: 5,
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: part2,
                        focusNode: focusPart2,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(112, 112, 112, 1),
                                width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Couleur.violet1, width: 3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onChanged: (value) {
                          if (value == " " || value == "") {
                            setState(() {
                              part2.text = "";
                            });
                          } else {
                            try {
                              part2.text = int.parse(part2.text).toString();
                            } catch (e) {
                              part2.text =
                                  part2.text.substring(0, value.length - 1);
                            }
                            if (value.length > 2) {
                              if (int.parse(part2.text) > 255 &&
                                  part2.text.length < 4) {
                                setState(() {
                                  part2.text = part2.text.substring(0, 2);
                                });
                              }
                              if (value.length > 3) {
                                setState(() {
                                  part2.text = part2.text.substring(0, 3);
                                });
                              }
                              if (part2.text.length == 3) {
                                focusPart3.requestFocus();
                              }
                            }
                          }
                        },
                      ),
                    ),
                    Image.asset(
                      'assets/images/dot.png',
                      width: 5,
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: part3,
                        focusNode: focusPart3,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(112, 112, 112, 1),
                                width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Couleur.violet1, width: 3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onChanged: (value) {
                          if (value == " " || value == "") {
                            setState(() {
                              part3.text = "";
                            });
                          } else {
                            try {
                              part3.text = int.parse(part3.text).toString();
                            } catch (e) {
                              part3.text =
                                  part3.text.substring(0, value.length - 1);
                            }
                            if (value.length > 2) {
                              if (int.parse(part3.text) > 255 &&
                                  part3.text.length < 4) {
                                setState(() {
                                  part3.text = part3.text.substring(0, 2);
                                });
                              }
                              if (value.length > 3) {
                                setState(() {
                                  part3.text = part3.text.substring(0, 3);
                                });
                              }
                              if (part3.text.length == 3) {
                                focusPart4.requestFocus();
                              }
                            }
                          }
                        },
                      ),
                    ),
                    Image.asset(
                      'assets/images/dot.png',
                      width: 5,
                    ),
                    SizedBox(
                      width: 60,
                      child: TextField(
                        controller: part4,
                        focusNode: focusPart4,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 12.0),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                                color: Color.fromRGBO(112, 112, 112, 1),
                                width: 1.5),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Couleur.violet1, width: 3),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                        onChanged: (value) {
                          if (value == " " || value == "") {
                            setState(() {
                              part4.text = "";
                            });
                          } else {
                            try {
                              part4.text = int.parse(part4.text).toString();
                            } catch (e) {
                              part4.text =
                                  part4.text.substring(0, value.length - 1);
                            }
                            if (value.length > 2) {
                              if (int.parse(part4.text) > 255 &&
                                  part4.text.length < 4) {
                                setState(() {
                                  part4.text = part4.text.substring(0, 2);
                                });
                              }
                              if (value.length > 3) {
                                setState(() {
                                  part4.text = part4.text.substring(0, 3);
                                });
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 70, bottom: 10),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    updateAdresse();
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
          ],
        ),
      ),
    );
  }

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

  void snack() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      padding: const EdgeInsets.all(8),
      width: 220,
      content: const Center(
          child: Text(
        'Veuillez remplir tous les champs',
        style: TextStyle(fontSize: 12),
      )),
      backgroundColor: Couleur.violet4,
    ));
  }

  void updateAdresse() {
    if (part1.text == "") {
      snack();
      focusPart1.requestFocus();
      return;
    }
    if (part2.text == "") {
      snack();
      focusPart2.requestFocus();
      return;
    }
    if (part3.text == "") {
      snack();
      focusPart3.requestFocus();
      return;
    }
    if (part4.text == "") {
      snack();
      focusPart4.requestFocus();
      return;
    }

    String adresse = '${part1.text}.${part2.text}.${part3.text}.${part4.text}';
    BaseDeDonne.setAdresseIP(adresse);
    configOK();
    focusPart1.unfocus();
    focusPart2.unfocus();
    focusPart3.unfocus();
    focusPart4.unfocus();
  }
}
