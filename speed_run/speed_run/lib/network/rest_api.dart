import 'dart:io';

import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:http/http.dart' as http;
import 'package:speed_run/logic/user.dart';
import 'dart:convert';

import 'package:speed_run/network/response_error.dart';

class RestAPI{

  static const host = "https://www.speedrun.com";
  static const urlApi = "$host/api/v1/";

  static final instance = RestAPI._internal();

  factory RestAPI(){
    return instance;
  }

  RestAPI._internal();

  Future getRuns({int offset,Function(List<Run>) onSuccess,Function(ResponseError) onError}) async{
    final response = await http.get("${urlApi}runs?status=verified&orderby=verify-date&offset=$offset&direction=desc&embed=game,category,players");
    if(response.statusCode == HttpStatus.ok){
      var json = jsonDecode(response.body);
      var jsonData = json["data"] as List;
      var runs = jsonData.map((model)=> Run.fromJson(model)).toList();
      onSuccess(runs);
    }
    else{
      onError(ResponseError(response));
    }
  }

  Future getGames({int offset,Function(List<Game>) onSuccess,Function(ResponseError) onError}) async{
    final response = await http.get("${urlApi}games?offset=$offset&orderby=created");
    if(response.statusCode == HttpStatus.ok){
      var json = jsonDecode(response.body);
      var jsonData = json["data"] as List;
      var games = jsonData.map((model)=> Game.fromJson(model)).toList();
      onSuccess(games);
    }
    else{
      onError(ResponseError(response));
    }
  }

  Future getUsers({int offset,Function(List<User>) onSuccess,Function(ResponseError) onError}) async{
    final response = await http.get("${urlApi}users?offset=$offset");
    if(response.statusCode == HttpStatus.ok){
      var json = jsonDecode(response.body);
      var jsonData = json["data"] as List;
      var users = jsonData.map((model)=> User.fromJson(model)).toList();
      onSuccess(users);
    }
    else{
      onError(ResponseError(response));
    }
  }

}