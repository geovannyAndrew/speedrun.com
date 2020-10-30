import 'package:freezed_annotation/freezed_annotation.dart';

part 'speed_run_failure.freezed.dart';

@freezed
abstract class SpeedRunFailure with _$SpeedRunFailure {
  const factory SpeedRunFailure.notFound() = NotFound;
  const factory SpeedRunFailure.serverError() = ServerError;
  const factory SpeedRunFailure.badRequest() = BadRequest;
  const factory SpeedRunFailure.unknown() = Unknown;
}
