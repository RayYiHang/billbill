// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_annotion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

JsonOwner _$JsonOwnerFromJson(Map<String, dynamic> json) {
  return JsonOwner(
    name: json['name'] as String,
    face: json['face'] as String,
    fans: json['fans'] as int,
  );
}

Map<String, dynamic> _$JsonOwnerToJson(JsonOwner instance) => <String, dynamic>{
      'name': instance.name,
      'face': instance.face,
      'fans': instance.fans,
    };
