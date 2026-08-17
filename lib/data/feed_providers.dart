import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_run/data/feed_state.dart';
import 'package:speed_run/data/speedrun_repository.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';

class RunsFeedNotifier extends StateNotifier<FeedState<Run>> {
  final SpeedrunRepository _repository;

  RunsFeedNotifier(this._repository) : super(const FeedState<Run>());

  Future<void> loadInitial() async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(status: FeedStatus.loading, error: null);

    try {
      final items = await _repository.getRuns(offset: 0);
      state = state.copyWith(
        items: items,
        offset: items.length,
        hasMore: items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(status: FeedStatus.loading, error: null);

    try {
      final items = await _repository.getRuns(offset: 0, forceRefresh: true);
      state = state.copyWith(
        items: items,
        offset: items.length,
        hasMore: items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.status == FeedStatus.loading || !state.hasMore) return;

    state = state.copyWith(status: FeedStatus.loading);

    try {
      final items = await _repository.getRuns(offset: state.offset);
      state = state.copyWith(
        items: [...state.items, ...items],
        offset: state.offset + items.length,
        hasMore: items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }
}

class GamesFeedNotifier extends StateNotifier<FeedState<Game>> {
  final SpeedrunRepository _repository;

  GamesFeedNotifier(this._repository) : super(const FeedState<Game>());

  String? get _currentQuery => state.query;

  Future<void> loadInitial({String? query}) async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(
      status: FeedStatus.loading,
      query: query,
      error: null,
    );

    try {
      final items = await _repository.getGames(offset: 0, query: query);
      state = state.copyWith(
        items: items,
        offset: items.length,
        hasMore: items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh({String? query}) async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(
      status: FeedStatus.loading,
      query: query,
      error: null,
    );

    try {
      final items = await _repository.getGames(
        offset: 0,
        query: query,
        forceRefresh: true,
      );
      state = state.copyWith(
        items: items,
        offset: items.length,
        hasMore: items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    final query = _currentQuery;
    if (state.status == FeedStatus.loading || !state.hasMore) return;

    state = state.copyWith(status: FeedStatus.loading);

    try {
      final items =
          await _repository.getGames(offset: state.offset, query: query);
      state = state.copyWith(
        items: [...state.items, ...items],
        offset: state.offset + items.length,
        hasMore: items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }
}

class UsersFeedNotifier extends StateNotifier<FeedState<User>> {
  final SpeedrunRepository _repository;

  UsersFeedNotifier(this._repository) : super(const FeedState<User>());

  String? get _currentQuery => state.query;

  Future<void> loadInitial({String? query}) async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(
      status: FeedStatus.loading,
      query: query,
      error: null,
    );

    try {
      final items = await _repository.getUsers(offset: 0, query: query);
      state = state.copyWith(
        items: items,
        offset: items.length,
        hasMore: items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh({String? query}) async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(
      status: FeedStatus.loading,
      query: query,
      error: null,
    );

    try {
      final items = await _repository.getUsers(
        offset: 0,
        query: query,
        forceRefresh: true,
      );
      state = state.copyWith(
        items: items,
        offset: items.length,
        hasMore: items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    final query = _currentQuery;
    if (state.status == FeedStatus.loading || !state.hasMore) return;

    state = state.copyWith(status: FeedStatus.loading);

    try {
      final items =
          await _repository.getUsers(offset: state.offset, query: query);
      state = state.copyWith(
        items: [...state.items, ...items],
        offset: state.offset + items.length,
        hasMore: items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }
}

class CategoryRunsFeedNotifier extends StateNotifier<FeedState<Run>> {
  final SpeedrunRepository _repository;
  final String _categoryId;

  CategoryRunsFeedNotifier(this._repository, this._categoryId)
      : super(const FeedState<Run>());

  Future<void> loadInitial() async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(status: FeedStatus.loading, error: null);

    try {
      final response =
          await _repository.getCategoryRuns(offset: 0, idCategory: _categoryId);
      state = state.copyWith(
        items: response.items,
        offset: response.items.length,
        hasMore: response.items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(status: FeedStatus.loading, error: null);

    try {
      final response =
          await _repository.getCategoryRuns(offset: 0, idCategory: _categoryId);
      state = state.copyWith(
        items: response.items,
        offset: response.items.length,
        hasMore: response.items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.status == FeedStatus.loading || !state.hasMore) return;

    state = state.copyWith(status: FeedStatus.loading);

    try {
      final response = await _repository.getCategoryRuns(
          offset: state.offset, idCategory: _categoryId);
      state = state.copyWith(
        items: [...state.items, ...response.items],
        offset: state.offset + response.items.length,
        hasMore: response.items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }
}

class UserRunsFeedNotifier extends StateNotifier<FeedState<Run>> {
  final SpeedrunRepository _repository;
  final String _userId;

  UserRunsFeedNotifier(this._repository, this._userId)
      : super(const FeedState<Run>());

  Future<void> loadInitial() async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(status: FeedStatus.loading, error: null);

    try {
      final response =
          await _repository.getUserRuns(offset: 0, idUser: _userId);
      state = state.copyWith(
        items: response.items,
        offset: response.items.length,
        hasMore: response.items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> refresh() async {
    if (state.status == FeedStatus.loading) return;

    state = state.copyWith(status: FeedStatus.loading, error: null);

    try {
      final response =
          await _repository.getUserRuns(offset: 0, idUser: _userId);
      state = state.copyWith(
        items: response.items,
        offset: response.items.length,
        hasMore: response.items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }

  Future<void> loadMore() async {
    if (state.status == FeedStatus.loading || !state.hasMore) return;

    state = state.copyWith(status: FeedStatus.loading);

    try {
      final response =
          await _repository.getUserRuns(offset: state.offset, idUser: _userId);
      state = state.copyWith(
        items: [...state.items, ...response.items],
        offset: state.offset + response.items.length,
        hasMore: response.items.length >= 50,
        status: FeedStatus.success,
      );
    } catch (e) {
      state = state.copyWith(
        status: FeedStatus.failure,
        error: e.toString(),
      );
    }
  }
}
