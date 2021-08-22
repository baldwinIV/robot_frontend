import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'dart:collection';

class MqttProvider with ChangeNotifier {
  MqttBrowserClient? _mqttClient;
  String _topic;
  String _mqttHostName = "ws://test.mosquitto.org";
  String _mqttPort = "8080";
  var hostController = TextEditingController();
  var portController = TextEditingController();
  var topicController = TextEditingController();
  Queue<String> _data = Queue<String>();

  int getLength() => _data.length;

  Queue<String> getData() => _data;

  MqttBrowserClient? getMqttClient() => _mqttClient;

  String getTopic() => _topic;

  String getMqttHostName() => _mqttHostName;

  String getMqttPort() => _mqttPort;

  TextEditingController getHostController() => hostController;

  TextEditingController getPortController() => portController;

  TextEditingController getTopicController() => topicController;

  MqttProvider(this._topic) {
    hostController.text = "None";
    portController.text = "None";
    topicController.text = "None";
    print("asd");
  } //default = /test
  void addStringToQueue(String toAdd) {
    if (_data.length >= 100) {
      _data.removeFirst();
    }
    _data.addLast(toAdd);
    notifyListeners(); //must be inserted
  }

  void manageTopic(String topic) {
    _topic = topic;
    notifyListeners();
  }

  void manageMqttClient(MqttBrowserClient mqttClient) {
    _mqttClient = mqttClient;
    notifyListeners();
  }

  void manageMqttHostAndPort(String host, String port) {
    _mqttHostName = host;
    _mqttPort = port;
    notifyListeners();
  }

  void manageHostController(TextEditingController controller, String a) {
    hostController = controller;
    hostController.text = a;
    _mqttHostName = a;
    notifyListeners();
  }

  void managePortController(TextEditingController controller, String a) {
    portController = controller;
    portController.text = a;
    _mqttPort = a;
    notifyListeners();
  }

  void manageTopicController(TextEditingController controller, String a) {
    topicController = controller;
    topicController.text = a;
    _topic = a;
    notifyListeners();
  }
}
