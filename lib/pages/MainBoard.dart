import 'package:flutter/material.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
import 'package:robot_frontend/menu_widget/Dashboard.dart';
import 'package:robot_frontend/Menu.dart';
import 'package:robot_frontend/pages/MainBoardHeader.dart';
import 'package:provider/provider.dart';
import 'package:robot_frontend/providers/SwitchProvider.dart';

class MainBoard extends StatelessWidget {
  Widget getWidget(String widgetName) {
    switch (widgetName) {
      case "DashBoard":
        return Dashboard();
      case "Sensor":
        return SensorMqtt(title: "Hello");
      case "ParsedMap":
        return Text(
          "ParsedMap",
          style: TextStyle(fontSize: 30),
        );
      case "History":
        return Text(
          "History",
          style: TextStyle(fontSize: 30),
        );
      case "Settings":
        return Text(
          "Settings",
          style: TextStyle(fontSize: 30),
        );
      default:
        return Text(
          "default",
          style: TextStyle(fontSize: 30),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 1,
            child: Menu(),
          ),
          Expanded(
            flex: 5,
            child: Consumer<SwitchProvider>(
              builder: (context, spProvider, child) => Column(
                children: [
                  MainBoardHeader(),
                  Expanded(
                    flex: 2,
                    child: Text("a"),
                  ),
                  Expanded(
                    flex: 4,
                    child: getWidget(spProvider.getRouteName()),
                  ),
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
              ),
            ),
          )
        ],
      )),
    );
  }
}
