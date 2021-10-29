import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:robot_frontend/providers/MqttProvider.dart';
import 'package:robot_frontend/menu_widget/chart/Sensorchart.dart';
import 'package:robot_frontend/responsive.dart';

class Dashboard extends StatelessWidget {
  final TextStyle whiteText = TextStyle(color: Colors.white);

  @override
  Widget build(BuildContext context) {
    if (!Responsive.isMobile(context)) {
      return Expanded(
        flex: 1,
        child: Scaffold(
          backgroundColor: Color(0xff282C34),
          body: body(context),
        ),
      );
    }
    else{
      return Expanded(
        flex: 1,
        child: Scaffold(
          backgroundColor: Color(0xff282C34),
          body: body_mobile(context),
        ),
      );
    }
  }

  Widget body(BuildContext context) {
    return Consumer<MqttProvider>(
        builder: (context, mqttProvider, child) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeader(),
                  const SizedBox(height: 16.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: _infobox(context, 200, "temp",
                              mqttProvider.gettemp_24().main.hour1)),
                      const SizedBox(width: 16.0),
                      Expanded(
                          flex: 5,
                          child: _infobox(context, 200, "Humidity",
                              mqttProvider.gethum_24().main.hour1)),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                          flex: 2,
                          child: _infobox(context, 300, "Co2",
                              mqttProvider.getCO2_24().main.hour1)),
                      const SizedBox(width: 16.0),
                      Expanded(
                          flex: 5,
                          child: _infobox(context, 300, "VOC",
                              mqttProvider.getVOC_24().main.hour1)),
                      const SizedBox(width: 16.0),
                      Expanded(
                          flex: 4,
                          child: Column(
                            children: <Widget>[
                              _infobox(context, 150, "pm10",
                                  mqttProvider.getpm10_24().main.hour1),
                              const SizedBox(height: 16.0),
                              _infobox(context, 134, "pm2",
                                  mqttProvider.getpm2_24().main.hour1),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(flex: 3, child: SensorChart(dfc: mqttProvider.gettemp_24(),dfc7: mqttProvider.gettemp_7())),
                      const SizedBox(width: 16.0),
                      Expanded(flex: 3, child: SensorChart(dfc: mqttProvider.gethum_24(),dfc7: mqttProvider.gethum_7())),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(flex: 3, child: SensorChart(dfc: mqttProvider.getCO2_24(),dfc7: mqttProvider.getCO2_7())),
                      const SizedBox(width: 16.0),
                      Expanded(flex: 3, child: SensorChart(dfc: mqttProvider.getVOC_24(),dfc7: mqttProvider.getVOC_7())),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(flex: 3, child: SensorChart(dfc: mqttProvider.getpm10_24(),dfc7: mqttProvider.getpm10_7())),
                      const SizedBox(width: 16.0),
                      Expanded(flex: 3, child: SensorChart(dfc: mqttProvider.getpm10_24(),dfc7: mqttProvider.getpm2_7())),
                    ],
                  ),
                ],
              ),
            ));
  }

  Widget body_mobile(BuildContext context) {
    return Consumer<MqttProvider>(
        builder: (context, mqttProvider, child) => SingleChildScrollView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  _buildHeader(),
                  const SizedBox(height: 16.0),
                  Container(
                      child: _infobox_mobile(
                          context,
                          MediaQuery.of(context).size.width,
                          "temp",
                          mqttProvider.gettemp_24().main.hour1)),
                  const SizedBox(height: 16.0),
                  Container(
                      child: _infobox_mobile(
                          context,
                          MediaQuery.of(context).size.width,
                          "Humidity",
                          mqttProvider.gethum_24().main.hour1)),
                  const SizedBox(height: 16.0),
                  Container(
                      child: _infobox_mobile(
                          context,
                          MediaQuery.of(context).size.width,
                          "Co2",
                          mqttProvider.getCO2_24().main.hour1)),
                  const SizedBox(height: 16.0),
                  Container(
                      child: _infobox_mobile(
                          context,
                          MediaQuery.of(context).size.width,
                          "VOC",
                          mqttProvider.getVOC_24().main.hour1)),
                  const SizedBox(height: 16.0),

                  Container(
                      child: Row(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: _infobox(context, 150, "pm10",
                            mqttProvider.getpm10_24().main.hour1),
                      ),
                      const SizedBox(width: 16.0),
                      Expanded(
                        flex: 1,
                        child: _infobox(context, 150, "pm2",
                            mqttProvider.getpm2_24().main.hour1),
                      ),
                    ],
                  )),
                ],
              ),
            ));
  }

  Widget _infobox(
      BuildContext context, double _height, String _title, double _info) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff323844),
          borderRadius: BorderRadius.circular(10), //모서리를 둥글게
          border: Border.all(width: 1)), //테두리
      height: _height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              _info.toString(),
              style: Theme.of(context).textTheme.display1!.copyWith(
                    color: Colors.white,
                    fontSize: 36.0,
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
              style: Theme.of(context).textTheme.display1!.copyWith(
                    color: Color(0xffECA425),
                    fontSize: 18.0,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget _infobox_mobile(
      BuildContext context, double _width, String _title, double _info) {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xff323844),
          borderRadius: BorderRadius.circular(10), //모서리를 둥글게
          border: Border.all(width: 1)), //테두리
      width: _width,
      height: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              _info.toString(),
              style: Theme.of(context).textTheme.display1!.copyWith(
                    color: Colors.white,
                    fontSize: 36.0,
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
              style: Theme.of(context).textTheme.display1!.copyWith(
                    color: Color(0xffECA425),
                    fontSize: 18.0,
                  ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Consumer<MqttProvider>(
        builder: (context, mqttProvider, child) => Row(
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
                        "Sensor\nValues",
                        style: whiteText.copyWith(fontSize: 20.0),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        "Welcome to our robot cleaner",
                        style: TextStyle(color: Colors.grey, fontSize: 16.0),
                      ),
                    ],
                  ),
                )
              ],
            ));
  }
}
