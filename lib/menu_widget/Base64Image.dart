import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:robot_frontend/providers/MqttProvider.dart';
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

class Base64Image extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MqttProvider>(
        builder: (context, mqttProvider, child) => new Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                mapComponent(mqttProvider.getBase64Map1()),
                mapComponent(mqttProvider.getBase64Map1()),
                Column(
                  children: [
                    ElevatedButton(onPressed: () => {}, child: Text("start")),
                    ElevatedButton(onPressed: () => {}, child: Text("stop")),
                    ElevatedButton(onPressed: () => {}, child: Text("Left")),
                    ElevatedButton(onPressed: () => {}, child: Text("Up")),
                    ElevatedButton(onPressed: () => {}, child: Text("Right")),
                    ElevatedButton(onPressed: () => {}, child: Text("Down"))
                  ],
                )
              ],
            ));
  }
}
