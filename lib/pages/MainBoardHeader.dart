import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
import 'package:robot_frontend/providers/MqttProvider.dart';

class MainBoardHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<MqttProvider>(
          builder: (context, mqttProvider, child) => Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF323844),
                  border: Border.all(
                    color: Color(0xff282C34),
                    width: 1.0,
                  ),
                ),
                child: Row(
                  children: [
                    Text(
                      "DASHBOARD  ",
                      style: Theme.of(context).textTheme.headline3,
                    ),
                    Text(mqttProvider.getTopic() + "   "),
                    Text(mqttProvider.getMqttHostName() + "   "),
                    Text(mqttProvider.getMqttPort()),
                  ],
                ),
              )),
    );
  }
}
