import 'package:flutter/material.dart';
import 'package:sfds_app/main.dart';
import 'package:sfds_app/requetes/base_de_donne.dart';
import 'package:country_code_picker/country_code_picker.dart';

class ContactConfig extends StatefulWidget {
  const ContactConfig({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ContactConfig();
  }
}

class _ContactConfig extends State<ContactConfig> {
  String indicatif = '';
  TextEditingController numeroUrgence = TextEditingController();
  TextEditingController autorite = TextEditingController();

  final FocusNode focusContact = FocusNode();
  final FocusNode focusAutorite = FocusNode();

  double eleContact = 0;
  double eleAutorite = 0;

  @override
  void initState() {
    super.initState();
    BaseDeDonne.getConfig(['indicatif', 'numeroUrgence', 'autorite'])
        .then((value) {
      setState(() {
        indicatif = value[0]['indicatif'];
        numeroUrgence.text = value[0]['numeroUrgence'];
        autorite.text = value[0]['autorite'];
      });
    });

    focusContact.addListener(() {
      setState(() {
        eleContact = focusContact.hasFocus ? 5 : 0;
      });
    });

    focusAutorite.addListener(() {
      setState(() {
        eleAutorite = focusAutorite.hasFocus ? 5 : 0;
      });
    });
  }

  @override
  void dispose() {
    focusContact.dispose();
    focusAutorite.dispose();
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
                    'Contact',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.w700),
                  ),
                  Icon(
                    Icons.phone,
                    size: 35,
                    color: Colors.white,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: const Text(
                  'Renseigner le numéro de téléphone d\'urgence et celui des autorités compétentes',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 110,
                        margin: const EdgeInsets.only(right: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            CountryCodePicker(
                              padding: const EdgeInsets.all(0),
                              onChanged: (value) {
                                setState(() {
                                  indicatif = value.toString();
                                  BaseDeDonne.editConfig(
                                      'indicatif', indicatif, 1);
                                });
                              },
                              initialSelection: indicatif,
                              favorite: const ['+237', '+49'],
                              flagDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: largeur / 2.5 + largeur / 2.5 - 120,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Contact:',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w600),
                            ),
                            Material(
                              elevation: eleContact,
                              color: Couleur.violet2,
                              borderRadius: BorderRadius.circular(10),
                              shadowColor:
                                  const Color.fromARGB(255, 82, 79, 79),
                              child: TextField(
                                controller: numeroUrgence,
                                focusNode: focusContact,
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
                                      numeroUrgence.text = "";
                                      BaseDeDonne.editConfig('numeroUrgence',
                                          numeroUrgence.text, 1);
                                    });
                                  } else {
                                    try {
                                      numeroUrgence.text =
                                          int.parse(numeroUrgence.text)
                                              .toString();
                                      BaseDeDonne.editConfig('numeroUrgence',
                                          numeroUrgence.text, 1);
                                    } catch (e) {
                                      numeroUrgence.text = numeroUrgence.text
                                          .substring(0, value.length - 1);
                                      BaseDeDonne.editConfig('numeroUrgence',
                                          numeroUrgence.text, 1);
                                    }
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 7),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Contact autorité:',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w600),
                        ),
                        Material(
                          elevation: eleAutorite,
                          color: Couleur.violet2,
                          borderRadius: BorderRadius.circular(10),
                          shadowColor: const Color.fromARGB(255, 82, 79, 79),
                          child: TextField(
                            controller: autorite,
                            focusNode: focusAutorite,
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
                                  autorite.text = "";
                                  BaseDeDonne.editConfig(
                                      'autorite', autorite.text, 1);
                                });
                              } else {
                                try {
                                  autorite.text =
                                      int.parse(autorite.text).toString();
                                  BaseDeDonne.editConfig(
                                      'autorite', autorite.text, 1);
                                } catch (e) {
                                  autorite.text = autorite.text
                                      .substring(0, value.length - 1);
                                  BaseDeDonne.editConfig(
                                      'autorite', autorite.text, 1);
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
