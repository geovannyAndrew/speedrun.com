import 'package:dartz/dartz.dart';
import 'package:speed_run/domain/services/speed_run_failure.dart';
import 'package:speed_run/logic/run.dart';

abstract class IRunsApi {
  Future<Either<SpeedRunFailure, List<Run>>> getRuns();
}
