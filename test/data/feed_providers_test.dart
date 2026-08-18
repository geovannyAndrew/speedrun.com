import 'package:flutter_test/flutter_test.dart';
import 'package:speed_run/data/feed_providers.dart';
import 'package:speed_run/data/feed_state.dart';
import 'package:speed_run/data/speedrun_repository.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/logic/names.dart';
import 'package:speed_run/logic/asset.dart';
import 'package:speed_run/network/rest_api.dart';

class MockRepository implements SpeedrunRepository {
  List<Run> Function()? onGetRuns;
  List<Game> Function()? onGetGames;
  List<User> Function()? onGetUsers;
  PaginatedResponse<Run> Function()? onGetCategoryRuns;
  PaginatedResponse<Run> Function()? onGetUserRuns;
  Run Function()? onGetRun;
  Game Function()? onGetGame;
  List<dynamic> Function()? onGetGameCategories;
  User Function()? onGetUser;
  Exception? errorToThrow;

  @override
  Future<List<Run>> getRuns(
      {required int offset, bool forceRefresh = false}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetRuns?.call() ?? [];
  }

  @override
  Future<List<Game>> getGames({
    required int offset,
    String? query,
    bool forceRefresh = false,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetGames?.call() ?? [];
  }

  @override
  Future<List<User>> getUsers({
    required int offset,
    String? query,
    bool forceRefresh = false,
  }) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetUsers?.call() ?? [];
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
  Future<Game> getGame({required String id}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetGame!();
  }

  @override
  Future<List<dynamic>> getGameCategories({required String idGame}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return onGetGameCategories?.call() ?? [];
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

List<Run> _makeRuns(int count) {
  return List.generate(count, (i) => _makeRun('run$i'));
}

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

List<Game> _makeGames(int count) {
  return List.generate(count, (i) => _makeGame('game$i'));
}

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

List<User> _makeUsers(int count) {
  return List.generate(count, (i) => _makeUser('user$i'));
}

void main() {
  group('RunsFeedNotifier', () {
    test('loadInitial sets loading then success with items', () async {
      final repo = MockRepository();
      repo.onGetRuns = () => _makeRuns(50);
      final notifier = RunsFeedNotifier(repo);

      expect(notifier.state.status, equals(FeedStatus.initial));

      await notifier.loadInitial();

      expect(notifier.state.status, equals(FeedStatus.success));
      expect(notifier.state.items.length, equals(50));
      expect(notifier.state.hasMore, isTrue);
    });

    test('loadInitial sets failure on error', () async {
      final repo = MockRepository();
      repo.errorToThrow = Exception('Network error');
      final notifier = RunsFeedNotifier(repo);

      await notifier.loadInitial();

      expect(notifier.state.status, equals(FeedStatus.failure));
      expect(notifier.state.error, contains('Network error'));
    });

    test('refresh reloads items', () async {
      final repo = MockRepository();
      repo.onGetRuns = () => _makeRuns(25);
      final notifier = RunsFeedNotifier(repo);

      await notifier.loadInitial();
      repo.onGetRuns = () => _makeRuns(30);
      await notifier.refresh();

      expect(notifier.state.items.length, equals(30));
    });

    test('loadMore appends items', () async {
      final repo = MockRepository();
      repo.onGetRuns = () => _makeRuns(50);
      final notifier = RunsFeedNotifier(repo);

      await notifier.loadInitial();
      repo.onGetRuns = () => _makeRuns(50);
      await notifier.loadMore();

      expect(notifier.state.items.length, equals(100));
      expect(notifier.state.offset, equals(100));
    });

    test('loadMore does nothing when hasMore is false', () async {
      final repo = MockRepository();
      repo.onGetRuns = () => _makeRuns(10);
      final notifier = RunsFeedNotifier(repo);

      await notifier.loadInitial();
      await notifier.loadMore();

      expect(notifier.state.items.length, equals(10));
    });
  });

  group('GamesFeedNotifier', () {
    test('loadInitial with query sets query in state', () async {
      final repo = MockRepository();
      repo.onGetGames = () => _makeGames(10);
      final notifier = GamesFeedNotifier(repo);

      await notifier.loadInitial(query: 'mario');

      expect(notifier.state.query, equals('mario'));
      expect(notifier.state.items.length, equals(10));
    });

    test('refresh with query preserves query', () async {
      final repo = MockRepository();
      repo.onGetGames = () => _makeGames(10);
      final notifier = GamesFeedNotifier(repo);

      await notifier.loadInitial(query: 'mario');
      await notifier.refresh(query: 'zelda');

      expect(notifier.state.query, equals('zelda'));
    });
  });

  group('UsersFeedNotifier', () {
    test('loadInitial with query sets query in state', () async {
      final repo = MockRepository();
      repo.onGetUsers = () => _makeUsers(10);
      final notifier = UsersFeedNotifier(repo);

      await notifier.loadInitial(query: 'player');

      expect(notifier.state.query, equals('player'));
      expect(notifier.state.items.length, equals(10));
    });

    test('loadMore appends users', () async {
      final repo = MockRepository();
      repo.onGetUsers = () => _makeUsers(50);
      final notifier = UsersFeedNotifier(repo);

      await notifier.loadInitial(query: 'test');
      repo.onGetUsers = () => _makeUsers(50);
      await notifier.loadMore();

      expect(notifier.state.items.length, equals(100));
    });
  });

  group('CategoryRunsFeedNotifier', () {
    test('loadInitial fetches category runs', () async {
      final repo = MockRepository();
      repo.onGetCategoryRuns =
          () => PaginatedResponse(_makeRuns(50), true, null);
      final notifier = CategoryRunsFeedNotifier(repo, 'cat1');

      await notifier.loadInitial();

      expect(notifier.state.items.length, equals(50));
      expect(notifier.state.hasMore, isTrue);
    });
  });

  group('UserRunsFeedNotifier', () {
    test('loadInitial fetches user runs', () async {
      final repo = MockRepository();
      repo.onGetUserRuns = () => PaginatedResponse(_makeRuns(25), false, null);
      final notifier = UserRunsFeedNotifier(repo, 'user1');

      await notifier.loadInitial();

      expect(notifier.state.items.length, equals(25));
      expect(notifier.state.hasMore, isFalse);
    });
  });

  group('FeedState', () {
    test('isLoading returns true when status is loading', () {
      const state = FeedState<Run>(status: FeedStatus.loading);
      expect(state.isLoading, isTrue);
    });

    test('isLoading returns false when status is success', () {
      const state = FeedState<Run>(status: FeedStatus.success);
      expect(state.isLoading, isFalse);
    });

    test('isRefreshing returns true when loading with existing items', () {
      final state = FeedState<Run>(
        status: FeedStatus.loading,
        offset: 50,
        items: _makeRuns(10),
      );
      expect(state.isRefreshing, isTrue);
    });

    test('isLoadingMore returns true when loading with offset > 0', () {
      final state = FeedState<Run>(
        status: FeedStatus.loading,
        offset: 50,
      );
      expect(state.isLoadingMore, isTrue);
    });
  });
}
