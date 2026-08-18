import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:speed_run/data/speedrun_repository.dart';
import 'package:speed_run/di/providers.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/logic/names.dart';
import 'package:speed_run/logic/asset.dart';
import 'package:speed_run/network/rest_api.dart';

class MockRepository implements SpeedrunRepository {
  Run? runToReturn;
  Game? gameToReturn;
  List<Category>? categoriesToReturn;
  User? userToReturn;
  Exception? errorToThrow;

  @override
  Future<List<Run>> getRuns(
          {required int offset, bool forceRefresh = false}) async =>
      [];

  @override
  Future<List<Game>> getGames({
    required int offset,
    String? query,
    bool forceRefresh = false,
  }) async =>
      [];

  @override
  Future<List<User>> getUsers({
    required int offset,
    String? query,
    bool forceRefresh = false,
  }) async =>
      [];

  @override
  Future<PaginatedResponse<Run>> getCategoryRuns({
    required int offset,
    required String idCategory,
  }) async =>
      PaginatedResponse([], false, null);

  @override
  Future<PaginatedResponse<Run>> getUserRuns({
    required int offset,
    required String idUser,
  }) async =>
      PaginatedResponse([], false, null);

  @override
  Future<Run> getRun({required String id}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return runToReturn!;
  }

  @override
  Future<Game> getGame({required String id}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return gameToReturn!;
  }

  @override
  Future<List<Category>> getGameCategories({required String idGame}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return categoriesToReturn!;
  }

  @override
  Future<User> getUser({required String id}) async {
    if (errorToThrow != null) throw errorToThrow!;
    return userToReturn!;
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
  group('Detail Providers', () {
    late MockRepository mockRepo;

    setUp(() {
      mockRepo = MockRepository();
    });

    test('runDetailProvider returns run data on success', () async {
      mockRepo.runToReturn = _makeRun('run1');

      final container = ProviderContainer(
        overrides: [
          speedrunRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      addTearDown(container.dispose);

      final result = await container.read(runDetailProvider('run1').future);

      expect(result.id, equals('run1'));
    });

    test('runDetailProvider returns error on failure', () async {
      mockRepo.errorToThrow = Exception('Run not found');

      final container = ProviderContainer(
        overrides: [
          speedrunRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      addTearDown(container.dispose);

      expect(
        () => container.read(runDetailProvider('nonexistent').future),
        throwsException,
      );
    });

    test('gameDetailProvider returns game data on success', () async {
      mockRepo.gameToReturn = _makeGame('game1');

      final container = ProviderContainer(
        overrides: [
          speedrunRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      addTearDown(container.dispose);

      final result = await container.read(gameDetailProvider('game1').future);

      expect(result.id, equals('game1'));
    });

    test('gameCategoriesProvider returns categories on success', () async {
      mockRepo.categoriesToReturn = [
        Category('cat1', 'Any%', '', '', ''),
        Category('cat2', '100%', '', '', ''),
      ];

      final container = ProviderContainer(
        overrides: [
          speedrunRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      addTearDown(container.dispose);

      final result =
          await container.read(gameCategoriesProvider('game1').future);

      expect(result.length, equals(2));
      expect(result.first.name, equals('Any%'));
    });

    test('userDetailProvider returns user data on success', () async {
      mockRepo.userToReturn = _makeUser('user1');

      final container = ProviderContainer(
        overrides: [
          speedrunRepositoryProvider.overrideWithValue(mockRepo),
        ],
      );

      addTearDown(container.dispose);

      final result = await container.read(userDetailProvider('user1').future);

      expect(result.id, equals('user1'));
    });
  });
}
