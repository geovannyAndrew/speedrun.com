
import 'dart:convert';

import 'package:http/http.dart';

class ResponseError{

  Response response;

  ResponseError(Response response){
    this.response= response;
  }

  int get statusCode{
    return response.statusCode;
  }

  String get body{
    return response.body;
  }

  dynamic get bodyJson{
    return jsonDecode(response.body);
  }

  String get messageError{
    return "Status: $statusCode \n message:$body";
  }
}