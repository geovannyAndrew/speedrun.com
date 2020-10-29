import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';
import 'services_extensions.dart';

abstract class IRunsApi {
  Future<Either<SpeedRunFailure, List<Run>>> getRuns(int offset);
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromCategory(
      int offset, String idCategory);
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromUser(
      int offset, String idUser);
  Future<Either<SpeedRunFailure, Run>> getRun(String id);
}

class RunApiImpl implements IRunsApi {
  final Dio dio;

  RunApiImpl(this.dio);

  @override
  Future<Either<SpeedRunFailure, Run>> getRun(String id) async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
          'https://www.speedrun.com/api/v1/runs/90y6pm7e?embed=players,game,category,platform');
      print("====== SUCCESS =======");
      final run = Run.fromJson(response.getJsonObjectData());
      return right(run);
    } on DioError catch (e) {
      print("DioMessage ${e.message}");
      print("DioError ${e.error}");
      print("DioError ${e.type}");
      return left(SpeedRunFailure.notFound());
    }
  }

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRuns(int offset) {
    // TODO: implement getRuns
    throw UnimplementedError();
  }

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromCategory(
      int offset, String idCategory) {
    // TODO: implement getRunsFromCategory
    throw UnimplementedError();
  }

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromUser(
      int offset, String idUser) {
    // TODO: implement getRunsFromUser
    throw UnimplementedError();
  }
}
