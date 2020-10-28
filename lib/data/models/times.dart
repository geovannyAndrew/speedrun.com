import 'package:freezed_annotation/freezed_annotation.dart';

part 'times.freezed.dart';
part 'times.g.dart';

@freezed
abstract class Times implements _$Times {
  @JsonSerializable()
  const factory Times(
      {@JsonKey(name: "primary") String primary,
      @JsonKey(name: "primary_t") double primarySeconds,
      @JsonKey(name: "realtime") String realtime,
      @JsonKey(name: "realtime_t") double realtimeSeconds}) = _Times;

  factory Times.fromJson(Map<String, dynamic> json) => _$TimesFromJson(json);
}
