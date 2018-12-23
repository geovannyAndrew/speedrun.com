
import 'package:speed_run/logic/country.dart';
import 'package:speed_run/logic/names.dart';
import 'package:speed_run/network/rest_api.dart';

class User{
  final String id;
  final Names names;
  final Country country;

  User(this.id, this.names, this.country);

  String get urlIcon{
    return "${RestAPI.host}/themes/user/$name/image.png";
  }

  String get name{
    return names?.international;
  }

  factory User.fromJson(Map<String, dynamic> json){
    Country country;
    if(json["location"] != null && json["location"]["country"] != null){
      country = Country.fromJson(json["location"]["country"]);
    }
    return User(
        json["id"].toString(),
        Names.fromJson(json["names"]),
        country
    );
  }


}