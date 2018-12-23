import 'dart:io';

import 'package:speed_run/logic/run.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestAPI{

  static const host = "https://www.speedrun.com";
  static const urlApi = "$host/api/v1/";

  static final instance = RestAPI._internal();

  factory RestAPI(){
    return instance;
  }

  RestAPI._internal();

  Future getRuns(Function(List<Run>) onSuccess) async{
    final response = await http.get("${urlApi}runs?status=verified&orderby=verify-date&direction=desc&embed=game,category,players");
    if(response.statusCode == HttpStatus.ok){
      var json = jsonDecode(response.body);
      var jsonData = json["data"] as List;
      var runs = jsonData.map((model)=> Run.fromJson(model)).toList();
      print(runs);
      onSuccess(runs);
    }
    else{
      print("There was an error at try to get tuns");
    }

  }

}