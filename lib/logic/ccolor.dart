import 'dart:ui';

class CColor {
  final String light;
  final String dark;

  CColor(this.light, this.dark);

  factory CColor.fromJson(Map<String, dynamic> json) {
    return CColor(json['light'].toString(), json['dark'].toString());
  }

  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Color get lightColor {
    return hexToColor(light);
  }

  Color get darkColor {
    return hexToColor(light);
  }
}
