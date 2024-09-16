import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:sfds_app/interface/configuration/configuration.dart';
import 'package:sfds_app/interface/hotspot/configuration_hotspot.dart';
import 'package:sfds_app/interface/temp_reel/temp_reel.dart';
import 'package:sfds_app/main.dart';

class Acceuil extends StatefulWidget {
  const Acceuil({super.key});

  @override
  State<StatefulWidget> createState() {
    return _Acceuil();
  }
}

class _Acceuil extends State<Acceuil> {
  var currentIndex = 0;
  DateTime? dernierePressionRetour;

  Future<bool> retour() async {
    final now = DateTime.now();
    if (dernierePressionRetour == null ||
        now.difference(dernierePressionRetour!) > const Duration(seconds: 2)) {
      dernierePressionRetour = now;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(8),
        width: 220,
        content: const Center(
            child: Text(
          'Appuyer à nouveau pour quitter',
          style: TextStyle(fontSize: 12),
        )),
        backgroundColor: Couleur.violet4,
      ));
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: retour,
      child: Scaffold(
        backgroundColor: Couleur.violet3,
        appBar: AppBar(
          backgroundColor: Couleur.violet1,
          title: const Text(
            'SFDS',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900),
          ),
          actions: [
            Container(
              padding: const EdgeInsets.all(10),
              child: Image.asset("assets/images/icone.png"),
            )
          ],
        ),
        bottomNavigationBar: SalomonBottomBar(
          backgroundColor: Couleur.violet1,
          duration: const Duration(milliseconds: 700),
          currentIndex: currentIndex,
          onTap: (i) => setState(() => currentIndex = i),
          items: <SalomonBottomBarItem>[
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.access_time_outlined,
                color: Colors.white,
                size: 30,
              ),
              title: const Text(
                'Temp réel',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              selectedColor: Couleur.violet3
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.settings,
                color: Colors.white,
                size: 30,
              ),
              title: const Text(
                'Configuration',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              selectedColor: Couleur.violet3
            ),
            SalomonBottomBarItem(
              icon: const Icon(
                Icons.wifi_tethering,
                color: Colors.white,
                size: 30,
              ),
              title: const Text(
                'Hotspot',
                style: TextStyle(fontSize: 15, color: Colors.white),
              ),
              selectedColor: Couleur.violet3
            ),
          ],
        ),
        body: Container(
          child: getBody(),
        ),
      ),
    );
  }

  getBody() {
    switch (currentIndex) {
      case 0:
        return const TempReel();
      case 1:
        return const Configuration();
      case 2:
        return const ConfigurationHotspot();
    }
    return null;
  }
}
