import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:robot_frontend/pages/MainBoard.dart';
import 'package:robot_frontend/menu_widget/SensorMqtt.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => SwitchProvider('default')),
          ChangeNotifierProvider(create: (context) => MqttProvider('/test'))
        ],
        child: MaterialApp(
          title: 'mainpagedefault',
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.indigo,
            textTheme: GoogleFonts.
                poppinsTextTheme(Theme.of(context).textTheme)
                .apply(bodyColor: Colors.redAccent),
            canvasColor: Colors.deepPurple,
          ),
          initialRoute: '/',
          onGenerateRoute: (routerSettings) {
            switch (routerSettings.name) {
              case '/':
                return MaterialPageRoute(
                    builder: (_) => MyHomePage(title: "HelloDashboard"));
              case '/MainBoard':
                return MaterialPageRoute(builder: (_) => MainBoard());
              default:
                return MaterialPageRoute(
                    builder: (_) => MyHomePage(title: "error"));
            }
          },
        ));
  }
}

class MyHomePage extends StatelessWidget {
  var title;

  MyHomePage({Key? key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Text(
                'Welcome to Dashboard',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset("assets/logo/robot.png", width: 1000.0, height: 500.0),
            FloatingActionButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/MainBoard', arguments: {}),
                    },
                tooltip: 'NextPage',
                child: Icon(Icons.navigate_next))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
