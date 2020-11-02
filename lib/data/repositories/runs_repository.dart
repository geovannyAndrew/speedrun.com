import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/services/apis/runs_api.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';

abstract class IRunsRepository {
  Future<Either<SpeedRunFailure, List<Run>>> getRuns({@required int offset});
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromCategory(
      int offset, String idCategory);
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromUser(
      int offset, String idUser);
  Future<Either<SpeedRunFailure, Run>> getRun(String id);
}

@Injectable(as: IRunsRepository)
class RunsRepositoryImpl implements IRunsRepository {
  final IRunsApi _apiRuns;

  RunsRepositoryImpl(this._apiRuns);

  @override
  Future<Either<SpeedRunFailure, Run>> getRun(String id) => _apiRuns.getRun(id);

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRuns({int offset}) =>
      _apiRuns.getRuns(offset: offset);

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromCategory(
          int offset, String idCategory) =>
      _apiRuns.getRunsFromCategory(offset, idCategory);

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromUser(
          int offset, String idUser) =>
      _apiRuns.getRunsFromUser(offset, idUser);
}
