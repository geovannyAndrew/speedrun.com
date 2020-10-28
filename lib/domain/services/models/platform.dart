import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:speed_run/utils/from_json_converters.dart';

part 'platform.freezed.dart';
part 'platform.g.dart';

@freezed
abstract class Platform with _$Platform {
  @JsonSerializable()
  const factory Platform({
    String id,
    String name,
    @JsonKey(fromJson: JsonSerializableConverters.dynamicToString)
        String released,
  }) = _Platform;

  factory Platform.fromJson(Map<String, dynamic> json) =>
      _$PlatformFromJson(json);
}
