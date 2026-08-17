import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/response_error.dart';
import 'package:speed_run/utils/storage.dart' as storage;

class RestAPI {
  static const host = "https://www.speedrun.com";
  static const urlApi = "$host/api/v1/";

  static final instance = RestAPI._internal();

  factory RestAPI() {
    return instance;
  }

  RestAPI._internal();

  Future getRuns(
      {required int offset,
      required Function(List<Run>) onSuccess,
      required Function(ResponseError) onError,}) async {
    final url =
        "${urlApi}runs?status=verified&orderby=verify-date&offset=$offset&direction=desc&embed=game,category,players&max=${AppConfig.itemsPerPage}";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      if (offset == 0) {
        storage.saveInFile("runs", response.body);
      }
      final json = jsonDecode(response.body);
      final jsonData = json["data"] as List;
      final runs = jsonData
          .map((model) => Run.fromJson(model as Map<String, dynamic>))
          .toList();
      onSuccess(runs);
    } else {
      onError(ResponseError(response));
    }
  }

  Future getCategoryRuns(
      {required int offset,
      required String idCategory,
      required Function(List<Run>) onSuccess,
      required Function(ResponseError) onError,}) async {
    final response = await http.get(Uri.parse(
        "${urlApi}runs?status=verified&orderby=verify-date&offset=$offset&direction=desc&embed=game,category,players&category=$idCategory&max=${AppConfig.itemsPerPage}",),);
    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      final jsonData = json["data"] as List;
      final runs = jsonData
          .map((model) => Run.fromJson(model as Map<String, dynamic>))
          .toList();
      onSuccess(runs);
    } else {
      onError(ResponseError(response));
    }
  }

  Future getUserRuns(
      {required int offset,
      required String idUser,
      required Function(List<Run>) onSuccess,
      required Function(ResponseError) onError,}) async {
    final response = await http.get(Uri.parse(
        "${urlApi}runs?status=verified&orderby=verify-date&offset=$offset&direction=desc&embed=game,category&user=$idUser&max=${AppConfig.itemsPerPage}",),);
    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      final jsonData = json["data"] as List;
      final runs = jsonData
          .map((model) => Run.fromJson(model as Map<String, dynamic>))
          .toList();
      onSuccess(runs);
    } else {
      onError(ResponseError(response));
    }
  }

  Future getRun(
      {required String id,
      required Function(Run) onSuccess,
      required Function(ResponseError) onError,}) async {
    final response = await http.get(
        Uri.parse("${urlApi}runs/$id?embed=players,game,category,platform"),);
    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      final run = Run.fromJson(json["data"] as Map<String, dynamic>);
      onSuccess(run);
    } else {
      onError(ResponseError(response));
    }
  }

  Future getGames(
      {required int offset,
      String? query,
      required Function(List<Game>) onSuccess,
      required Function(ResponseError) onError,}) async {
    var url =
        "${urlApi}games?offset=$offset&orderby=created&max=${AppConfig.itemsPerPage}";
    if (query != null) {
      url += "&name=$query";
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      if (offset == 0 && (query == null || query.isEmpty)) {
        storage.saveInFile("games", response.body);
      }
      final json = jsonDecode(response.body);
      final jsonData = json["data"] as List;
      final games = jsonData
          .map((model) => Game.fromJson(model as Map<String, dynamic>))
          .toList();
      onSuccess(games);
    } else {
      onError(ResponseError(response));
    }
  }

  Future getGame(
      {required String id,
      required Function(Game) onSuccess,
      required Function(ResponseError) onError,}) async {
    final response =
        await http.get(Uri.parse("${urlApi}games/$id?embed=platforms"));
    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      final game = Game.fromJson(json["data"] as Map<String, dynamic>);
      onSuccess(game);
    } else {
      onError(ResponseError(response));
    }
  }

  Future getGameCategories(
      {required String idGame,
      required Function(List<Category>) onSuccess,
      required Function(ResponseError) onError,}) async {
    final response =
        await http.get(Uri.parse("${urlApi}games/$idGame/categories"));
    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      final jsonData = json["data"] as List;
      final categories = jsonData
          .map((model) => Category.fromJson(model as Map<String, dynamic>))
          .toList();
      onSuccess(categories);
    } else {
      onError(ResponseError(response));
    }
  }

  Future getUsers(
      {required int offset,
      String? query,
      required Function(List<User>) onSuccess,
      required Function(ResponseError) onError,}) async {
    String url =
        "${urlApi}users?offset=$offset&max=${AppConfig.itemsPerPage}&orderby=signup";
    if (query == null || query.isEmpty) {
      url += "&name=abc";
    } else {
      url += "&name=$query";
    }
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == HttpStatus.ok) {
      if (offset == 0 && (query == null || query.isEmpty)) {
        storage.saveInFile("users", response.body);
      }
      final json = jsonDecode(response.body);
      final jsonData = json["data"] as List;
      final users = jsonData
          .map((model) => User.fromJson(model as Map<String, dynamic>))
          .toList();
      onSuccess(users);
    } else {
      onError(ResponseError(response));
    }
  }

  Future getUser(
      {required String id,
      required Function(User) onSuccess,
      required Function(ResponseError) onError,}) async {
    final response = await http.get(Uri.parse("${urlApi}users/$id"));
    if (response.statusCode == HttpStatus.ok) {
      final json = jsonDecode(response.body);
      final jsonData = json["data"];
      final user = User.fromJson(jsonData as Map<String, dynamic>);
      onSuccess(user);
    } else {
      onError(ResponseError(response));
    }
  }
}
