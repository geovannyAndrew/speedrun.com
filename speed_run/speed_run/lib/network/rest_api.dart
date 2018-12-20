import 'package:speed_run/logic/run.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RestAPI{

  static final instance = RestAPI._internal();

  factory RestAPI(){
    return instance;
  }

  RestAPI._internal();

  Future getRuns(Function(List<Run>) onSuccess) async{
    final response = await http.get("https://www.speedrun.com/api/v1/runs?status=verified&orderby=verify-date&direction=desc&embed=game");
    if(response.statusCode == 200){
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