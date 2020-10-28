import 'package:freezed_annotation/freezed_annotation.dart';

part 'speed_run_failure.freezed.dart';

@freezed
abstract class SpeedRunFailure with _$SpeedRunFailure {
  const factory SpeedRunFailure.notFound() = NotFound;
}
