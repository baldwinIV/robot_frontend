
//start robot_start
class DataFromClientTorobot {
  String _data = 'null'; //null 은 무시해야함
  String get data => _data;

  DataFromClientTorobot(String data) {
    _data = data;
  }

  DataFromClientTorobot.fromJson(dynamic json) {
    _data = json['data'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['data'] = _data;
    return map;
  }
}