import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:collection';
import 'dart:convert';
import 'package:robot_frontend/providers/data_from_client.dart';
import 'package:robot_frontend/providers/data_from_client_7.dart';
import 'package:robot_frontend/providers/data_from_client_image.dart';
import 'package:robot_frontend/providers/data_from_client_torobot.dart';

class MqttProvider with ChangeNotifier {
  MqttServerClient? _mqttClient;
  String _topic;
  String _mqttHostName = "61.83.204.205";
  String _mqttPort = "1883";
  String _base64String_map1 =
      "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";
  String _base64String_map2 =
      "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==";

  DataFromClient gettemp_24() => _temp_24;
  DataFromClient _temp_24 = DataFromClient(1, "default");

  DataFromClient getCO2_24() => _CO2_24;
  DataFromClient _CO2_24 = DataFromClient(1, "default");

  DataFromClient gethum_24() => _hum_24;
  DataFromClient _hum_24 = DataFromClient(1, "default");

  DataFromClient getVOC_24() => _VOC_24;
  DataFromClient _VOC_24 = DataFromClient(1, "default");

  DataFromClient getpm10_24() => _pm10_24;
  DataFromClient _pm10_24 = DataFromClient(1, "default");

  DataFromClient getpm2_24() => _pm2_24;
  DataFromClient _pm2_24 = DataFromClient(1, "default");

  DataFromClient7 gettemp_7() => _temp_7;
  DataFromClient7 _temp_7 = DataFromClient7(1, "default");

  DataFromClient7 getCO2_7() => _CO2_7;
  DataFromClient7 _CO2_7 = DataFromClient7(1, "default");

  DataFromClient7 gethum_7() => _hum_7;
  DataFromClient7 _hum_7 = DataFromClient7(1, "default");

  DataFromClient7 getVOC_7() => _VOC_7;
  DataFromClient7 _VOC_7 = DataFromClient7(1, "default");

  DataFromClient7 getpm10_7() => _pm10_7;
  DataFromClient7 _pm10_7 = DataFromClient7(1, "default");

  DataFromClient7 getpm2_7() => _pm2_7;
  DataFromClient7 _pm2_7 = DataFromClient7(1, "default");

  DataFromClientImage getdataImage() => _dataImage;
  DataFromClientImage _dataImage = DataFromClientImage(
      "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg==",
      1);

  var hostController = TextEditingController();
  var portController = TextEditingController();
  var topicController = TextEditingController();
  Queue<String> _data = Queue<String>();

  int getLength() => _data.length;

  Queue<String> getData() => _data;

  MqttServerClient? getMqttClient() => _mqttClient;

  String getTopic() => _topic;

  String getMqttHostName() => _mqttHostName;

  String getMqttPort() => _mqttPort;

  String getBase64Map1() => _base64String_map1;

  String getBase64Map2() => _base64String_map2;

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
      print("24hour의 temp가 업데이트");
      _temp_24 = DataFromClient.fromJson(jsonData);
      print("24hour의 temp가 업데이트~~");
    } else if (jsonData['type'] == "hum") {
      print("24hour의 hum 업데이트");
      _hum_24 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "co2") {
      print("24hour의 co2 업데이트");
      _CO2_24 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "voc") {
      print("24hour의 voc 업데이트");
      _VOC_24 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "pm10") {
      print("24hour의 pm10 업데이트");
      _pm10_24 = DataFromClient.fromJson(jsonData);
    } else if (jsonData['type'] == "pm2") {
      print("24hour의 pm2 업데이트");
      _pm2_24 = DataFromClient.fromJson(jsonData);
    } else {
      print("asdfasdfasdfasdfasdfasdfasdfasdfasdf");
    }

    notifyListeners();
  }

  void manage7days(String data7days) {
    Map<String, dynamic> jsonData = jsonDecode(data7days);
    if (jsonData['type'] == "temp") {
      _temp_7 = DataFromClient7.fromJson(jsonData);
    } else if (jsonData['type'] == "hum") {
      _hum_7 = DataFromClient7.fromJson(jsonData);
    } else if (jsonData['type'] == "co2") {
      _CO2_7 = DataFromClient7.fromJson(jsonData);
    } else if (jsonData['type'] == "voc") {
      _VOC_7 = DataFromClient7.fromJson(jsonData);
    } else if (jsonData['type'] == "pm10") {
      _pm10_7 = DataFromClient7.fromJson(jsonData);
    } else if (jsonData['type'] == "pm2") {
      _pm2_7 = DataFromClient7.fromJson(jsonData);
    }

    notifyListeners();
  }

  void manageimage(String dataImage) {
    Map<String, dynamic> jsonData = jsonDecode(dataImage);
    _dataImage = DataFromClientImage.fromJson(jsonData);
    notifyListeners();
  }


  void manageMqttClient(MqttServerClient mqttClient) {
    _mqttClient = mqttClient;
    notifyListeners();
  }

  void manageBASE64map1(String map1) {
    _base64String_map1 = map1;
    notifyListeners();
  }

  void manageBASE64map2(String map2) {
    _base64String_map2 = map2;
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
