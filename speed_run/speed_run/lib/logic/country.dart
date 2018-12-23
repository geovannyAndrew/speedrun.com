

import 'package:speed_run/logic/names.dart';

class Country{
  final String code;
  final Names names;

  Country(this.code, this.names);

  factory Country.fromJson(Map<String, dynamic> json){
    return Country(json['code'].toString(),
        Names.fromJson(json["names"])
    );
  }

  String get urlIcon{
    return "https://www.countryflags.io/$code/flat/64.png";
  }
}