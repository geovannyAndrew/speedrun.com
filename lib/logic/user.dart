import 'package:flutter/painting.dart';
import 'package:speed_run/logic/asset.dart';
import 'package:speed_run/logic/color_style.dart';
import 'package:speed_run/logic/country.dart';
import 'package:speed_run/logic/names.dart';
import 'package:speed_run/network/rest_api.dart';

class User {
  final String id;
  final Names names;
  final Location country;
  final Location region;
  final ColorStyle colorStyle;
  final Asset assetTwitch;
  final Asset assetYoutube;
  final Asset assetTwitter;

  User(this.id, this.names, this.country, this.region, this.colorStyle,
      this.assetTwitch, this.assetYoutube, this.assetTwitter);

  String get urlIcon {
    return "${RestAPI.host}/themes/user/$name/image.png";
  }

  String get name {
    return names?.international;
  }

  String get countryRegionName {
    var countryRegion = "";
    if (country != null) {
      countryRegion += "${country?.name}";
    }
    if (region != null) {
      countryRegion += " - ${region?.name}";
    }
    return countryRegion;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    Location country;
    Location region;
    if (json["location"] != null) {
      if (json["location"]["country"] != null) {
        country = Location.fromJson(
            json["location"]["country"] as Map<String, dynamic>);
      }
      if (json["location"]["region"] != null) {
        region = Location.fromJson(
            json["location"]["region"] as Map<String, dynamic>);
      }
    }

    return User(
        json["id"].toString(),
        Names.fromJson(json["names"] as Map<String, dynamic>),
        country,
        region,
        json["name-style"] != null
            ? ColorStyle.fromJson(json["name-style"] as Map<String, dynamic>)
            : null,
        json["twitch"] != null
            ? Asset.fromJson(json["twitch"] as Map<String, dynamic>)
            : null,
        json["youtube"] != null
            ? Asset.fromJson(json["youtube"] as Map<String, dynamic>)
            : null,
        json["twitter"] != null
            ? Asset.fromJson(json["twitter"] as Map<String, dynamic>)
            : null);
  }

  LinearGradient get gradientStyle {
    return LinearGradient(
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
        colors: [
          colorStyle?.colorFrom?.darkColor,
          colorStyle?.colorTo?.darkColor
        ]);
  }
}
