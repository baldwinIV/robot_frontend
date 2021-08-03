import 'dart:collection';
import 'package:flutter/material.dart';


class LogProvider with ChangeNotifier {
  Queue<String> _data = Queue<String>();
  int getLength() => _data.length;
  Queue<String> getData() => _data;
  void addStringToQueue(String toAdd) {
    if(_data.length >= 10){
      _data.removeFirst();
    }
   _data.addLast(toAdd);
    notifyListeners(); //must be inserted
  }

}