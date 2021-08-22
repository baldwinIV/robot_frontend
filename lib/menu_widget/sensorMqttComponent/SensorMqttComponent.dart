import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:provider/provider.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
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

void _publish(String topic, MqttBrowserClient? _client, MqttProvider mqttProvider) {
  final builder = MqttClientPayloadBuilder();
  builder.addUTF8String('Hello from flutter_client');
  _client!.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  mqttProvider.addStringToQueue("topic:" + topic + " pubbed : " + 'Hello from flutter_client');
}

class LogList extends StatelessWidget {
  Widget _buildLogList() {
    return Consumer<MqttProvider>(
        builder: (context, lp, child) => ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: lp.getLength(),
              itemBuilder: (BuildContext _ctx, int i) {
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Color(0xff989898),
                    ),
                  ),
                  child: ListTile(
                      title: Text(
                    lp.getData().elementAt(i),
                    style: TextStyle(fontSize: 15),
                  )),
                );
              },
            ));
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Consumer<MqttProvider>(
          builder: (context, mqttProvider, child) => ElevatedButton(
              onPressed: () {
                mqttProvider.addStringToQueue("Waits for Connected...");
                SensorMqtt.connect(mqttProvider.getTopic(), mqttProvider.getMqttHostName(),
                        mqttProvider.getMqttPort(),context,mqttProvider)
                    .then((clientReturned) {
                  mqttProvider.manageMqttClient(clientReturned); //return 된 client를 프로바이더로 관리한다.
                }, onError: (e) {
                  mqttProvider.addStringToQueue("error");
                });
              },
              child: Text("Connect")),
        ),
        Consumer<MqttProvider>(
          builder: (context, mqttProvider, child) => ElevatedButton(
            child: Text('Publish message'),
            onPressed: () => {
              _publish(mqttProvider.getTopic(), mqttProvider.getMqttClient(), mqttProvider),
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
              mqttProvider.addStringToQueue("${mqttProvider.getTopic()} is subed"),
            },
          ),
        ),
        Consumer<MqttProvider>(
          builder: (context, mqttProvider, child) => ElevatedButton(
            child: Text('Disconnect'),
            onPressed: () => {mqttProvider.getMqttClient()!.disconnect(),
              mqttProvider.addStringToQueue("Disconnected"),},
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
