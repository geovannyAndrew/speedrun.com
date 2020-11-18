import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:speed_run/data/models/game.dart';
import 'package:speed_run/utils/storage.dart' as storage;

abstract class IGamesStorage {
  Future saveGames(List<Game> games);
  Future<List<Game>> getGames();
  String get _fileName;
}

@Injectable(as: IGamesStorage)
class GamesStorageImpl implements IGamesStorage {
  @override
  String get _fileName => "games";

  @override
  Future<List<Game>> getGames() async {
    final gamesString = await storage.getContentFromFile(_fileName);
    if (gamesString != null && !gamesString.isEmpty) {
      final json = jsonDecode(gamesString);
      try {
        final jsonData = json as List;
        return jsonData
            .map((model) => Game.fromJson(model as Map<String, dynamic>))
            .toList();
      } catch (e) {
        return List.empty();
      }
    }
    return List.empty();
  }

  @override
  Future saveGames(List<Game> games) async {
    final gamesString = jsonEncode(games);
    return await storage.saveInFile(_fileName, gamesString);
  }
}
