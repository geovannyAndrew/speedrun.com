import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

Future saveInFile(String nameFile, String content) {
  final completer = Completer<String>();
  getApplicationDocumentsDirectory().then((Directory directory) {
    var file = File("${directory.path}/$nameFile");
    if (!file.existsSync()) {
      file.createSync();
    }
    file.writeAsStringSync(content);
    completer.complete();
  });
  return completer.future;
}

Future<String> getContentFromFile(String nameFile) {
  final completer = Completer<String>();
  getApplicationDocumentsDirectory().then((Directory directory) {
    var file = File("${directory.path}/$nameFile");
    if (file.existsSync()) {
      completer.complete(file.readAsStringSync());
    } else {
      completer.complete(null);
    }
  });
  return completer.future;
}

/*
void getRuns(Function(List<Run>) onRunsGot) {
  getContentFromFile("runs", (String content) {
    if (content == null) {
      onRunsGot(List<Run>());
    } else {
      var json = jsonDecode(content);
      var jsonData = json["data"] as List;
      var runs = jsonData
          .map((model) => Run.fromJson(model as Map<String, dynamic>))
          .toList();
      onRunsGot(runs);
    }
  });
}

void getGames(Function(List<Game>) onGamesGot) {
  getContentFromFile("games", (String content) {
    if (content == null) {
      onGamesGot(List<Game>());
    } else {
      var json = jsonDecode(content);
      var jsonData = json["data"] as List;
      var games = jsonData
          .map((model) => Game.fromJson(model as Map<String, dynamic>))
          .toList();
      onGamesGot(games);
    }
  });
}

void getUsers(Function(List<User>) onUsersGot) {
  getContentFromFile("users", (String content) {
    if (content == null) {
      onUsersGot(List<User>());
    } else {
      var json = jsonDecode(content);
      var jsonData = json["data"] as List;
      var users = jsonData
          .map((model) => User.fromJson(model as Map<String, dynamic>))
          .toList();
      onUsersGot(users);
    }
  });
}*/
