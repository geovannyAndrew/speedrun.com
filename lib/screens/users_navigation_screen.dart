import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_run/data/feed_state.dart';
import 'package:speed_run/di/providers.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/screens/detail_user_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/user_item_view.dart';
import 'package:speed_run/views/screen_search_view.dart';

class UsersNavigationScreen extends ConsumerStatefulWidget {
  const UsersNavigationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<UsersNavigationScreen> createState() =>
      _UsersNavigationScreenState();
}

class _UsersNavigationScreenState extends ConsumerState<UsersNavigationScreen>
    with AfterLayoutMixin<UsersNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  String? _currentQuery;
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadNextItems);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFeed();
    });
  }

  void _initializeFeed() {
    final feedState = ref.read(usersFeedProvider);
    if (feedState.items.isEmpty && feedState.status != FeedStatus.loading) {
      ref.read(usersFeedProvider.notifier).loadInitial(query: _currentQuery);
    }
  }

  void _onSearch(String query) {
    setState(() {
      _currentQuery = query.isEmpty ? null : query;
    });
    ref.read(usersFeedProvider.notifier).refresh(query: _currentQuery);
  }

  void _onClose() {
    setState(() {
      _currentQuery = null;
    });
    ref.read(usersFeedProvider.notifier).loadInitial(query: null);
  }

  void _loadNextItems() {
    final feedState = ref.read(usersFeedProvider);
    if (_scrollController.position.extentAfter < 500 &&
        !feedState.isLoadingMore &&
        feedState.hasMore &&
        feedState.items.length > 10) {
      ref.read(usersFeedProvider.notifier).loadMore();
    }
  }

  Future<void> _onRefresh() {
    return ref.read(usersFeedProvider.notifier).refresh(query: _currentQuery);
  }

  void _handleError(String? error) {
    if (error == null) return;
    if (error.contains('400')) {
      Dialogs.showSnackbar(
        context,
        "Please make sure to use 3 or more characters in the search",
      );
    } else {
      Dialogs.showSnackbar(context, error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(usersFeedProvider);

    ref.listen<FeedState<User>>(usersFeedProvider, (previous, next) {
      if (next.status == FeedStatus.failure && next.error != null) {
        _handleError(next.error);
      }
    });

    return ScreenSearchView(
      title: "Users",
      onSearch: _onSearch,
      onClose: _onClose,
      querySearch: _currentQuery,
      isLoading: feedState.isLoading,
      body: DecoratedBox(
        decoration: BoxDecoration(color: colors.blackBackground),
        child: Center(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            child: ListView.builder(
              controller: _scrollController,
              itemCount: feedState.items.length,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              itemBuilder: (BuildContext context, int index) {
                final item = feedState.items[index];
                return UserItemView(item, false, (user) {
                  _goToUserDetail(user);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  void _goToUserDetail(User user) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => UserDetailScreen(userId: user.id)),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final feedState = ref.read(usersFeedProvider);
    if (feedState.items.isEmpty) {
      _refreshIndicatorKey.currentState?.show();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();
  }
}
