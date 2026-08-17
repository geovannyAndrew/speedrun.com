import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:speed_run/data/cache_store.dart';
import 'package:speed_run/data/feed_providers.dart';
import 'package:speed_run/data/feed_state.dart';
import 'package:speed_run/data/speedrun_repository.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/rest_api.dart';

final apiBaseUrlProvider = Provider<String>((ref) {
  return 'https://www.speedrun.com/api/v1/';
});

final itemsPerPageProvider = Provider<int>((ref) {
  return 50;
});

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(() => client.close());
  return client;
});

final cacheStoreProvider = Provider<CacheStore>((ref) {
  return FileCacheStore();
});

final apiProvider = Provider<RestAPI>((ref) {
  final client = ref.watch(httpClientProvider);
  final baseUrl = ref.watch(apiBaseUrlProvider);
  final maxPerPage = ref.watch(itemsPerPageProvider);
  return RestAPI(client, baseUrl, maxPerPage);
});

final speedrunRepositoryProvider = Provider<SpeedrunRepository>((ref) {
  final api = ref.watch(apiProvider);
  final cache = ref.watch(cacheStoreProvider);
  return SpeedrunRepository(api, cache);
});

final runsFeedProvider =
    StateNotifierProvider<RunsFeedNotifier, FeedState<Run>>((ref) {
  final repository = ref.watch(speedrunRepositoryProvider);
  return RunsFeedNotifier(repository);
});

final gamesFeedProvider =
    StateNotifierProvider<GamesFeedNotifier, FeedState<Game>>((ref) {
  final repository = ref.watch(speedrunRepositoryProvider);
  return GamesFeedNotifier(repository);
});

final usersFeedProvider =
    StateNotifierProvider<UsersFeedNotifier, FeedState<User>>((ref) {
  final repository = ref.watch(speedrunRepositoryProvider);
  return UsersFeedNotifier(repository);
});

final runDetailProvider =
    FutureProvider.family<Run, String>((ref, runId) async {
  final repository = ref.watch(speedrunRepositoryProvider);
  return repository.getRun(id: runId);
});

final gameDetailProvider =
    FutureProvider.family<Game, String>((ref, gameId) async {
  final repository = ref.watch(speedrunRepositoryProvider);
  return repository.getGame(id: gameId);
});

final gameCategoriesProvider =
    FutureProvider.family<List<Category>, String>((ref, gameId) async {
  final repository = ref.watch(speedrunRepositoryProvider);
  final result = await repository.getGameCategories(idGame: gameId);
  return result.cast<Category>();
});

final userDetailProvider =
    FutureProvider.family<User, String>((ref, userId) async {
  final repository = ref.watch(speedrunRepositoryProvider);
  return repository.getUser(id: userId);
});

final categoryRunsFeedProvider = StateNotifierProvider.family<
    CategoryRunsFeedNotifier, FeedState<Run>, String>((ref, categoryId) {
  final repository = ref.watch(speedrunRepositoryProvider);
  return CategoryRunsFeedNotifier(repository, categoryId);
});

final userRunsFeedProvider =
    StateNotifierProvider.family<UserRunsFeedNotifier, FeedState<Run>, String>(
        (ref, userId) {
  final repository = ref.watch(speedrunRepositoryProvider);
  return UserRunsFeedNotifier(repository, userId);
});
