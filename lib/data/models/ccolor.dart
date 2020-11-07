import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ccolor.freezed.dart';
part 'ccolor.g.dart';

@freezed
abstract class CColor with _$CColor {
  const CColor._();

  @JsonSerializable()
  const factory CColor({String light, String dark}) = _CColor;

  factory CColor.fromJson(Map<String, dynamic> json) => _$CColorFromJson(json);

  Color get lightColor {
    return _hexToColor(light);
  }

  Color get darkColor {
    return _hexToColor(light);
  }

  Color _hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }
}
