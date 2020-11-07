import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:speed_run/config/app_config.dart';

@module
abstract class ServicesModule {
  @lazySingleton
  Dio dio() {
    final options = BaseOptions(
        baseUrl: AppConfig.urlServices,
        connectTimeout: 15000,
        receiveTimeout: 5000);
    return Dio(options);
  }
}
