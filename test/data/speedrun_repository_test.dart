import 'package:flutter_test/flutter_test.dart';
import 'package:speed_run/data/cache_store.dart';
import 'package:speed_run/data/speedrun_repository.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/logic/names.dart';
import 'package:speed_run/logic/asset.dart';
import 'package:speed_run/network/rest_api.dart';

class MockRestAPI implements RestAPI {
  PaginatedResponse<Run> Function()? onGetRuns;
  PaginatedResponse<Game> Function()? onGetGames;
  PaginatedResponse<User> Function()? onGetUsers;
  PaginatedResponse<Run> Function()? onGetCategoryRuns;
  PaginatedResponse<Run> Function()? onGetUserRuns;
  Run Function()? onGetRun;
  Game Function()? onGetGame;
  List<Category> Function()? onGetGameCategories;
  User Function()? onGetUser;
  Exception? errorToThrow;

  @override
  Future<PaginatedResponse<Run>> getRuns({required int offset}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetRuns?.call() ?? PaginatedResponse([], false, null);
  }

  @override
  Future<PaginatedResponse<Run>> getCategoryRuns({
    required int offset,
    required String idCategory,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetCategoryRuns?.call() ?? PaginatedResponse([], false, null);
  }

  @override
  Future<PaginatedResponse<Run>> getUserRuns({
    required int offset,
    required String idUser,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetUserRuns?.call() ?? PaginatedResponse([], false, null);
  }

  @override
  Future<Run> getRun({required String id}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetRun!();
  }

  @override
  Future<PaginatedResponse<Game>> getGames({
    required int offset,
    String? query,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetGames?.call() ?? PaginatedResponse([], false, null);
  }

  @override
  Future<Game> getGame({required String id}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetGame!();
  }

  @override
  Future<List<Category>> getGameCategories({required String idGame}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetGameCategories?.call() ?? [];
  }

  @override
  Future<PaginatedResponse<User>> getUsers({
    required int offset,
    String? query,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetUsers?.call() ?? PaginatedResponse([], false, null);
  }

  @override
  Future<User> getUser({required String id}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetUser!();
  }
}

Run _makeRun(String id) => Run(
      id,
      null,
      null,
      null,
      null,
      Category('cat1', 'Any%', '', '', ''),
      Game('game1', Names('Test', '', ''), '', '', Asset('', 0, 0),
          Asset('', 0, 0), null, []),
      [
        User('user1', Names('Test User', '', ''), null, null, null, null, null,
            null, null)
      ],
      null,
    );

Game _makeGame(String id) => Game(
      id,
      Names('Test Game', '', ''),
      '',
      '',
      Asset('', 0, 0),
      Asset('', 0, 0),
      null,
      [],
    );

User _makeUser(String id) => User(
      id,
      Names('Test User', '', ''),
      null,
      null,
      null,
      null,
      null,
      null,
      null,
    );

void main() {
  group('SpeedrunRepository', () {
    late MockRestAPI api;
    late MemoryCacheStore cache;
    late SpeedrunRepository repository;

    setUp(() {
      api = MockRestAPI();
      cache = MemoryCacheStore();
      repository = SpeedrunRepository(api, cache);
    });

    group('getRuns', () {
      test('fetches from API when cache is empty', () async {
        api.onGetRuns =
            () => PaginatedResponse([_makeRun('api-run')], false, null);

        final result = await repository.getRuns(offset: 0);

        expect(result.first.id, equals('api-run'));
      });

      test('skips cache when forceRefresh is true', () async {
        api.onGetRuns =
            () => PaginatedResponse([_makeRun('fresh-run')], false, null);

        final result = await repository.getRuns(offset: 0, forceRefresh: true);

        expect(result.first.id, equals('fresh-run'));
      });

      test('does not cache non-first page', () async {
        await cache.save('runs', 'some cached content');

        await repository.getRuns(offset: 50);

        expect(await cache.load('runs'), equals('some cached content'));
      });

      test('returns empty list for empty cache', () async {
        await cache.save('runs', '');

        final result = await repository.getRuns(offset: 0);

        expect(result, isEmpty);
      });
    });

    group('getGames', () {
      test('fetches from API on search query', () async {
        api.onGetGames =
            () => PaginatedResponse([_makeGame('search-game')], false, null);

        final result = await repository.getGames(offset: 0, query: 'mario');

        expect(result.first.id, equals('search-game'));
      });
    });

    group('getCategoryRuns', () {
      test('returns runs from API', () async {
        api.onGetCategoryRuns =
            () => PaginatedResponse([_makeRun('cat-run')], true, null);

        final result =
            await repository.getCategoryRuns(offset: 0, idCategory: 'cat1');

        expect(result.items.first.id, equals('cat-run'));
        expect(result.hasMore, isTrue);
      });
    });

    group('getUserRuns', () {
      test('returns runs from API', () async {
        api.onGetUserRuns =
            () => PaginatedResponse([_makeRun('user-run')], false, null);

        final result = await repository.getUserRuns(offset: 0, idUser: 'user1');

        expect(result.items.first.id, equals('user-run'));
      });
    });

    group('getRun', () {
      test('returns run from API', () async {
        api.onGetRun = () => _makeRun('run123');

        final result = await repository.getRun(id: 'run123');

        expect(result.id, equals('run123'));
      });
    });

    group('getGame', () {
      test('returns game from API', () async {
        api.onGetGame = () => _makeGame('game123');

        final result = await repository.getGame(id: 'game123');

        expect(result.id, equals('game123'));
      });
    });

    group('getUser', () {
      test('returns user from API', () async {
        api.onGetUser = () => _makeUser('user123');

        final result = await repository.getUser(id: 'user123');

        expect(result.id, equals('user123'));
      });
    });
  });
}
