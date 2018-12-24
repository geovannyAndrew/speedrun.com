

import 'package:speed_run/logic/names.dart';

class Location{
  final String code;
  final Names names;

  Location(this.code, this.names);

  factory Location.fromJson(Map<String, dynamic> json){
    return Location(json['code'].toString(),
        Names.fromJson(json["names"])
    );
  }

  String get urlIcon{
    return "https://www.countryflags.io/$code/flat/64.png";
  }

  String get name{
    return names?.international ?? "";
  }
}