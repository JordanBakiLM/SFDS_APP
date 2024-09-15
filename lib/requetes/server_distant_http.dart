import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ServerDistant {
  static String tokenBlynk = "AvZvPy6gsRzr1-61fF9rkJlF4vwfIeJ9";

  static String host = 'https://blynk.cloud/external/api/';

  static Future<dynamic> centraleOnLine() async {
    try {
      final response = await http.get(
        Uri.parse('${host}isHardwareConnected?token=$tokenBlynk'),
      );
      return (jsonDecode(response.body));
    } catch (e) {
      return -1;
    }
  }

  static Future<dynamic> switchAlarm(int val) async {
    try {
      final response = await http.get(
        Uri.parse('${host}update?token=$tokenBlynk&V0=$val'),
      );
      return (jsonDecode(response.body));
    } catch (e) {
      return -1;
    }
  }

  static Future<dynamic> getValeur(String broche) async {
    try {
      final response = await http.get(
        Uri.parse('${host}get?token=$tokenBlynk&$broche'),
      );
      return ((response.body));
    } catch (e) {
      return -1;
    }
  }
}
