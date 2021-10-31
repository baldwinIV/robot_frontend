import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:mqtt_client/mqtt_client.dart';
// import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:robot_frontend/providers/MqttProvider.dart';
import 'package:robot_frontend/providers/data_from_client_torobot.dart';
import 'package:robot_frontend/providers/data_from_client_image.dart';

Image imageFromBase64String(String base64String) {
  return new Image.memory(base64Decode(base64String));
}

Uint8List dataFromBase64String(String base64String) {
  return base64Decode(base64String);
}

String base64String(Uint8List data) {
  return base64Encode(data);
}

Consumer<MqttProvider> mapComponent(String _base64) {
  return Consumer<MqttProvider>(
    builder: (context, mqttprovider, child) => Container(
      margin: const EdgeInsets.fromLTRB(10, 10, 0, 0),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.orange,
        ),
      ),
      child: SizedBox(
        width: 300,
        height: 350,
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [imageFromBase64String(mqttprovider.getdataImage().image), Text("Image")]),
      ),
    ),
  );
}
void _publish(String topic, MqttServerClient? _client, MqttProvider mqttProvider,String message) {
  final builder = MqttClientPayloadBuilder();
  builder.addUTF8String(message);
  _client!.publishMessage(topic, MqttQos.atLeastOnce, builder.payload!);
  mqttProvider.addStringToQueue("topic:" + topic + " pubbed : " + 'Hello from flutter_client');
}

class Base64Image extends StatelessWidget {
  void onClick(String input, MqttProvider inputProvider){
    if(input == "start"){
      _publish("robot_controller",inputProvider.getMqttClient(),inputProvider,"{\"data\" : \"start\"}");
    }else if(input == "robot_start"){
      _publish("robot_controller",inputProvider.getMqttClient(),inputProvider,"{\"data\" : \"robot_start\"}");
    }else if(input == "stop"){
      _publish("robot_controller",inputProvider.getMqttClient(),inputProvider,"{\"data\" : \"stop\"}");
    }else if(input == "left"){
      _publish("robot_controller",inputProvider.getMqttClient(),inputProvider,"{\"data\" : \"left\"}");
    }else if(input == "right"){
      _publish("robot_controller",inputProvider.getMqttClient(),inputProvider,"{\"data\" : \"right\"}");
    }else if(input == "forward"){
      _publish("robot_controller",inputProvider.getMqttClient(),inputProvider,"{\"data\" : \"forward\"}");
    }else if(input == "backward"){
      _publish("robot_controller",inputProvider.getMqttClient(),inputProvider,"{\"data\" : \"backward\"}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MqttProvider>(
        builder: (context, mqttProvider, child) => new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    mapComponent(mqttProvider.getBase64Map1()),
                    mapComponent(mqttProvider.getBase64Map1()),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 50,
                      child:ElevatedButton(onPressed: () => {onClick("start", mqttProvider)}, child: Text("start")),
                    ),
                    SizedBox(
                      width: 170,
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child:ElevatedButton(onPressed: () => {onClick("robot_start", mqttProvider)}, child: Text("robot_start")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 160,
                      height: 50,
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child:ElevatedButton(onPressed: () => {onClick("forward", mqttProvider)}, child: Text("forward")),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 150,
                      height: 50,
                      child:ElevatedButton(onPressed: () => {onClick("left", mqttProvider)}, child: Text("left")),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child:ElevatedButton(onPressed: () => {onClick("stop", mqttProvider)}, child: Text("stop")),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 150,
                      height: 50,
                      child:ElevatedButton(onPressed: () => {onClick("right", mqttProvider)}, child: Text("right"))
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    SizedBox(
                        width: 160,
                        height: 50,
                    ),
                    SizedBox(
                        width: 150,
                        height: 50,
                        child:ElevatedButton(onPressed: () => {onClick("backward", mqttProvider)}, child: Text("backward"))
                    ),
                  ],
                ),
              ],
            ));
  }
}
