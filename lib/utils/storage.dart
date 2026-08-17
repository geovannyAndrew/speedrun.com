import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';

void saveInFile(String nameFile, String content) {
  getApplicationDocumentsDirectory().then((Directory directory) {
    final file = File("${directory.path}/$nameFile");
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsStringSync(content);
  });
}

void getContentFromFile(
  String nameFile,
  Function(String content) onReadContent,
) {
  getApplicationDocumentsDirectory().then((Directory directory) {
    final file = File("${directory.path}/$nameFile");
    if (file.existsSync()) {
      return onReadContent(file.readAsStringSync());
    } else {
      return onReadContent("");
    }
  });
}

void getRuns(Function(List<Run>) onRunsGot) {
  getContentFromFile("runs", (String content) {
    if (content.isEmpty) {
      onRunsGot([]);
    } else {
      final json = jsonDecode(content);
      final jsonData = json["data"] as List;
      final runs = jsonData
          .map((model) => Run.fromJson(model as Map<String, dynamic>))
          .toList();
      onRunsGot(runs);
    }
  });
}

void getGames(Function(List<Game>) onGamesGot) {
  getContentFromFile("games", (String content) {
    if (content.isEmpty) {
      onGamesGot([]);
    } else {
      final json = jsonDecode(content);
      final jsonData = json["data"] as List;
      final games = jsonData
          .map((model) => Game.fromJson(model as Map<String, dynamic>))
          .toList();
      onGamesGot(games);
    }
  });
}

void getUsers(Function(List<User>) onUsersGot) {
  getContentFromFile("users", (String content) {
    if (content.isEmpty) {
      onUsersGot([]);
    } else {
      final json = jsonDecode(content);
      final jsonData = json["data"] as List;
      final users = jsonData
          .map((model) => User.fromJson(model as Map<String, dynamic>))
          .toList();
      onUsersGot(users);
    }
  });
}
