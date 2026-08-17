import 'package:speed_run/logic/names.dart';

class Location {
  final String code;
  final Names names;

  Location(this.code, this.names);

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(json['code'].toString(),
        Names.fromJson(json["names"] as Map<String, dynamic>),);
  }

  String get urlIcon {
    return "https://flagsapi.com/${code.toUpperCase()}/flat/64.png";
  }

  String get name {
    return names.international;
  }
}
