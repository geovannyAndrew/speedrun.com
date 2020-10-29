import 'package:dartz/dartz.dart';
import 'package:speed_run/data/models/category.dart';
import 'package:speed_run/data/models/game.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';

abstract class IGamesApi {
  Future<Either<SpeedRunFailure, List<Game>>> getGames(
      int offset, String query);
  Future<Either<SpeedRunFailure, Game>> getGame(String idGame);
  Future<Either<SpeedRunFailure, List<Category>>> getCategoriesFromGame(
      String idGame);
}
