import 'package:freezed_annotation/freezed_annotation.dart';

part 'ccolor.freezed.dart';
part 'ccolor.g.dart';

@freezed
abstract class CColor with _$CColor {
  @JsonSerializable()
  const factory CColor({String light, String dark}) = _CColor;
  factory CColor.fromJson(Map<String, dynamic> json) => _$CColorFromJson(json);
}
