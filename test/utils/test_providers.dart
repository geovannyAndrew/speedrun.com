import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:speed_run/data/cache_store.dart';
import 'package:speed_run/data/speedrun_repository.dart';
import 'package:speed_run/di/providers.dart';
import 'package:speed_run/network/rest_api.dart';

class FakeHttpClient implements http.Client {
  final String Function(http.Request)? onSend;
  final void Function(http.Request)? onSendNoop;
  String _lastResponse = '{"data": []}';
  int _lastStatusCode = 200;

  FakeHttpClient({this.onSend, this.onSendNoop});

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (onSend != null && request is http.Request) {
      _lastResponse = onSend!(request);
    } else if (onSendNoop != null && request is http.Request) {
      onSendNoop!(request);
    }
    return http.StreamedResponse(
      Stream.value(utf8.encode(_lastResponse)),
      _lastStatusCode,
    );
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    _lastResponse = '{"data": []}';
    _lastStatusCode = 200;
    return http.Response(_lastResponse, _lastStatusCode);
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    _lastResponse = '{"data": []}';
    _lastStatusCode = 200;
    return http.Response(_lastResponse, _lastStatusCode);
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) async {
    _lastResponse = '';
    _lastStatusCode = 200;
    return http.Response(_lastResponse, _lastStatusCode);
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    _lastResponse = '{"data": []}';
    _lastStatusCode = 200;
    return http.Response(_lastResponse, _lastStatusCode);
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    _lastResponse = '{"data": []}';
    _lastStatusCode = 200;
    return http.Response(_lastResponse, _lastStatusCode);
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    _lastResponse = '{"data": []}';
    _lastStatusCode = 200;
    return http.Response(_lastResponse, _lastStatusCode);
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    return '{"data": []}';
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    return Uint8List.fromList(utf8.encode('{"data": []}'));
  }

  @override
  void close() {}
}

class FakeCacheStore implements CacheStore {
  final Map<String, String> _storage = {};

  @override
  Future<void> save(String name, String content) async {
    _storage[name] = content;
  }

  @override
  Future<String> load(String name) async {
    return _storage[name] ?? '';
  }

  void clear() {
    _storage.clear();
  }
}

class FakeApiError extends ApiError {
  FakeApiError() : super(0, 'Fake error');
}

Override httpClientOverride(http.Client client) {
  return httpClientProvider.overrideWithValue(client);
}

Override cacheStoreOverride(CacheStore cache) {
  return cacheStoreProvider.overrideWithValue(cache);
}

List<Override> testProviderOverrides({
  http.Client? client,
  CacheStore? cache,
  RestAPI? api,
  SpeedrunRepository? repository,
}) {
  return [
    if (client != null) httpClientOverride(client),
    if (cache != null) cacheStoreOverride(cache),
    if (api != null) apiProvider.overrideWithValue(api),
    if (repository != null)
      speedrunRepositoryProvider.overrideWithValue(repository),
  ];
}
