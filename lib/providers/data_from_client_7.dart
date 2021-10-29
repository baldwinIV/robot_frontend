/// main : {"Hour1":1.0,"Hour2":1.0,"Hour3":1.0,"Hour4":1.0,"Hour5":1.0,"Hour6":1.0,"Hour7":1.0,"Hour8":1.0,"Hour9":1.0,"Hour10":1.0,"Hour11":1.0,"Hour12":1.0}
/// possible : 1
/// type : "Default"

class DataFromClient7 {
  Main _main = Main.origin(10, 10, 10, 10, 10,10, 10);
  int _possible = 0;
  String _type = 'default';

  Main get main => _main;

  int get possible => _possible;

  String get type => _type;

  DataFromClient7(int possible, String type) {
    _main = Main.origin(10, 10, 10, 10, 10,10, 10);
    _possible = possible;
    _type = type;
  }

  DataFromClient7.fromJson(dynamic json) {
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

class Main {
  double _day1 = 10;
  double _day2 = 10;
  double _day3 = 10;
  double _day4 = 10;
  double _day5 = 10;
  double _day6 = 10;
  double _day7 = 10;

  double get day1 => _day1;

  double get day2 => _day2;

  double get day3 => _day3;

  double get day4 => _day4;

  double get day5 => _day5;

  double get day6 => _day6;

  double get day7 => _day7;
  Main();

  Main.origin(
      double day1,
      double day2,
      double day3,
      double day4,
      double day5,
      double day6,
      double day7,) {
    _day1 = day1;
    _day2 = day2;
    _day3 = day3;
    _day4 = day4;
    _day5 = day5;
    _day6 = day6;
    _day7 = day7;
  }

  Main.fromJson(dynamic json) {
    _day1 = json['day1'];
    _day2 = json['day2'];
    _day3 = json['day3'];
    _day4 = json['day4'];
    _day5 = json['day5'];
    _day6 = json['day6'];
    _day7 = json['day7'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['day1'] = _day1;
    map['day2'] = _day2;
    map['day3'] = _day3;
    map['day4'] = _day4;
    map['day5'] = _day5;
    map['day6'] = _day6;
    map['day7'] = _day7;
    return map;
  }
}
