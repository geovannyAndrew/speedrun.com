import 'package:freezed_annotation/freezed_annotation.dart';
part 'names.freezed.dart';
part 'names.g.dart';

@freezed
abstract class Names with _$Names {
  @JsonSerializable()
  const factory Names({String international, String japanese}) = _Names;

  factory Names.fromJson(Map<String, dynamic> json) => _$NamesFromJson(json);
}
