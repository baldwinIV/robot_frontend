import 'package:flutter/material.dart';
import 'dart:async';
import 'package:mqtt_client/mqtt_client.dart' as mqtt;

class SensorMqtt extends StatelessWidget {
  const SensorMqtt({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  int mqttTongSin(int a){
    return a + 1;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFF1D4E89),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Row Alignment"),
          ElevatedButton(onPressed: () => {mqttTongSin(1)}, child: Text("GGG"))
        ],
      ),
    );
  }
}

