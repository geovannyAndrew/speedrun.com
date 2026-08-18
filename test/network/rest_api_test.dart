import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:speed_run/network/rest_api.dart';

class TestHttpClient implements http.Client {
  String responseBody;
  int statusCode;
  bool shouldThrowOnSend;

  TestHttpClient({
    this.responseBody = '{"data": []}',
    this.statusCode = 200,
    this.shouldThrowOnSend = false,
  });

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    if (shouldThrowOnSend) {
      throw Exception('Network error');
    }
    return http.StreamedResponse(
      Stream.value(utf8.encode(responseBody)),
      statusCode,
    );
  }

  @override
  Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
    if (shouldThrowOnSend) {
      throw Exception('Network error');
    }
    return http.Response(responseBody, statusCode);
  }

  @override
  Future<http.Response> delete(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return http.Response(responseBody, statusCode);
  }

  @override
  Future<http.Response> head(Uri url, {Map<String, String>? headers}) async {
    return http.Response(responseBody, statusCode);
  }

  @override
  Future<http.Response> patch(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return http.Response(responseBody, statusCode);
  }

  @override
  Future<http.Response> post(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return http.Response(responseBody, statusCode);
  }

  @override
  Future<http.Response> put(Uri url,
      {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
    return http.Response(responseBody, statusCode);
  }

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) async {
    return responseBody;
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) async {
    return Uint8List.fromList(utf8.encode(responseBody));
  }

  @override
  void close() {}
}

void main() {
  group('RestAPI', () {
    group('error handling', () {
      test('throws ApiError.http on non-200 status for getRuns', () async {
        final client = TestHttpClient(
          responseBody: '{"message": "Not Found"}',
          statusCode: 404,
        );
        final api = RestAPI(client, 'https://api.test/', 50);

        expect(() => api.getRuns(offset: 0), throwsA(isA<ApiError>()));
      });

      test('throws ApiError.http on non-200 status for getGames', () async {
        final client = TestHttpClient(
          responseBody: '{"message": "Not Found"}',
          statusCode: 404,
        );
        final api = RestAPI(client, 'https://api.test/', 50);

        expect(() => api.getGames(offset: 0), throwsA(isA<ApiError>()));
      });

      test('throws ApiError.http on non-200 status for getUsers', () async {
        final client = TestHttpClient(
          responseBody: '{"message": "Not Found"}',
          statusCode: 404,
        );
        final api = RestAPI(client, 'https://api.test/', 50);

        expect(() => api.getUsers(offset: 0), throwsA(isA<ApiError>()));
      });

      test('throws ApiError.http on non-200 status for getRun', () async {
        final client = TestHttpClient(
          responseBody: '{"message": "Run not found"}',
          statusCode: 404,
        );
        final api = RestAPI(client, 'https://api.test/', 50);

        expect(() => api.getRun(id: 'nonexistent'), throwsA(isA<ApiError>()));
      });

      test('throws ApiError.http on non-200 status for getGame', () async {
        final client = TestHttpClient(
          responseBody: '{"message": "Game not found"}',
          statusCode: 404,
        );
        final api = RestAPI(client, 'https://api.test/', 50);

        expect(() => api.getGame(id: 'nonexistent'), throwsA(isA<ApiError>()));
      });

      test('throws ApiError.http on non-200 status for getUser', () async {
        final client = TestHttpClient(
          responseBody: '{"message": "User not found"}',
          statusCode: 404,
        );
        final api = RestAPI(client, 'https://api.test/', 50);

        expect(() => api.getUser(id: 'nonexistent'), throwsA(isA<ApiError>()));
      });

      test('throws ApiError.network on network error', () async {
        final client = TestHttpClient(shouldThrowOnSend: true);
        final api = RestAPI(client, 'https://api.test/', 50);

        expect(() => api.getRuns(offset: 0), throwsA(isA<ApiError>()));
      });
    });
  });

  group('ApiError', () {
    test('http creates error with status code and message from JSON', () {
      final error = ApiError.http(404, '{"message": "Not found"}');

      expect(error.statusCode, equals(404));
      expect(error.message, equals('Not found'));
    });

    test('http falls back to body when no message in JSON', () {
      final error = ApiError.http(500, 'Internal Server Error');

      expect(error.statusCode, equals(500));
      expect(error.message, equals('Status: 500 body: Internal Server Error'));
    });

    test('network creates error with zero status code', () {
      final error = ApiError.network(Exception('Connection failed'));

      expect(error.statusCode, equals(0));
      expect(error.message, contains('Connection failed'));
    });

    test('parse creates error with parse prefix', () {
      final error = ApiError.parse(Exception('Unexpected character'));

      expect(error.statusCode, equals(0));
      expect(error.message, contains('Parse error'));
    });
  });
}
