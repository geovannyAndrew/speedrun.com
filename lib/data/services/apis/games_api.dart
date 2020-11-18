import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/data/models/category.dart';
import 'package:speed_run/data/models/game.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';
import '../services_extensions.dart';

abstract class IGamesApi {
  Future<Either<SpeedRunFailure, List<Game>>> getGames(
      {@required int offset, @required String query = ""});
  Future<Either<SpeedRunFailure, Game>> getGame({@required String idGame});
  Future<Either<SpeedRunFailure, List<Category>>> getCategoriesFromGame(
      {@required String idGame});
}

@LazySingleton(as: IGamesApi)
class GamesApiImpl implements IGamesApi {
  final Dio _dio;

  GamesApiImpl(this._dio);

  @override
  Future<Either<SpeedRunFailure, List<Category>>> getCategoriesFromGame(
      {String idGame}) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('/games/$idGame/categories');
      final categories = response
          .getJsonListData()
          .map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList();
      return right(categories);
    } on DioError catch (e) {
      return left(e.toSpeedRunFailure());
    }
  }

  @override
  Future<Either<SpeedRunFailure, Game>> getGame({String idGame}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/games/$idGame');
      return right(Game.fromJson(response.getJsonObjectData()));
    } on DioError catch (e) {
      return left(e.toSpeedRunFailure());
    }
  }

  @override
  Future<Either<SpeedRunFailure, List<Game>>> getGames(
      {int offset, String query = ""}) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('/games', queryParameters: {
        "offset": offset,
        "max": AppConfig.itemsPerPage,
        "orderby": "created",
        "name": query
      });
      final games = response
          .getJsonListData()
          .map((e) => Game.fromJson(e as Map<String, dynamic>))
          .toList();
      return right(games);
    } on DioError catch (e) {
      return left(e.toSpeedRunFailure());
    }
  }
}
