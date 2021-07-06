import 'package:flutter/material.dart';
import 'package:robot_frontend/main.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
import 'package:provider/provider.dart';

class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Expanded(
            child: Drawer(
              child: SingleChildScrollView(
                child: Column(
                  //default flex = 1, and it takes 1/6
                  children: [
                    DrawerHeader(child: Image.asset("assets/logo/logo.png")),
                    ListTile(
                      onTap: () => {},
                      horizontalTitleGap: 0.0,
                      leading: Icon(
                        Icons.clean_hands,
                        color: Colors.white,
                      ),
                      title: Text(
                        "Hello S-HERO",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    DrawerListTile(
                      title: "Connect to Robot",
                      press: () {},
                    ),
                    DrawerListTile(
                      title: "Mqtt",
                      press: () {},
                    ),
                    DrawerListTile(
                      title: "View Parsed Map",
                      press: () {},
                    ),
                    DrawerListTile(
                      title: "History",
                      press: () {},
                    ),
                    DrawerListTile(
                      title: "Settings",
                      press: () {},
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            //여기에 뭐가 렌더링 되면 될듯!
            flex: 5,
            child: SensorMqtt(title: "Hello"),
          )
        ],
      )),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);
  final String title;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
        onTap: this.press,
        horizontalTitleGap: 0.0,
        leading: Icon(Icons.add),
        title: Text(this.title));
  }
}
