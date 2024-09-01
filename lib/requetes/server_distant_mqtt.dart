import 'package:flutter/foundation.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

class MqttService {
  final String tokenBlynk = "AvZvPy6gsRzr1-61fF9rkJlF4vwfIeJ9";
  MqttServerClient client = MqttServerClient('blynk.cloud', 'sfds-clent_mqtt');

  MqttService() { 
    client.port = 8883; //1883 8883
    client.logging(on: true);
    client.keepAlivePeriod = 45;
    client.onDisconnected = onDisconnected;
    client.secure = true; 
  }

  Future<void> connect() async {
    try {
      await client.connect('device', tokenBlynk);
      if (kDebugMode) {
        print('connecte au server broken');
      }
    } catch (e) {
      if (kDebugMode) {
        print('erreur de connexion: $e');
      }
      client.disconnect();
    }
  }

  void onDisconnected() {
    if (kDebugMode) {
      print('deconnecte');
    }
  }

  void disConnect() {
    client.disconnect();
  }
}
