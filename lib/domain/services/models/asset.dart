import 'package:freezed_annotation/freezed_annotation.dart';

part 'asset.freezed.dart';
part 'asset.g.dart';

@freezed
abstract class Asset with _$Asset {
  @JsonSerializable()
  const factory Asset({String uri, int width, int height}) = _Asset;

  factory Asset.fromJson(Map<String, dynamic> json) => _$AssetFromJson(json);
}
