import 'package:dio/dio.dart';

extension SpeedRunApiDataFromResponse on Response {
  Map<String, dynamic> getJsonObjectData() {
    return this.data["data"] as Map<String, dynamic>;
  }

  List<Map<String, dynamic>> getJsonListData() {
    return this.data["data"] as List<Map<String, dynamic>>;
  }
}
