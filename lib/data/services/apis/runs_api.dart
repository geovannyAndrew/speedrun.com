import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:injectable/injectable.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';
import '../services_extensions.dart';

abstract class IRunsApi {
  Future<Either<SpeedRunFailure, List<Run>>> getRuns({@required int offset});
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromCategory(
      int offset, String idCategory);
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromUser(
      int offset, String idUser);
  Future<Either<SpeedRunFailure, Run>> getRun(String id);
}

@LazySingleton(as: IRunsApi)
class RunApiImpl implements IRunsApi {
  final Dio _dio;

  RunApiImpl(this._dio);

  @override
  Future<Either<SpeedRunFailure, Run>> getRun(String id) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/runs/${id}',
          queryParameters: {"embed": "players,game,category,platform"});
      final run = Run.fromJson(response.getJsonObjectData());
      return right(run);
    } on DioError catch (e) {
      return left(e.toSpeedRunFailure());
    }
  }

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRuns(
      {@required int offset}) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('/runs', queryParameters: {
        "status": "verified",
        "orderby": "verify-date",
        "offset": offset,
        "direction": "desc",
        "embed": "game,category,players",
        "max": AppConfig.itemsPerPage
      });
      final runs = response
          .getJsonListData()
          .map((e) => Run.fromJson(e as Map<String, dynamic>))
          .toList();
      return right(runs);
    } on DioError catch (e) {
      return left(e.toSpeedRunFailure());
    }
  }

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromCategory(
      int offset, String idCategory) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('/runs', queryParameters: {
        "status": "verified",
        "orderby": "verify-date",
        "offset": offset,
        "direction": "desc",
        "embed": "game,category,players",
        "category": idCategory,
        "max": AppConfig.itemsPerPage
      });
      final runs = response
          .getJsonListData()
          .map((e) => Run.fromJson(e as Map<String, dynamic>))
          .toList();
      return right(runs);
    } on DioError catch (e) {
      return left(e.toSpeedRunFailure());
    }
  }

  @override
  Future<Either<SpeedRunFailure, List<Run>>> getRunsFromUser(
      int offset, String idUser) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('/runs', queryParameters: {
        "status": "verified",
        "orderby": "verify-date",
        "offset": offset,
        "direction": "desc",
        "embed": "game,category,players",
        "user": idUser,
        "max": AppConfig.itemsPerPage
      });
      print("Response: ${response.request.uri}");
      final runs = response
          .getJsonListData()
          .map((e) => Run.fromJson(e as Map<String, dynamic>))
          .toList();
      return right(runs);
    } on DioError catch (e) {
      return left(e.toSpeedRunFailure());
    }
  }
}
