/// 手写json转换成实体类
//{ "name": '雷奕航',
//"face":'https://jshiqhw.com',
//"fans": 0
// }
class Owner {
  String name;
  String face;
  int fans;
  Owner({this.name, this.face, this.fans});

  /// 将map转换为mc
  Owner.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    face = json['face'];
    fans = json['fans'];
  }

  /// 将mc转换为map
  Map<String,dynamic> toJson() {
    final Map<String, dynamic> jsonMap = new Map<String, dynamic>();
    jsonMap['name'] = this.name;
    jsonMap['face'] = this.face;
    jsonMap['fans'] = this.fans;
    return jsonMap;
  }
}