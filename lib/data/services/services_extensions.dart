import 'dart:io';

import 'package:dio/adapter.dart';
import 'package:dio/dio.dart';

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
