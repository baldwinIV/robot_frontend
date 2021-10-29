import 'package:flutter/material.dart';
import 'package:robot_frontend/menu_widget/Base64Image.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
import 'package:robot_frontend/menu_widget/Dashboard.dart';
import 'package:robot_frontend/Menu.dart';
import 'package:robot_frontend/pages/MainBoardHeader.dart';
import 'package:provider/provider.dart';
import 'package:robot_frontend/MenuController.dart';
import 'package:robot_frontend/providers/SwitchProvider.dart';
import 'package:robot_frontend/responsive.dart';

class MainBoard extends StatelessWidget {
  Widget getWidget(String widgetName) {
    switch (widgetName) {
      case "DashBoard":
        return Dashboard();
      case "Sensor":
        return SensorMqtt(title: "Hello");
      case "Image":
        return Base64Image();
      case "Robot_Control":
        return Text(
          "Robot_Control",
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
      key: context.read<MenuController>().scaffoldKey,
      drawer: Menu(),
      body: SafeArea(
          child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (Responsive.isDesktop(context))
            Expanded(
              flex: 1,
              child: Menu(),
            ),
          Expanded(
            flex: 5,
            child: Consumer<SwitchProvider>(
              builder: (context, spProvider, child) => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  MainBoardHeader(),
                  Container(
                    child: getWidget(spProvider.getRouteName()),
                  ),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
