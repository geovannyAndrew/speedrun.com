
import 'package:speed_run/logic/country.dart';
import 'package:speed_run/logic/names.dart';
import 'package:speed_run/network/rest_api.dart';

class User{
  final String id;
  final Names names;
  final Location country;
  final Location region;

  User(this.id, this.names, this.country, this.region);

  String get urlIcon{
    return "${RestAPI.host}/themes/user/$name/image.png";
  }

  String get name{
    return names?.international;
  }

  String get countryRegionName{
    var countryRegion = "";
    if(country != null){
      countryRegion+="${country?.name}";
    }
    if(region != null){
      countryRegion+=" - ${region?.name}";
    }
    return countryRegion;
  }

  factory User.fromJson(Map<String, dynamic> json){
    Location country;
    Location region;
    if(json["location"] != null){
      if(json["location"]["country"] != null){
        country = Location.fromJson(json["location"]["country"]);
      }
      if(json["location"]["region"] != null){
        region = Location.fromJson(json["location"]["region"]);
      }
    }

    return User(
        json["id"].toString(),
        Names.fromJson(json["names"]),
        country,
        region
    );
  }


}