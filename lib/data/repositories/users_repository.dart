import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:speed_run/data/services/apis/users_api.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';
import 'package:speed_run/data/storage/users_storage.dart';

abstract class IUsersRepository {
  Future<Either<SpeedRunFailure, List<User>>> getUsers(
      {@required int offset, @required String query, bool fromStorage});
  Future<Either<SpeedRunFailure, User>> getUser({@required String idUser});
}

@Injectable(as: IUsersRepository)
class UsersRepositoryImpl implements IUsersRepository {
  final IUsersApi _usersApi;
  final IUsersStorage _usersStorage;

  UsersRepositoryImpl(this._usersApi, this._usersStorage);

  @override
  Future<Either<SpeedRunFailure, User>> getUser({String idUser}) =>
      _usersApi.getUser(idUser: idUser);

  @override
  Future<Either<SpeedRunFailure, List<User>>> getUsers(
      {int offset, String query, bool fromStorage = false}) async {
    Either<SpeedRunFailure, List<User>> eitherUsers;
    if (fromStorage) {
      eitherUsers = right(await _usersStorage.getUsers());
    } else {
      eitherUsers = await _usersApi.getUsers(offset: offset, query: query);
      if (offset <= 1 && (query == null || query.isEmpty)) {
        await _usersStorage
            .saveUsers(eitherUsers.getOrElse(() => List.empty()));
      }
    }
    return eitherUsers;
  }
}
