/// main : {"Hour1":1.0,"Hour2":1.0,"Hour3":1.0,"Hour4":1.0,"Hour5":1.0,"Hour6":1.0,"Hour7":1.0,"Hour8":1.0,"Hour9":1.0,"Hour10":1.0,"Hour11":1.0,"Hour12":1.0}
/// possible : 1
/// type : "Default"

class DataFromClient {
  Main _main = Main.origin(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1);
  int _possible = 0;
  String _type = 'default';

  Main get main => _main;

  int get possible => _possible;

  String get type => _type;

  DataFromClient(int possible, String type) {
    _main = Main.origin(-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1);
    _possible = possible;
    _type = type;
  }

  DataFromClient.fromJson(dynamic json) {
    _main = Main.fromJson(json['main']);
    _possible = json['possible'];
    _type = json['type'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['main'] = _main.toJson();
    map['possible'] = _possible;
    map['type'] = _type;
    return map;
  }
}

/// Hour1 : 1.0
/// Hour2 : 1.0
/// Hour3 : 1.0
/// Hour4 : 1.0
/// Hour5 : 1.0
/// Hour6 : 1.0
/// Hour7 : 1.0
/// Hour8 : 1.0
/// Hour9 : 1.0
/// Hour10 : 1.0
/// Hour11 : 1.0
/// Hour12 : 1.0

class Main {
  double _hour1 = -1;
  double _hour2 = -1;
  double _hour3 = -1;
  double _hour4 = -1;
  double _hour5 = -1;
  double _hour6 = -1;
  double _hour7 = -1;
  double _hour8 = -1;
  double _hour9 = -1;
  double _hour10 = -1;
  double _hour11 = -1;
  double _hour12 = -1;

  double get hour1 => _hour1;

  double get hour2 => _hour2;

  double get hour3 => _hour3;

  double get hour4 => _hour4;

  double get hour5 => _hour5;

  double get hour6 => _hour6;

  double get hour7 => _hour7;

  double get hour8 => _hour8;

  double get hour9 => _hour9;

  double get hour10 => _hour10;

  double get hour11 => _hour11;

  double get hour12 => _hour12;

  Main();

  Main.origin(
      double hour1,
      double hour2,
      double hour3,
      double hour4,
      double hour5,
      double hour6,
      double hour7,
      double hour8,
      double hour9,
      double hour10,
      double hour11,
      double hour12) {
    _hour1 = hour1;
    _hour2 = hour2;
    _hour3 = hour3;
    _hour4 = hour4;
    _hour5 = hour5;
    _hour6 = hour6;
    _hour7 = hour7;
    _hour8 = hour8;
    _hour9 = hour9;
    _hour10 = hour10;
    _hour11 = hour11;
    _hour12 = hour12;
  }

  Main.fromJson(dynamic json) {
    _hour1 = json['Hour1'];
    _hour2 = json['Hour2'];
    _hour3 = json['Hour3'];
    _hour4 = json['Hour4'];
    _hour5 = json['Hour5'];
    _hour6 = json['Hour6'];
    _hour7 = json['Hour7'];
    _hour8 = json['Hour8'];
    _hour9 = json['Hour9'];
    _hour10 = json['Hour10'];
    _hour11 = json['Hour11'];
    _hour12 = json['Hour12'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['Hour1'] = _hour1;
    map['Hour2'] = _hour2;
    map['Hour3'] = _hour3;
    map['Hour4'] = _hour4;
    map['Hour5'] = _hour5;
    map['Hour6'] = _hour6;
    map['Hour7'] = _hour7;
    map['Hour8'] = _hour8;
    map['Hour9'] = _hour9;
    map['Hour10'] = _hour10;
    map['Hour11'] = _hour11;
    map['Hour12'] = _hour12;
    return map;
  }
}
