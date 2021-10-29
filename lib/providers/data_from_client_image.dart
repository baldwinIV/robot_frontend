
class DataFromClientImage {

  String _image =  "iVBORw0KGgoAAAANSUhEUgAAAAUAAAAFCAYAAACNbyblAAAAHElEQVQI12P4//8/w38GIAXDIBKE0DHxgljNBAAO9TXL0Y4OHwAAAABJRU5ErkJggg=="; //BASE64
  int _possible = 0;

  String get image => _image;
  int get possible => _possible;

  DataFromClientImage(String image, int possible) {
    _image = image;
    _possible = possible;
  }

  DataFromClientImage.fromJson(dynamic json) {
    _image = json['image'];
    _possible = json['data_map'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['image'] = _image;
    map['possible'] = _possible;
    return map;
  }
}

