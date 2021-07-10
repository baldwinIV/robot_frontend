import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:robot_frontend/menu_widget/sensorMqttComponent/SensorMqttComponent.dart';

Future<MqttBrowserClient> connect(String topic) async {
  print("before connected topic? $topic");
  MqttBrowserClient client = MqttBrowserClient.withPort(
      'ws://test.mosquitto.org', 'flutter_client', 8080);
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
    //await client.connect();
    await client.connect("sherofirstprize", "\$\$ManyMany100");
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  } // Not a wildcard topic
  //client.subscribe(topic, MqttQos.atLeastOnce);
  client.updates!.listen((List<MqttReceivedMessage<MqttMessage?>>? c) {
    final recMess = c![0].payload as MqttPublishMessage;
    final pt =
        MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
    print(
        'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');
    print('');
  });
  client.published!.listen((MqttPublishMessage message) {
    print(
        'EXAMPLE::Published notification:: topic is ${message.variableHeader!.topicName}, with Qos ${message.header!.qos}');
  });
  return client;
}


class SensorMqtt extends StatelessWidget {
  SensorMqtt({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    child: InputClasses(),
                    padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                  ),
                  Container(
                    child: Buttons(),
                    padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
