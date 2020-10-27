import 'package:freezed_annotation/freezed_annotation.dart';

part 'house.freezed.dart';
part 'house.g.dart';

@freezed
abstract class House with _$House {
  @JsonSerializable(explicitToJson: true)
  const factory House({@JsonKey(name: 'id_house') String id}) = _House;
  factory House.fromJson(Map<String, dynamic> json) => _$HouseFromJson(json);
}
