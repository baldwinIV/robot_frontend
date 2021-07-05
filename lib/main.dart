import 'package:flutter/material.dart';
import 'package:robot_frontend/pages/dashboard.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class mainProvider with ChangeNotifier {
  double _width;
  double _height;

  mainProvider(this._height, this._width);

  void onClick() {
    _width = 400.0;
    _height = 300.0;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => mainProvider(0, 0))
        ],
        child: MaterialApp(
          title: 'mainpagedefault',
          theme: ThemeData(
            primarySwatch: Colors.yellow,
          ),
          initialRoute: '/',
          onGenerateRoute: (routerSettings) {
            switch (routerSettings.name) {
              case '/':
                return MaterialPageRoute(
                    builder: (_) => MyHomePage(title: "HelloDashboard"));
              case '/DashBoard':
                return MaterialPageRoute(builder: (_) => DashBoard());
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
            Image.asset("assets/logo/logo.png", width: 1000.0, height: 500.0),
            FloatingActionButton(
                onPressed: () => {
                      Navigator.pushNamed(context, '/DashBoard', arguments: {}),
                    },
                tooltip: 'NextPage',
                child: Icon(Icons.navigate_next))
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
