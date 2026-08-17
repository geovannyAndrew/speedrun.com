import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';

class ApiError {
  final int statusCode;
  final String message;

  ApiError(this.statusCode, this.message);

  factory ApiError.http(int statusCode, String body) {
    String message;
    try {
      final json = jsonDecode(body);
      message = json["message"]?.toString() ?? "Status: $statusCode";
    } catch (_) {
      message = "Status: $statusCode body: $body";
    }
    return ApiError(statusCode, message);
  }

  factory ApiError.network(dynamic error) {
    return ApiError(0, error.toString());
  }

  factory ApiError.parse(dynamic error) {
    return ApiError(0, "Parse error: ${error.toString()}");
  }
}

class PaginatedResponse<T> {
  final List<T> items;
  final bool hasMore;
  final String? paginationPath;

  PaginatedResponse(this.items, this.hasMore, this.paginationPath);
}

class RestAPI {
  final http.Client _client;
  final String _baseUrl;
  final int _maxPerPage;

  static final RestAPI _instance = RestAPI(
    http.Client(),
    "https://www.speedrun.com/api/v1/",
    AppConfig.itemsPerPage,
  );

  static RestAPI get instance => _instance;

  RestAPI(this._client, this._baseUrl, this._maxPerPage);

  factory RestAPI.create(http.Client client) {
    return RestAPI(
      client,
      "https://www.speedrun.com/api/v1/",
      AppConfig.itemsPerPage,
    );
  }

  String _buildUrl(String path, Map<String, String?> params) {
    final queryParams = params.entries
        .where((e) => e.value != null && e.value!.isNotEmpty)
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value!)}')
        .join('&');
    return '$_baseUrl$path?$queryParams';
  }

  Future<PaginatedResponse<Run>> getRuns({required int offset}) async {
    final url = _buildUrl('runs', {
      'status': 'verified',
      'orderby': 'verify-date',
      'direction': 'desc',
      'offset': offset.toString(),
      'max': _maxPerPage.toString(),
      'embed': 'game,category,players',
    });
    return _getRunsImpl(url);
  }

  Future<PaginatedResponse<Run>> getCategoryRuns({
    required int offset,
    required String idCategory,
  }) async {
    final url = _buildUrl('runs', {
      'status': 'verified',
      'orderby': 'verify-date',
      'direction': 'desc',
      'offset': offset.toString(),
      'max': _maxPerPage.toString(),
      'embed': 'game,category,players',
      'category': idCategory,
    });
    return _getRunsImpl(url);
  }

  Future<PaginatedResponse<Run>> getUserRuns({
    required int offset,
    required String idUser,
  }) async {
    final url = _buildUrl('runs', {
      'status': 'verified',
      'orderby': 'verify-date',
      'direction': 'desc',
      'offset': offset.toString(),
      'max': _maxPerPage.toString(),
      'embed': 'game,category',
      'user': idUser,
    });
    return _getRunsImpl(url);
  }

  Future<PaginatedResponse<Run>> _getRunsImpl(String url) async {
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final jsonData = json["data"] as List;
        final runs = jsonData
            .map((model) => Run.fromJson(model as Map<String, dynamic>))
            .toList();
        final pagination = json["pagination"] as Map<String, dynamic>?;
        final hasMore = pagination?["links"] != null &&
            (pagination!["links"] as List).isNotEmpty;
        return PaginatedResponse(runs, hasMore, null);
      } else {
        throw ApiError.http(response.statusCode, response.body);
      }
    } on SocketException catch (e) {
      throw ApiError.network(e);
    } on FormatException catch (e) {
      throw ApiError.parse(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.network(e);
    }
  }

  Future<Run> getRun({required String id}) async {
    final url = _buildUrl('runs/$id', {
      'embed': 'players,game,category,platform',
    });
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Run.fromJson(json["data"] as Map<String, dynamic>);
      } else {
        throw ApiError.http(response.statusCode, response.body);
      }
    } on SocketException catch (e) {
      throw ApiError.network(e);
    } on FormatException catch (e) {
      throw ApiError.parse(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.network(e);
    }
  }

  Future<PaginatedResponse<Game>> getGames({
    required int offset,
    String? query,
  }) async {
    final params = <String, String?>{
      'offset': offset.toString(),
      'max': _maxPerPage.toString(),
      'orderby': 'created',
    };
    if (query != null && query.isNotEmpty) {
      params['name'] = query;
    }
    final url = _buildUrl('games', params);
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final jsonData = json["data"] as List;
        final games = jsonData
            .map((model) => Game.fromJson(model as Map<String, dynamic>))
            .toList();
        final pagination = json["pagination"] as Map<String, dynamic>?;
        final hasMore = pagination?["links"] != null &&
            (pagination!["links"] as List).isNotEmpty;
        return PaginatedResponse(games, hasMore, null);
      } else {
        throw ApiError.http(response.statusCode, response.body);
      }
    } on SocketException catch (e) {
      throw ApiError.network(e);
    } on FormatException catch (e) {
      throw ApiError.parse(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.network(e);
    }
  }

  Future<Game> getGame({required String id}) async {
    final url = _buildUrl('games/$id', {
      'embed': 'platforms',
    });
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        return Game.fromJson(json["data"] as Map<String, dynamic>);
      } else {
        throw ApiError.http(response.statusCode, response.body);
      }
    } on SocketException catch (e) {
      throw ApiError.network(e);
    } on FormatException catch (e) {
      throw ApiError.parse(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.network(e);
    }
  }

  Future<List<Category>> getGameCategories({required String idGame}) async {
    final url = _buildUrl('games/$idGame/categories', {});
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final jsonData = json["data"] as List;
        return jsonData
            .map((model) => Category.fromJson(model as Map<String, dynamic>))
            .toList();
      } else {
        throw ApiError.http(response.statusCode, response.body);
      }
    } on SocketException catch (e) {
      throw ApiError.network(e);
    } on FormatException catch (e) {
      throw ApiError.parse(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.network(e);
    }
  }

  Future<PaginatedResponse<User>> getUsers({
    required int offset,
    String? query,
  }) async {
    final params = <String, String?>{
      'offset': offset.toString(),
      'max': _maxPerPage.toString(),
      'orderby': 'signup',
    };
    if (query == null || query.isEmpty) {
      params['name'] = 'abc';
    } else {
      params['name'] = query;
    }
    final url = _buildUrl('users', params);
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final jsonData = json["data"] as List;
        final users = jsonData
            .map((model) => User.fromJson(model as Map<String, dynamic>))
            .toList();
        final pagination = json["pagination"] as Map<String, dynamic>?;
        final hasMore = pagination?["links"] != null &&
            (pagination!["links"] as List).isNotEmpty;
        return PaginatedResponse(users, hasMore, null);
      } else {
        throw ApiError.http(response.statusCode, response.body);
      }
    } on SocketException catch (e) {
      throw ApiError.network(e);
    } on FormatException catch (e) {
      throw ApiError.parse(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.network(e);
    }
  }

  Future<User> getUser({required String id}) async {
    final url = _buildUrl('users/$id', {});
    try {
      final response = await _client.get(Uri.parse(url));
      if (response.statusCode == HttpStatus.ok) {
        final json = jsonDecode(response.body) as Map<String, dynamic>;
        final jsonData = json["data"];
        return User.fromJson(jsonData as Map<String, dynamic>);
      } else {
        throw ApiError.http(response.statusCode, response.body);
      }
    } on SocketException catch (e) {
      throw ApiError.network(e);
    } on FormatException catch (e) {
      throw ApiError.parse(e);
    } catch (e) {
      if (e is ApiError) rethrow;
      throw ApiError.network(e);
    }
  }
}
