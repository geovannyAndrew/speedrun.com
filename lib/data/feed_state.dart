import 'package:flutter/foundation.dart';

enum FeedStatus { initial, loading, success, failure }

@immutable
class FeedState<T> {
  final List<T> items;
  final String? query;
  final int offset;
  final bool hasMore;
  final FeedStatus status;
  final String? error;

  const FeedState({
    this.items = const [],
    this.query,
    this.offset = 0,
    this.hasMore = true,
    this.status = FeedStatus.initial,
    this.error,
  });

  FeedState<T> copyWith({
    List<T>? items,
    String? query,
    int? offset,
    bool? hasMore,
    FeedStatus? status,
    String? error,
  }) {
    return FeedState<T>(
      items: items ?? this.items,
      query: query ?? this.query,
      offset: offset ?? this.offset,
      hasMore: hasMore ?? this.hasMore,
      status: status ?? this.status,
      error: error,
    );
  }

  bool get isLoading => status == FeedStatus.loading;
  bool get isRefreshing =>
      status == FeedStatus.loading && offset > 0 && items.isNotEmpty;
  bool get isLoadingMore => status == FeedStatus.loading && offset > 0;
}
