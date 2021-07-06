import 'dart:ui';
import 'package:flutter/material.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                "Hello S-HERO",
                style: TextStyle(color: Colors.white),
              ),
            ),
            DrawerListTile(
              title: "Dashboard",
              press: () => {
                // Navigator.pushNamed(context, '/dashboard', arguments: {}),
              },
            ),
            DrawerListTile(
              title: "Mqtt",
              press: () => {
                // Navigator.pushNamed(context, '/sensorboard', arguments: {}),
              },
            ),
            DrawerListTile(
              title: "View Parsed Map",
              press: () => {
                //Navigator.pushNamed(context, '/parsedmap', arguments: {}),
              },
            ),
            DrawerListTile(
              title: "History",
              press: () => {
                //Navigator.pushNamed(context, '/parsedmap', arguments: {}),
              },
            ),
            DrawerListTile(
              title: "Settings",
              press: () => {
                // Navigator.pushNamed(context, '/parsedmap', arguments: {}),
              },
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
