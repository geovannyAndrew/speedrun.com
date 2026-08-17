import 'package:speed_run/data/cache_store.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/rest_api.dart';

class SpeedrunRepository {
  final RestAPI _api;
  final CacheStore _cache;

  SpeedrunRepository(this._api, this._cache);

  static const _runsCacheKey = 'runs';
  static const _gamesCacheKey = 'games';
  static const _usersCacheKey = 'users';

  Future<List<Run>> getRuns({required int offset, bool forceRefresh = false}) async {
    if (offset == 0 && !forceRefresh) {
      final cached = await _readCache<List<Run>>(
        _runsCacheKey,
        (data) => data.parse((json) => Run.fromJson(json), 'data'),
      );
      if (cached.isNotEmpty) {
        return cached;
      }
    }

    final response = await _api.getRuns(offset: offset);
    if (offset == 0 && response.items.isNotEmpty) {
      final json = _extractJsonString(response);
      if (json != null) {
        await _cache.save(_runsCacheKey, json);
      }
    }
    return response.items;
  }

  Future<List<Game>> getGames({
    required int offset,
    String? query,
    bool forceRefresh = false,
  }) async {
    final isDefaultFeed = offset == 0 && (query == null || query.isEmpty);
    if (isDefaultFeed && !forceRefresh) {
      final cached = await _readCache<List<Game>>(
        _gamesCacheKey,
        (data) => data.parse((json) => Game.fromJson(json), 'data'),
      );
      if (cached.isNotEmpty) {
        return cached;
      }
    }

    final response = await _api.getGames(offset: offset, query: query);
    if (isDefaultFeed && response.items.isNotEmpty) {
      final json = _extractJsonString(response);
      if (json != null) {
        await _cache.save(_gamesCacheKey, json);
      }
    }
    return response.items;
  }

  Future<List<User>> getUsers({
    required int offset,
    String? query,
    bool forceRefresh = false,
  }) async {
    final isDefaultFeed = offset == 0 && (query == null || query.isEmpty);
    if (isDefaultFeed && !forceRefresh) {
      final cached = await _readCache<List<User>>(
        _usersCacheKey,
        (data) => data.parse((json) => User.fromJson(json), 'data'),
      );
      if (cached.isNotEmpty) {
        return cached;
      }
    }

    final response = await _api.getUsers(offset: offset, query: query);
    if (isDefaultFeed && response.items.isNotEmpty) {
      final json = _extractJsonString(response);
      if (json != null) {
        await _cache.save(_usersCacheKey, json);
      }
    }
    return response.items;
  }

  Future<PaginatedResponse<Run>> getCategoryRuns({
    required int offset,
    required String idCategory,
  }) async {
    return await _api.getCategoryRuns(offset: offset, idCategory: idCategory);
  }

  Future<PaginatedResponse<Run>> getUserRuns({
    required int offset,
    required String idUser,
  }) async {
    return await _api.getUserRuns(offset: offset, idUser: idUser);
  }

  Future<Run> getRun({required String id}) async {
    return await _api.getRun(id: id);
  }

  Future<Game> getGame({required String id}) async {
    return await _api.getGame(id: id);
  }

  Future<List<dynamic>> getGameCategories({required String idGame}) async {
    return await _api.getGameCategories(idGame: idGame);
  }

  Future<User> getUser({required String id}) async {
    return await _api.getUser(id: id);
  }

  Future<T> _readCache<T>(
    String key,
    T Function(CacheData) parse,
  ) async {
    try {
      final content = await _cache.load(key);
      if (content.isEmpty) {
        return parse(CacheData(''));
      }
      return parse(CacheData(content));
    } catch (_) {
      return parse(CacheData(''));
    }
  }

  String? _extractJsonString(PaginatedResponse<dynamic> response) {
    return null;
  }
}
