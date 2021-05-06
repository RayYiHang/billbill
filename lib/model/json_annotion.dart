import 'package:json_annotation/json_annotation.dart';

part 'json_annotion.g.dart';

@JsonSerializable()
class JsonOwner {
  String name;
  String face;
  int fans;
  JsonOwner({this.name, this.face, this.fans});

  factory JsonOwner.fromJson(Map<String, dynamic> json) => _$JsonOwnerFromJson(json);
  Map<String, dynamic> toJson() => _$JsonOwnerToJson(this);
}

