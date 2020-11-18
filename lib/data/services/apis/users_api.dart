import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';
import '../services_extensions.dart';

abstract class IUsersApi {
  Future<Either<SpeedRunFailure, List<User>>> getUsers(
      {@required int offset, @required String query});
  Future<Either<SpeedRunFailure, User>> getUser({@required String idUser});
}

@LazySingleton(as: IUsersApi)
class UsersApiImpl implements IUsersApi {
  final Dio _dio;

  UsersApiImpl(this._dio);

  @override
  Future<Either<SpeedRunFailure, User>> getUser({String idUser}) async {
    try {
      final response = await _dio.get<Map<String, dynamic>>('/users/$idUser');
      return right(User.fromJson(response.getJsonObjectData()));
    } on DioError catch (e) {
      return left(e.toSpeedRunFailure());
    }
  }

  @override
  Future<Either<SpeedRunFailure, List<User>>> getUsers(
      {int offset, String query}) async {
    try {
      final response =
          await _dio.get<Map<String, dynamic>>('/users', queryParameters: {
        "offset": offset,
        "max": AppConfig.itemsPerPage,
        "orderby": "signup",
        "name": query
      });
      final users = response
          .getJsonListData()
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList();
      return right(users);
    } on DioError catch (e) {
      return left(e.toSpeedRunFailure());
    }
  }
}
