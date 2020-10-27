import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speed_run/domain/services/models/ccolor.dart';

part 'color_style.freezed.dart';
part 'color_style.g.dart';

@freezed
abstract class ColorStyle with _$ColorStyle {
  @JsonSerializable()
  const factory ColorStyle(
      {@JsonKey(name: 'style') String style,
      @JsonKey(name: 'color') CColor color,
      @JsonKey(name: 'color-from') CColor colorFrom,
      @JsonKey(name: 'color-to') CColor colorTo}) = _ColorStyle;

  factory ColorStyle.fromJson(Map<String, dynamic> json) =>
      _$ColorStyleFromJson(json);
}
