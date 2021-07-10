import 'package:flutter/material.dart';

class SwitchProvider with ChangeNotifier {
  String _routeName = "default";

  String getRouteName() => _routeName;

  SwitchProvider(this._routeName);

  void manageData(String toChangeRoute) {
    _routeName = toChangeRoute;
    notifyListeners();
  }
}