import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class ServicesModule {
  @lazySingleton
  Dio dio() {
    final options = BaseOptions(
        baseUrl: "https://www.speedrun.com/api/v1/",
        connectTimeout: 15000,
        receiveTimeout: 5000);
    return Dio(options);
  }
}
