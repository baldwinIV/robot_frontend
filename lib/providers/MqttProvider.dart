import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:robot_frontend/providers/data_from_client.dart';

class MqttProvider with ChangeNotifier {
  MqttBrowserClient? _mqttClient;
  String _topic;
  String _mqttHostName = "ws://test.mosquitto.org";
  String _mqttPort = "8080";

  DataFromClient _temp_24 = DataFromClient(1, "default");
  DataFromClient gettemp_24() => _temp_24;
  DataFromClient _temp_7 = DataFromClient(1, "default");
  DataFromClient gettemp_7() => _temp_7;
  DataFromClient _hum_24 = DataFromClient(1, "default");
  DataFromClient gethum_24() => _hum_24;
  DataFromClient _hum_7 = DataFromClient(1, "default");
  DataFromClient gethum_7() => _hum_7;
  DataFromClient _CO2_24 = DataFromClient(1, "default");
  DataFromClient getCO2_24() => _CO2_24;
  DataFromClient _CO2_7 = DataFromClient(1, "default");
  DataFromClient getCO2_7() => _CO2_7;
  DataFromClient _VOC_24 = DataFromClient(1, "default");
  DataFromClient getVOC_24() => _VOC_24;
  DataFromClient _VOC_7 = DataFromClient(1, "default");
  DataFromClient getVOC_7() => _VOC_7;
  DataFromClient _pm10_24 = DataFromClient(1, "default");
  DataFromClient getpm10_24() => _pm10_24;
  DataFromClient _pm10_7 = DataFromClient(1, "default");
  DataFromClient getpm10_7() => _pm10_7;
  DataFromClient _pm2_24 = DataFromClient(1, "default");
  DataFromClient getpm2_24() => _pm2_24;
  DataFromClient _pm2_7 = DataFromClient(1, "default");
  DataFromClient getpm2_7() => _pm2_7;

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

  void manage24hours(String data24hours) {
    Map<String, dynamic> jsonData = jsonDecode(data24hours);
    if (jsonData['type'] == "temp") {
      print("12");
      _temp_24 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "hum") {
      print("1");
      _hum_24 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "co2") {
      print("1");
      _CO2_24 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "voc") {
      print("1");
      _VOC_24 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "pm10") {
      print("1");
      _pm10_24 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "pm2") {
      print("1");
      _pm2_24 = DataFromClient.fromJson(jsonData);
    }

    notifyListeners();
  }

  void manage7days(String data7days) {
    Map<String, dynamic> jsonData = jsonDecode(data7days);
    if (jsonData['type'] == "temp") {
      _temp_7 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "hum") {
      _hum_7 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "co2") {
      _CO2_7 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "voc") {
      _VOC_7 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "pm10") {
      _pm10_7 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "pm2") {
      _pm2_7 = DataFromClient.fromJson(jsonData);
    }

    notifyListeners();
  }

  // void manageImage(String imageAnswer) {
  //   _imageAnswer = imageAnswer;
  //   notifyListeners();
  // }

  // void manage24hoursdata(String imageAnswer) {
  //   _imageAnswer = imageAnswer;
  //   notifyListeners();
  // }

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
