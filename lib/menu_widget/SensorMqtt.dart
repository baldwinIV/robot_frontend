import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'dart:io';

Future<MqttClient> connect() async {
  String topic = 'test';
  print("go go");
  MqttBrowserClient client =
      MqttBrowserClient.withPort('61.83.204.205', 'flutter_client', 1883);
  client.logging(on: true); //logging 허용
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
      .withWillMessage('connect asdf')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMess;
  try {
    print('Connecting');
    await client.connect();
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  }
  print('Success');
  return client;
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

class SensorMqtt extends StatelessWidget {
  const SensorMqtt({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  int mqttTongSin(int a) {
    return a + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Expanded(
          flex: 1,
          child: Column(
            children: [
              TextField(decoration: InputDecoration(hintText: "Ip주소")),
              TextField(decoration: InputDecoration(hintText: "포트번호")),
              ElevatedButton(
                  onPressed: () {
                    connect();
                  },
                  child: Text("Connect")),
              Text("~~~~~~~~~"),
            ],
          ),
        ),
      ),
    );
  }
}
