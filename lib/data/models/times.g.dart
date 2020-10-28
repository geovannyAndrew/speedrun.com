// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'times.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Times _$_$_TimesFromJson(Map<String, dynamic> json) {
  return _$_Times(
    primary: json['primary'] as String,
    primarySeconds: (json['primary_t'] as num)?.toDouble(),
    realtime: json['realtime'] as String,
    realtimeSeconds: (json['realtime_t'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_TimesToJson(_$_Times instance) => <String, dynamic>{
      'primary': instance.primary,
      'primary_t': instance.primarySeconds,
      'realtime': instance.realtime,
      'realtime_t': instance.realtimeSeconds,
    };
