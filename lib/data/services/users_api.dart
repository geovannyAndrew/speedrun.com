import 'package:dartz/dartz.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';

abstract class IUsersApi {
  Future<Either<SpeedRunFailure, List<User>>> getUsers(
      int offset, String query);
  Future<Either<SpeedRunFailure, User>> getUser(String idUser);
}
