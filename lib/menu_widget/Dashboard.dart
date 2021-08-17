import 'package:flutter/cupertino.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
import 'package:mqtt_client/mqtt_browser_client.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Dashboard extends StatelessWidget {
  final TextStyle whiteText = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff282C34),
      body: body(context),
    );
  }

  Widget body(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _buildHeader(),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              Expanded(flex: 5, child: _infobox(context, 200, "title", 123)),
              const SizedBox(width: 16.0),
              Expanded(flex: 5, child: _infobox(context, 200, "title", 123)),
            ],
          ),
          const SizedBox(height: 16.0),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(flex: 2, child: _infobox(context, 300, "title", 123)),
              const SizedBox(width: 16.0),
              Expanded(flex: 5, child: _infobox(context, 300, "title", 123)),
              const SizedBox(width: 16.0),
              Expanded(
                  flex: 4,
                  child: Column(
                    children: <Widget>[
                      _infobox(context, 150, "title", 123),
                      const SizedBox(height: 16.0),
                      _infobox(context, 134, "title", 123),
                    ],
                  )),
            ],
          ),
        ],
      ),
    );
  }

  Widget _infobox(
      BuildContext context, double _height, String _title, double _info) {
    return Container(
      height: _height,
      color: Color(0xff323844),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              _info.toString(),
              style: Theme.of(context).textTheme.display1!.copyWith(
                    color: Colors.white,
                    fontSize: 24.0,
                  ),
            ),
            trailing: Icon(
              Icons.dangerous,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              _title,
              style: whiteText,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: <Widget>[
        Container(
          height: 100,
          width: 100,
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(
            value: 0.5,
            valueColor: AlwaysStoppedAnimation(Colors.blue),
            backgroundColor: Colors.grey.shade700,
          ),
        ),
        const SizedBox(width: 20.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Overall\nDaily Progress",
                style: whiteText.copyWith(fontSize: 20.0),
              ),
              const SizedBox(height: 20.0),
              Text(
                "45% to go",
                style: TextStyle(color: Colors.grey, fontSize: 16.0),
              ),
            ],
          ),
        )
      ],
    );
  }
}
