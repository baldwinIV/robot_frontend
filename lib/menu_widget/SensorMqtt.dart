import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';

Future<MqttBrowserClient> connect() async {
  String topic = '/Hello';
  print("before connected");
  MqttBrowserClient client =
      MqttBrowserClient.withPort('ws://61.83.204.205', 'flutter_client', 8080);
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
      .withWillMessage('death')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);
  client.connectionMessage = connMess;
  try {
    print('Connecting');
    await client.connect();
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  } // Not a wildcard topic
  client.subscribe(topic, MqttQos.atMostOnce);
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
  SensorMqtt({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  MqttBrowserClient? client;

  void _publish(String message) {
    final builder = MqttClientPayloadBuilder();
    builder.addUTF8String('Hello from flutter_client');
    client?.publishMessage("/Hello", MqttQos.atLeastOnce, builder.payload!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  TextField(decoration: InputDecoration(hintText: "Ip주소")),
                  TextField(decoration: InputDecoration(hintText: "포트번호")),
                  ElevatedButton(
                      onPressed: () {
                        connect().then((clientReturned) {
                          client = clientReturned;
                          print("Hello");
                        }, onError: (e) {
                          //print(e);
                        });
                      },
                      child: Text("Connect")),
                  ElevatedButton(
                    child: Text('Publish to 61.83.204.205 -t /test'),
                    onPressed: () => {this._publish('Hello')},
                  ),

                  ElevatedButton(
                    child: Text('Disconnect'),
                    onPressed: () => {client?.disconnect()},
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
