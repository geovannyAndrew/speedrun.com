import 'dart:io';

import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/category.dart';
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
    var url = "${urlApi}runs?status=verified&orderby=verify-date&offset=$offset&direction=desc&embed=game,category,players&max=${AppConfig.itemsPerPage}";
    final response = await http.get(url);
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

  Future getCategoryRuns({int offset,String idCategory,
    Function(List<Run>) onSuccess,Function(ResponseError) onError}) async{
    final response = await http.get("${urlApi}runs?status=verified&orderby=verify-date&offset=$offset&direction=desc&embed=game,category,players&category=$idCategory&max=${AppConfig.itemsPerPage}");
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

  Future getUserRuns({int offset,String idUser,
    Function(List<Run>) onSuccess,Function(ResponseError) onError}) async{
    final response = await http.get("${urlApi}runs?status=verified&orderby=verify-date&offset=$offset&direction=desc&embed=game,category&user=$idUser&max=${AppConfig.itemsPerPage}");
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

  Future getRun({String id,Function(Run) onSuccess,Function(ResponseError) onError}) async{
    final response = await http.get("${urlApi}runs/$id?embed=players,game,category,platform");
    if(response.statusCode == HttpStatus.ok){
      var json = jsonDecode(response.body);
      var run = Run.fromJson(json["data"]);
      onSuccess(run);
    }
    else{
      onError(ResponseError(response));
    }
  }

  Future getGames({int offset,String query,Function(List<Game>) onSuccess,Function(ResponseError) onError}) async{
    var url = "${urlApi}games?offset=$offset&orderby=created&max=${AppConfig.itemsPerPage}";
    if(query!=null){
      url+="&name=$query";
    }
    final response = await http.get(url);
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

  Future getGame({String id,Function(Game) onSuccess,Function(ResponseError) onError}) async{
    final response = await http.get("${urlApi}games/$id?embed=platforms");
    if(response.statusCode == HttpStatus.ok){
      var json = jsonDecode(response.body);
      var game = Game.fromJson(json["data"]);
      onSuccess(game);
    }
    else{
      onError(ResponseError(response));
    }
  }

  Future getGameCategories({String idGame,Function(List<Category>) onSuccess,Function(ResponseError) onError}) async{
    final response = await http.get("${urlApi}games/$idGame/categories");
    if(response.statusCode == HttpStatus.ok){
      var json = jsonDecode(response.body);
      var jsonData = json["data"] as List;
      var categories = jsonData.map((model)=> Category.fromJson(model)).toList();
      onSuccess(categories);
    }
    else{
      onError(ResponseError(response));
    }
  }

  Future getUsers({int offset, String query,Function(List<User>) onSuccess,Function(ResponseError) onError}) async{
    String url = "${urlApi}users?offset=$offset&max=${AppConfig.itemsPerPage}&orderby=signup";
    if(query != null){
      url+="&name=$query";
    }
    final response = await http.get(url);
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

  Future getUser({String id,Function(User) onSuccess,Function(ResponseError) onError}) async{
    final response = await http.get("${urlApi}users/$id");
    if(response.statusCode == HttpStatus.ok){
      var json = jsonDecode(response.body);
      var jsonData = json["data"];
      var user = User.fromJson(jsonData);
      onSuccess(user);
    }
    else{
      onError(ResponseError(response));
    }
  }

}