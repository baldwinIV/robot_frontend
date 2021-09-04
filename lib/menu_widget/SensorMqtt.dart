import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:robot_frontend/menu_widget/sensorMqttComponent/SensorMqttComponent.dart';
import 'package:robot_frontend/providers/MqttProvider.dart';
class SensorMqtt extends StatelessWidget {
  SensorMqtt({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  static Future<MqttBrowserClient> connect(String topic, String host,
      String port, BuildContext context, MqttProvider mqttProvider) async {
    MqttBrowserClient client =
        MqttBrowserClient.withPort(host, 'flutter_client', int.parse(port));
    client.logging(on: false);
    client.onConnected = onConnected;
    client.onDisconnected = onDisconnected;
    client.keepAlivePeriod = 20;
    client.onUnsubscribed =
        (String? topic) => {print('Unsubscribed topic: $topic')};
    client.onSubscribed = onSubscribed;
    client.onSubscribeFail = onSubscribeFail;
    client.pongCallback = pong;
    //클라이언트 기본설정
    //will 유언
    final connMess = MqttConnectMessage()
        .withWillTopic(topic)
        .withWillMessage('death')
        .startClean()
        .withWillQos(MqttQos.atLeastOnce);
    client.connectionMessage = connMess;
    try {
      print('Connecting');
      mqttProvider.addStringToQueue("try to connect.");
      //await client.connect();
      await client.connect("sherofirstprize", "\$\$ManyMany100");
    } catch (e) {
      print('Exception: $e');
      client.disconnect();
    } // Not a wildcard topic
    mqttProvider.addStringToQueue("connected");

    client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
      final recMess = c![0].payload as MqttPublishMessage;
      final pt =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      mqttProvider.addStringToQueue(
          'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload : <-- $pt -->');
      dashboardUpdate(c[0].topic,pt,mqttProvider);
    });
    client.published!.listen((MqttPublishMessage message) {
      print(
          'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
    });
    client.subscribe("24hours_data_answer", MqttQos.atLeastOnce);
    client.subscribe("7days_data_answer", MqttQos.atLeastOnce);
    client.subscribe("image_answer", MqttQos.atLeastOnce);
    //--24시간 데이터 요청
    return client;
  }
  static void dashboardUpdate(String topic, String payload, MqttProvider mqttProvider){
    if(topic == "image_answer"){
      // mqttProvider.manageImage(payload);
    }else if(topic == "7days_data_answer"){
      mqttProvider.addStringToQueue("7days_data_answer를 받았다!");
      mqttProvider.manage7days(payload);
    }else if(topic == "24hours_data_answer"){
      mqttProvider.addStringToQueue("24hours_data_answer를 받았다!");
      mqttProvider.manage24hours(payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Column(
          children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: InputClasses(),
            ),
            Column(
              children: [
                Container(
                  child: Buttons(),
                ),
              ],
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: Colors.black,
                ),
                color: Color(0xff323844),
              ),
              child: SizedBox(
                child: LogList(),
                width: 500,
                height: 500,
              ),
            ),
          ],
        ),
      ]),
    );
  }
}

void onConnected() {
  print('Connected');
}

void onDisconnected() {
  print('Disconnected');
}

void onSubscribed(String topic) {
  print('Subscribed topic: $topic');
}

void onSubscribeFail(String topic) {
  print('Failed to subscribe topic: $topic');
}

void pong() {
  print('Ping response client callback invoked');
}
