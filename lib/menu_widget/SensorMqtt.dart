import 'dart:js';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart';

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

class MqttProvider with ChangeNotifier {
  MqttBrowserClient? _mqttClient;
  String _topic;

  String getTopic() => _topic;

  MqttBrowserClient? getMqttClient() => _mqttClient;

  MqttProvider(this._topic); //default = /test

  void manageTopic(String topic) {
    _topic = topic;
    notifyListeners();
  }

  void manageMqttClient(MqttBrowserClient mqttClient) {
    _mqttClient = mqttClient;
    notifyListeners();
  }
}

class SensorMqtt extends StatelessWidget {
  SensorMqtt({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  void _publish(String message, MqttBrowserClient? _client) {
    print("pub 버튼 클릭");
    final builder = MqttClientPayloadBuilder();
    builder.addUTF8String('Hello from flutter_client');
    _client!.publishMessage(message, MqttQos.atLeastOnce, builder.payload!);
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
                  TextField(
                      decoration: InputDecoration(
                          labelText: "HostName (e.g. ws://test.mosquitto.org)")),
                  TextField(decoration: InputDecoration(labelText: "portnum")),
                  Consumer<MqttProvider>(
                    builder: (context, mqttProvider, child) => ElevatedButton(
                        onPressed: () {
                          connect(mqttProvider._topic).then((clientReturned) {
                            mqttProvider.manageMqttClient(clientReturned);
                          }, onError: (e) {
                            print(e);
                          });
                        },
                        child: Text("Connect")),
                  ),
                  Consumer<MqttProvider>(
                    builder: (context, mqttProvider, child) => ElevatedButton(
                      child: Text('Publish message'),
                      onPressed: () => {
                        this._publish('Hello World!', mqttProvider.getMqttClient()),
                        print("pub to ${mqttProvider.getTopic()} topic")
                      },
                    ),
                  ),
                  Consumer<MqttProvider>(
                    builder: (context, mqttProvider, child) => ElevatedButton(
                      child: Text('Subscribe Topic'),
                      onPressed: () => {
                        mqttProvider
                            .getMqttClient()!
                            .subscribe(mqttProvider.getTopic(), MqttQos.atLeastOnce),
                        print("${mqttProvider.getTopic()} is subed")
                      },
                    ),
                  ),
                  Consumer<MqttProvider>(
                    builder: (context, mqttProvider, child) => ElevatedButton(
                      child: Text('Disconnect'),
                      onPressed: () =>
                          {mqttProvider.getMqttClient()!.disconnect()},
                    ),
                  ),
                  Consumer<MqttProvider>(
                    builder: (context, mqttProvider, child) => Text(mqttProvider.getTopic()),
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
