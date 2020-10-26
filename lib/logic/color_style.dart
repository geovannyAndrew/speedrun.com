import 'package:speed_run/logic/ccolor.dart';

class ColorStyle {
  final String style;
  final CColor color;
  final CColor colorFrom;
  final CColor colorTo;

  ColorStyle(this.style, this.color, this.colorFrom, this.colorTo);

  factory ColorStyle.fromJson(Map<String, dynamic> json) {
    return ColorStyle(
        json['style'] != null ? json['style'].toString() : null,
        json['color'] != null
            ? CColor.fromJson(json['color'] as Map<String, dynamic>)
            : null,
        json['color-from'] != null
            ? CColor.fromJson(json['color-from'] as Map<String, dynamic>)
            : null,
        json['color-to'] != null
            ? CColor.fromJson(json['color-to'] as Map<String, dynamic>)
            : null);
  }
}
