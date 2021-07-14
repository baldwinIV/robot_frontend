import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:provider/provider.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:robot_frontend/providers/MqttProvider.dart';

class InputClasses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MqttProvider aa = Provider.of<MqttProvider>(context);
    aa.getHostController().text = aa.getMqttHostName();
    aa.getPortController().text = aa.getMqttPort();
    aa.getTopicController().text = aa.getTopic();
    return Column(
      children: [
        SizedBox(
          width: 500,
          child: TextField(
            decoration: InputDecoration(
                labelText: "HostName (e.g. ws://test.mosquitto.org)"),
            controller: aa.getHostController(),
            onSubmitted: (text) =>
                {aa.manageHostController(aa.getHostController(), text)},
          ),
        ),
        SizedBox(
          width: 500,
          child: TextField(
            decoration: InputDecoration(labelText: "portnum"),
            controller: aa.getPortController(),
            onSubmitted: (text) =>
                {aa.managePortController(aa.getPortController(), text)},
          ),
        ),
        SizedBox(
          width: 500,
          child: TextField(
            decoration:
                InputDecoration(labelText: "topic to subscribe or publish"),
            controller: aa.getTopicController(),
            onSubmitted: (text) =>
                {aa.manageTopicController(aa.getTopicController(), text)},
          ),
        ),
      ],
    );
  }
}

void _publish(String message, MqttBrowserClient? _client) {
  print("pub 버튼 클릭");
  final builder = MqttClientPayloadBuilder();
  builder.addUTF8String('Hello from flutter_client');
  _client!.publishMessage(message, MqttQos.atLeastOnce, builder.payload!);
}

class LogList extends StatelessWidget {
  static const String _title = "Static ListView Example";
  static const List<String> _data = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
  ];
  Widget _buildLogList() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: _data.length,
      itemBuilder: (BuildContext _ctx, int i) {
        return ListTile(
            title: Text(
          _data[i],
          style: TextStyle(fontSize: 20),
        ));
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return _buildLogList();
  }
}

class Buttons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Consumer<MqttProvider>(
          builder: (context, mqttProvider, child) => ElevatedButton(
              onPressed: () {
                connect(mqttProvider.getTopic(), mqttProvider.getMqttHostName(),
                        mqttProvider.getMqttPort())
                    .then((clientReturned) {
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
              _publish('Hello World!', mqttProvider.getMqttClient()),
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
            onPressed: () => {mqttProvider.getMqttClient()!.disconnect()},
          ),
        ),
        Consumer<MqttProvider>(
            builder: (context, mqttProvider, child) => Column(
                  children: [
                    ElevatedButton(
                      child: Text('CH'),
                      onPressed: () => {print(mqttProvider.getTopic())},
                    ),
                    Text(mqttProvider.getTopicController().text),
                    Text(mqttProvider.getHostController().text),
                    Text(mqttProvider.getPortController().text),
                  ],
                )),
      ],
    );
  }
}
