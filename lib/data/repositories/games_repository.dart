import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:speed_run/data/models/category.dart';
import 'package:speed_run/data/models/game.dart';
import 'package:speed_run/data/services/apis/games_api.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';

abstract class IGamesRepository {
  Future<Either<SpeedRunFailure, List<Game>>> getGames(
      {@required int offset, @required String query});
  Future<Either<SpeedRunFailure, Game>> getGame({@required String idGame});
  Future<Either<SpeedRunFailure, List<Category>>> getCategoriesFromGame(
      {@required String idGame});
}

@Injectable(as: IGamesRepository)
class GamesRepositoryImpl implements IGamesRepository {
  final IGamesApi _gamesApi;

  GamesRepositoryImpl(this._gamesApi);

  @override
  Future<Either<SpeedRunFailure, List<Category>>> getCategoriesFromGame(
          {String idGame}) =>
      _gamesApi.getCategoriesFromGame(idGame: idGame);

  @override
  Future<Either<SpeedRunFailure, Game>> getGame({String idGame}) =>
      _gamesApi.getGame(idGame: idGame);

  @override
  Future<Either<SpeedRunFailure, List<Game>>> getGames(
          {int offset, String query}) =>
      _gamesApi.getGames(offset: offset, query: query);
}
