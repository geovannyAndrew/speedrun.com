import 'package:freezed_annotation/freezed_annotation.dart';
import 'names.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
abstract class Location with _$Location {
  const Location._();

  @JsonSerializable()
  const factory Location({String code, Names names}) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);

  String get urlIcon {
    return "https://www.countryflags.io/$code/flat/64.png";
  }

  String get name {
    return names?.international ?? "";
  }
}
