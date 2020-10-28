import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speed_run/data/models/asset.dart';
import 'package:speed_run/data/models/color_style.dart';
import 'package:speed_run/data/models/location.dart';
import 'names.dart';

part 'user.freezed.dart';

@freezed
abstract class User implements _$User {
  const User._();
  const factory User(
      {String id,
      Names names,
      Location country,
      Location region,
      ColorStyle colorStyle,
      Asset twitch,
      Asset youtube,
      Asset twitter}) = _User;

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
        id: json["id"].toString(),
        names: Names.fromJson(json["names"] as Map<String, dynamic>),
        country: country,
        region: region,
        colorStyle: json["name-style"] != null
            ? ColorStyle.fromJson(json["name-style"] as Map<String, dynamic>)
            : null,
        twitch: json["twitch"] != null
            ? Asset.fromJson(json["twitch"] as Map<String, dynamic>)
            : null,
        youtube: json["youtube"] != null
            ? Asset.fromJson(json["youtube"] as Map<String, dynamic>)
            : null,
        twitter: json["twitter"] != null
            ? Asset.fromJson(json["twitter"] as Map<String, dynamic>)
            : null);
  }

  @override
  Map<String, dynamic> toJson() {
    return null;
  }
}
