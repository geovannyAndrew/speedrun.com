import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:speed_run/data/cache_store.dart';
import 'package:speed_run/data/speedrun_repository.dart';
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
