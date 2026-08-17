
import 'dart:convert';

import 'package:http/http.dart';

class ResponseError{

  Response response;

  ResponseError(this.response);

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
    final json = bodyJson;
    if(json["message"] != null){
      return json["message"].toString();
    }
    else{
      return "Status: $statusCode \n message:$body";
    }
  }
}
