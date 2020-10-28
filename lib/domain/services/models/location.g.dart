// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Location _$_$_LocationFromJson(Map<String, dynamic> json) {
  return _$_Location(
    code: json['code'] as String,
    names: json['names'] == null
        ? null
        : Names.fromJson(json['names'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_LocationToJson(_$_Location instance) =>
    <String, dynamic>{
      'code': instance.code,
      'names': instance.names,
    };
