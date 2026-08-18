import 'package:flutter_test/flutter_test.dart';
import 'package:speed_run/data/cache_store.dart';

void main() {
  group('MemoryCacheStore', () {
    late MemoryCacheStore cache;

    setUp(() {
      cache = MemoryCacheStore();
    });

    test('save and load returns saved content', () async {
      await cache.save('test', '{"data": [{"id": "1"}]}');

      final result = await cache.load('test');

      expect(result, equals('{"data": [{"id": "1"}]}'));
    });

    test('load returns empty string for non-existent key', () async {
      final result = await cache.load('nonexistent');

      expect(result, equals(''));
    });

    test('save overwrites existing content', () async {
      await cache.save('test', 'first');
      await cache.save('test', 'second');

      final result = await cache.load('test');

      expect(result, equals('second'));
    });
  });

  group('CacheData', () {
    test('parse returns empty list for empty string', () {
      final cacheData = CacheData('');

      final result = cacheData.parse((json) => json['id'], 'data');

      expect(result, isEmpty);
    });

    test('parse extracts items from data key', () {
      final cacheData = CacheData('{"data": [{"id": "1"}, {"id": "2"}]}');

      final result = cacheData.parse((json) => json['id'] as String, 'data');

      expect(result, equals(['1', '2']));
    });
  });
}
