import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

abstract class CacheStore {
  Future<void> save(String name, String content);
  Future<String> load(String name);
}

class FileCacheStore implements CacheStore {
  Future<Directory> _getDirectory() async {
    return await getApplicationDocumentsDirectory();
  }

  @override
  Future<void> save(String name, String content) async {
    final directory = await _getDirectory();
    final file = File("${directory.path}/$name");
    if (!file.existsSync()) {
      await file.create();
    }
    await file.writeAsString(content);
  }

  @override
  Future<String> load(String name) async {
    final directory = await _getDirectory();
    final file = File("${directory.path}/$name");
    if (file.existsSync()) {
      return await file.readAsString();
    }
    return '';
  }
}

class MemoryCacheStore implements CacheStore {
  final Map<String, String> _cache = {};

  @override
  Future<void> save(String name, String content) async {
    _cache[name] = content;
  }

  @override
  Future<String> load(String name) async {
    return _cache[name] ?? '';
  }
}

class CacheData {
  final String jsonString;
  CacheData(this.jsonString);

  List<T> parse<T>(T Function(Map<String, dynamic>) fromJson, String dataKey) {
    if (jsonString.isEmpty) {
      return [];
    }
    final json = jsonDecode(jsonString) as Map<String, dynamic>;
    final jsonData = json[dataKey] as List;
    return jsonData
        .map((model) => fromJson(model as Map<String, dynamic>))
        .toList();
  }
}
