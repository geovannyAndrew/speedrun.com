// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'platform.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Platform _$_$_PlatformFromJson(Map<String, dynamic> json) {
  return _$_Platform(
    id: json['id'] as String,
    name: json['name'] as String,
    released: JsonSerializableConverters.dynamicToString(json['released']),
  );
}

Map<String, dynamic> _$_$_PlatformToJson(_$_Platform instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'released': instance.released,
    };
