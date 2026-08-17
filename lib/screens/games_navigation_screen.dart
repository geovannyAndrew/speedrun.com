import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_run/data/feed_state.dart';
import 'package:speed_run/di/providers.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/screens/detail_game_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/game_item_view.dart';
import 'package:speed_run/views/screen_search_view.dart';

class GamesNavigationScreen extends ConsumerStatefulWidget {
  const GamesNavigationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<GamesNavigationScreen> createState() =>
      _GamesNavigationScreenState();
}

class _GamesNavigationScreenState extends ConsumerState<GamesNavigationScreen>
    with AfterLayoutMixin<GamesNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late ScrollController _scrollController;
  String? _currentQuery;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadNextItems);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFeed();
    });
  }

  void _initializeFeed() {
    final feedState = ref.read(gamesFeedProvider);
    if (feedState.items.isEmpty && feedState.status != FeedStatus.loading) {
      ref.read(gamesFeedProvider.notifier).loadInitial(query: _currentQuery);
    }
  }

  void _onSearch(String query) {
    setState(() {
      _currentQuery = query.isEmpty ? null : query;
    });
    ref.read(gamesFeedProvider.notifier).refresh(query: _currentQuery);
  }

  void _onClose() {
    setState(() {
      _currentQuery = null;
    });
    ref.read(gamesFeedProvider.notifier).loadInitial(query: null);
  }

  void _loadNextItems() {
    final feedState = ref.read(gamesFeedProvider);
    if (_scrollController.position.extentAfter < 500 &&
        !feedState.isLoadingMore &&
        feedState.hasMore &&
        feedState.items.length > 10) {
      ref.read(gamesFeedProvider.notifier).loadMore();
    }
  }

  Future<void> _onRefresh() {
    return ref.read(gamesFeedProvider.notifier).refresh(query: _currentQuery);
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(gamesFeedProvider);

    ref.listen<FeedState<Game>>(gamesFeedProvider, (previous, next) {
      if (next.status == FeedStatus.failure && next.error != null) {
        Dialogs.showSnackbar(context, next.error!);
      }
    });

    return ScreenSearchView(
      title: "Games",
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
            child: OrientationBuilder(
              builder: (context, orientation) {
                return GridView.builder(
                  controller: _scrollController,
                  itemCount: feedState.items.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        MediaQuery.of(context).orientation == Orientation.landscape
                            ? 4
                            : 2,
                    childAspectRatio: 0.6,
                  ),
                  padding:
                      const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  itemBuilder: (BuildContext context, int index) {
                    final item = feedState.items[index];
                    final isLastElement =
                        index >= feedState.items.length - 1 && feedState.hasMore;
                    return GameItemView(item, isLastElement, (game) {
                      _goToGameDetail(game);
                    });
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  void _goToGameDetail(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => GameDetailScreen(game: game)),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final feedState = ref.read(gamesFeedProvider);
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
