import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:speed_run/utils/storage.dart' as storage;

abstract class IUsersStorage {
  Future saveUsers(List<User> users);
  Future<List<User>> getUsers();
  String get _fileName;
}

@Injectable(as: IUsersStorage)
class UsersStorageImpl implements IUsersStorage {
  @override
  String get _fileName => "users";

  @override
  Future<List<User>> getUsers() async {
    final usersString = await storage.getContentFromFile(_fileName);
    if (usersString != null && !usersString.isEmpty) {
      final json = jsonDecode(usersString);
      final jsonData = json as List;
      return jsonData
          .map((model) => User.fromJson(model as Map<String, dynamic>))
          .toList();
    }
    return List.empty();
  }

  @override
  Future saveUsers(List<User> users) async {
    final usersString = jsonEncode(users);
    return await storage.saveInFile(_fileName, usersString);
  }
}
