// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'color_style.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ColorStyle _$_$_ColorStyleFromJson(Map<String, dynamic> json) {
  return _$_ColorStyle(
    style: json['style'] as String,
    color: json['color'] == null
        ? null
        : CColor.fromJson(json['color'] as Map<String, dynamic>),
    colorFrom: json['color-from'] == null
        ? null
        : CColor.fromJson(json['color-from'] as Map<String, dynamic>),
    colorTo: json['color-to'] == null
        ? null
        : CColor.fromJson(json['color-to'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$_$_ColorStyleToJson(_$_ColorStyle instance) =>
    <String, dynamic>{
      'style': instance.style,
      'color': instance.color,
      'color-from': instance.colorFrom,
      'color-to': instance.colorTo,
    };
