import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/services/apis/runs_api.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';
import 'package:speed_run/data/storage/runs_storage.dart';

abstract class IRunsRepository {
  Future<Either<SpeedRunFailure, List<Run>>> getRuns(
      {@required int offset, bool fromStorage = false});
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromCategory(
      int offset, String idCategory);
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromUser(
      int offset, String idUser);
  Future<Either<SpeedRunFailure, Run>> getRun(String id);
}

@Injectable(as: IRunsRepository)
class RunsRepositoryImpl implements IRunsRepository {
  final IRunsApi _apiRuns;
  final IRunsStorage _storageRuns;

  RunsRepositoryImpl(this._apiRuns, this._storageRuns);

  @override
  Future<Either<SpeedRunFailure, Run>> getRun(String id) => _apiRuns.getRun(id);

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRuns(
      {int offset, bool fromStorage = false}) async {
    Either<SpeedRunFailure, List<Run>> eitherRuns;
    if (fromStorage) {
      eitherRuns = right(await _storageRuns.getRuns());
    } else {
      eitherRuns = await _apiRuns.getRuns(offset: offset);
      await _storageRuns.saveRuns(eitherRuns.getOrElse(() => List.empty()));
    }
    return eitherRuns;
  }

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromCategory(
          int offset, String idCategory) =>
      _apiRuns.getRunsFromCategory(offset, idCategory);

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromUser(
          int offset, String idUser) =>
      _apiRuns.getRunsFromUser(offset, idUser);
}
