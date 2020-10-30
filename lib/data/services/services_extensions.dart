import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';

extension SpeedRunApiDataFromResponse on Response {
  Map<String, dynamic> getJsonObjectData() {
    return this.data["data"] as Map<String, dynamic>;
  }

  List<Map<String, dynamic>> getJsonListData() {
    return this.data["data"] as List<Map<String, dynamic>>;
  }
}

extension DioExtensions on Dio {
  enableCharlesProxy() {
    const charlesIp =
        String.fromEnvironment('CHARLES_PROXY_IP', defaultValue: null);
    if (charlesIp == null) return;
    print('#CharlesProxyEnabled');
    (this.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (client) {
      client.findProxy = (uri) => "PROXY $charlesIp:8888;";
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }
}

extension DioErrorToSpeedRunFailure on DioError {
  SpeedRunFailure toSpeedRunFailure() {
    if (this.response != null) {
      switch (this.response.statusCode) {
        case 500:
          return SpeedRunFailure.serverError();
          break;
        case 400:
          return SpeedRunFailure.badRequest();
          break;
        case 404:
          return SpeedRunFailure.badRequest();
          break;
        default:
          return SpeedRunFailure.unknown();
          break;
      }
    } else {
      return SpeedRunFailure.unknown();
    }
  }
}
