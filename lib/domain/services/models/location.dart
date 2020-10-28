import 'package:freezed_annotation/freezed_annotation.dart';
import 'names.dart';

part 'location.freezed.dart';
part 'location.g.dart';

@freezed
abstract class Location with _$Location {
  @JsonSerializable()
  const factory Location({String code, Names names}) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) =>
      _$LocationFromJson(json);
}
