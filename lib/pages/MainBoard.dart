import 'package:flutter/material.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
import 'package:robot_frontend/Menu.dart';
import 'package:provider/provider.dart';

class MainBoard extends StatelessWidget {
  Widget getWidget(String widgetName) {
    int x = 2;
    switch(widgetName){
      case 'Sensor':
        return SensorMqtt(title: "Hello");
      default :
        return Text("HelloWorld");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 1,
                child: Menu(),
              ),
              Expanded(
                //여기에 뭐가 렌더링 되면 될듯!
                flex: 5,
                child: getWidget('Sensor'),
              )
            ],
          )),
    );
  }
}
