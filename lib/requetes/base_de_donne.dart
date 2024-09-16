import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BaseDeDonne {
  static void create() async {
    // ignore: unused_local_variable
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'sfds.bd'),
      version: 1,
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE capteurTemperature(id INTEGER PRIMARY KEY, nom TEXT)');
        await database.execute(
            'CREATE TABLE capteurGaz(id INTEGER PRIMARY KEY, nom TEXT)');
        await database
            .execute('CREATE TABLE alarme(id INTEGER PRIMARY KEY, nom TEXT)');
        
        await database.execute(
            'CREATE TABLE configuration(id INTEGER PRIMARY KEY,tempInter TEXT,tempCriti TEXT,airInter TEXT,airCriti TEXT,indicatif TEXT,numeroUrgence TEXT,autorite TEXT,nomWifi TEXT,passWifi TEXT)');

        await database.execute(
            'CREATE TABLE adresse(id INTEGER PRIMARY KEY,adresseIP TEXT)');



        await database.rawInsert(
            'INSERT INTO capteurTemperature(nom) VALUES("Detecteur 1")');
        await database.rawInsert(
            'INSERT INTO capteurTemperature(nom) VALUES("Detecteur 2")');
        await database.rawInsert(
            'INSERT INTO capteurTemperature(nom) VALUES("Detecteur 3")');

        await database
            .rawInsert('INSERT INTO capteurGaz(nom) VALUES("Detecteur 1")');
        await database
            .rawInsert('INSERT INTO capteurGaz(nom) VALUES("Detecteur 2")');
        await database
            .rawInsert('INSERT INTO capteurGaz(nom) VALUES("Detecteur 3")');

        await database.rawInsert('INSERT INTO alarme(nom) VALUES("Alarme 1")');

        await database.rawInsert(
            'INSERT INTO configuration(tempInter,tempCriti,airInter,airCriti,indicatif,numeroUrgence,autorite,nomWifi,passWifi) VALUES("","","","","+237","","","","")');
        await database.rawInsert(
            'INSERT INTO configuration(tempInter,tempCriti,airInter,airCriti,indicatif,numeroUrgence,autorite,nomWifi,passWifi) VALUES("","","","","+237","","","","")');

        await database.rawInsert(
            'INSERT INTO adresse(adresseIP) VALUES("")');
      },
    );
  }

  static Future<void> changerNom(
      String table, String nouveauNom, int id) async {
    Database database =
        await openDatabase(join(await getDatabasesPath(), 'sfds.bd'));
    await database
        .rawUpdate('UPDATE $table SET nom = ? WHERE id = ?', [nouveauNom, id]);
  }

  static Future<List> getNom(String table) async {
    List<Map<String, dynamic>> map = [];

    Database database =
        await openDatabase(join(await getDatabasesPath(), 'sfds.bd'));
    map = await database.rawQuery('SELECT nom FROM $table');
    return map;
  }

  static Future<void> editConfig(String champ, String value, int id) async {
    Database database =
        await openDatabase(join(await getDatabasesPath(), 'sfds.bd'));
    await database.rawUpdate(
        'UPDATE configuration SET $champ = ? WHERE id = ?', [value, id]);
  }

  static Future<List> getConfig(List<String> champ) async {
    List<Map<String, dynamic>> map = [];

    String champs = champ.join(',');
    Database database =
        await openDatabase(join(await getDatabasesPath(), 'sfds.bd'));
    map = await database
        .rawQuery('SELECT $champs FROM configuration WHERE id = 2');
    return map;
  }

  static Future<List> setConfig() async {
    List<Map<String, dynamic>> map1 = [];
    List<Map<String, dynamic>> map2 = [];

    Database database =
        await openDatabase(join(await getDatabasesPath(), 'sfds.bd'));

    map1 = await database.rawQuery('SELECT * FROM configuration WHERE id = 1');
    await editConfig('tempInter', map1[0]['tempInter'], 2);
    await editConfig('tempCriti', map1[0]['tempCriti'], 2);
    await editConfig('airInter', map1[0]['airInter'], 2);
    await editConfig('airCriti', map1[0]['airCriti'], 2);
    await editConfig('indicatif', map1[0]['indicatif'], 2);
    await editConfig('numeroUrgence', map1[0]['numeroUrgence'], 2);
    await editConfig('autorite', map1[0]['autorite'], 2);
    await editConfig('nomWifi', map1[0]['nomWifi'], 2);
    await editConfig('passWifi', map1[0]['passWifi'], 2);

    map2 = await database.rawQuery(
        'SELECT tempInter,tempCriti,airInter,airCriti,indicatif,numeroUrgence,autorite,nomWifi,passWifi FROM configuration WHERE id = 2');
    
    return map2;
  }

  static Future<List> getAdresseIP() async{
    List<Map<String, dynamic>> map = [];

    Database database =
        await openDatabase(join(await getDatabasesPath(), 'sfds.bd'));
    map = await database.rawQuery('SELECT adresseIP FROM adresse WHERE id = 1');
    return map;
  }

  static Future<void> setAdresseIP(String adreese) async {
    Database database =
        await openDatabase(join(await getDatabasesPath(), 'sfds.bd'));
    await database.rawUpdate(
        'UPDATE adresse SET adresseIP = ? WHERE id = 1', [adreese]);
  }

}
