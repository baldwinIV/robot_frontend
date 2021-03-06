import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robot_frontend/providers/SwitchProvider.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SwitchProvider spProvider = Provider.of<SwitchProvider>(context);
    return Drawer(
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
                "Robot Control App",
                style: TextStyle(color: Colors.white),
              ),
            ),
            Consumer<SwitchProvider>(
              builder: (context, spProvider, child) => DrawerListTile(
                title: "DashBoard",
                press: () => {spProvider.manageData("DashBoard")},
              ),
            ),
            Consumer<SwitchProvider>(
              builder: (context, spProvider, child) => DrawerListTile(
                title: "Mqtt",
                press: () => {spProvider.manageData("Sensor")},
              ),
            ),
            Consumer<SwitchProvider>(
              builder: (context, spProvider, child) => DrawerListTile(
                title: "Image",
                press: () => {spProvider.manageData("Image")},
              ),
            ),
            Consumer<SwitchProvider>(
              builder: (context, spProvider, child) => DrawerListTile(
                title: "Robot Control",
                press: () => {spProvider.manageData("Robot_Control")},
              ),
            ),
            Consumer<SwitchProvider>(
              builder: (context, spProvider, child) => DrawerListTile(
                title: "Setting",
                press: () => {spProvider.manageData("Settings")},
              ),
            ),
          ],
        ),
      ),
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
        leading: Image.asset(
          "assets/logo/robot.png",
          height: 25,
        ),
        title: Text(this.title));
  }
}
