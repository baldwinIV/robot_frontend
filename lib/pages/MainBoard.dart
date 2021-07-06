import 'package:flutter/material.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
import 'package:robot_frontend/Menu.dart';
import 'package:provider/provider.dart';

class SwitchProvider with ChangeNotifier {
  String _routeName = "default";

  String getRouteName() => _routeName;

  SwitchProvider(this._routeName);

  void manageData(String toChangeRoute) {
    _routeName = toChangeRoute;
    notifyListeners();
  }
}

class MainBoard extends StatelessWidget {
  Widget getWidget(String widgetName) {
    switch (widgetName) {
      case "DashBoard":
        return Text("DashBoard",style: TextStyle(fontSize: 30),);
      case "Sensor":
        return SensorMqtt(title: "Hello");
      case "ParsedMap":
        return Text("ParsedMap",style: TextStyle(fontSize: 30),);
      case "History":
        return Text("History",style: TextStyle(fontSize: 30),);
      case "Settings":
        return Text("Settings",style: TextStyle(fontSize: 30),);
      default:
        return Text("default",style: TextStyle(fontSize: 30),);
    }
  }

  @override
  Widget build(BuildContext context) {
    SwitchProvider spProvider = Provider.of<SwitchProvider>(context);
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
            flex: 5,
            child: Consumer<SwitchProvider>(
              builder: (context, spProvider, child) =>
                  getWidget(spProvider.getRouteName()),
            ),
          )
        ],
      )),
    );
  }
}
