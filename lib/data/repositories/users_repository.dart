import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:speed_run/data/services/apis/users_api.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';

abstract class IUsersRepository {
  Future<Either<SpeedRunFailure, List<User>>> getUsers(
      {@required int offset, @required String query});
  Future<Either<SpeedRunFailure, User>> getUser({@required String idUser});
}

@Injectable(as: IUsersRepository)
class UsersRepositoryImpl implements IUsersRepository {
  final IUsersApi _usersApi;

  UsersRepositoryImpl(this._usersApi);

  @override
  Future<Either<SpeedRunFailure, User>> getUser({String idUser}) =>
      _usersApi.getUser(idUser: idUser);

  @override
  Future<Either<SpeedRunFailure, List<User>>> getUsers(
          {int offset, String query}) =>
      _usersApi.getUsers(offset: offset, query: query);
}
