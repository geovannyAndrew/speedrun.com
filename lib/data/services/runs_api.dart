import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';
import 'services_extensions.dart';

abstract class IRunsApi {
  Future<Either<SpeedRunFailure, List<Run>>> getRuns();
}

class RunApiImpl implements IRunsApi {
  final dio = Dio();

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRuns() async {
    try {
      final response = await dio.get<Map<String, dynamic>>(
          'https://www.speedrun.com/api/v1/runs/90y6pm7e?embed=players,game,category,platform');
      print("====== SUCCESS =======");
      final run = Run.fromJson(response.getJsonObjectData());
      return right([run]);
    } on DioError catch (e) {
      print("DioError ${e.message}");
      return left(SpeedRunFailure.notFound());
    }
  }
}
