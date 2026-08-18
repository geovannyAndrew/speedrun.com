import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_run/data/feed_state.dart';
import 'package:speed_run/di/providers.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/game_category_run_item_view.dart';
import 'package:speed_run/views/app_bar_game_view.dart';

class GameDetailScreen extends ConsumerStatefulWidget {
  final String gameId;

  const GameDetailScreen({
    Key? key,
    required this.gameId,
  }) : super(key: key);

  @override
  ConsumerState<GameDetailScreen> createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends ConsumerState<GameDetailScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(gameDetailProvider(widget.gameId));
      ref.read(gameCategoriesProvider(widget.gameId));
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameAsync = ref.watch(gameDetailProvider(widget.gameId));
    final categoriesAsync = ref.watch(gameCategoriesProvider(widget.gameId));

    ref.listen<AsyncValue<Game>>(gameDetailProvider(widget.gameId),
        (prev, next) {
      if (next.hasError) {
        Dialogs.showSnackbar(context, next.error.toString());
      }
    });

    ref.listen<AsyncValue<List<Category>>>(
        gameCategoriesProvider(widget.gameId), (prev, next) {
      if (next.hasError) {
        Dialogs.showSnackbar(context, next.error.toString());
      }
    });

    return gameAsync.when(
      loading: () => _buildScaffold(null, const <Category>[], categoriesAsync),
      error: (error, _) =>
          _buildScaffold(null, const <Category>[], categoriesAsync),
      data: (game) => categoriesAsync.when(
        loading: () =>
            _buildScaffold(game, const <Category>[], categoriesAsync),
        error: (error, _) =>
            _buildScaffold(game, const <Category>[], categoriesAsync),
        data: (categories) => _buildScaffold(game, categories, categoriesAsync),
      ),
    );
  }

  Widget _buildScaffold(Game? game, List<Category> categories,
      AsyncValue<List<Category>> categoriesAsync) {
    if (game == null) {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            categoriesAsync.when(
              loading: () => '',
              error: (_, __) => '',
              data: (_) => '',
            ),
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          ),
        ),
        backgroundColor: colors.blackBackground,
        body: Container(
          color: colors.blackBackground,
          alignment: const Alignment(0.0, 0.0),
          child: categoriesAsync.when(
            loading: () => const CircularProgressIndicator(),
            error: (error, _) => Text('Error: $error',
                style: const TextStyle(color: Colors.white)),
            data: (_) => const CircularProgressIndicator(),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.blackBackground,
      body: DefaultTabController(
        length: categories.length,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AppBarGameView(
                game: game,
                idTag: game.id,
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    isScrollable: true,
                    tabs: _buildTabs(categories),
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: Container(
            color: colors.blackBackground,
            child: TabBarView(
              children: _buildViewTabs(categories),
            ),
          ),
        ),
      ),
    );
  }

  List<Tab> _buildTabs(List<Category> categories) {
    return categories.map((category) => Tab(text: category.name)).toList();
  }

  List<Widget> _buildViewTabs(List<Category> categories) {
    return categories
        .map((category) => UserRunsListView(
              idGame: widget.gameId,
              idCategory: category.id,
            ))
        .toList();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: colors.blackDark,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class UserRunsListView extends ConsumerStatefulWidget {
  final String idGame;
  final String idCategory;

  const UserRunsListView(
      {Key? key, required this.idGame, required this.idCategory})
      : super(key: key);

  @override
  ConsumerState<UserRunsListView> createState() => _UserRunsListViewState();
}

class _UserRunsListViewState extends ConsumerState<UserRunsListView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadNextItems);
    Future.microtask(() {
      ref
          .read(categoryRunsFeedProvider(widget.idCategory).notifier)
          .loadInitial();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return ref
        .read(categoryRunsFeedProvider(widget.idCategory).notifier)
        .refresh();
  }

  void _loadNextItems() {
    final state = ref.read(categoryRunsFeedProvider(widget.idCategory));
    if (state.status != FeedStatus.loading &&
        state.hasMore &&
        state.items.length > 10) {
      ref.read(categoryRunsFeedProvider(widget.idCategory).notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(categoryRunsFeedProvider(widget.idCategory));

    ref.listen<FeedState<Run>>(categoryRunsFeedProvider(widget.idCategory),
        (prev, next) {
      if (next.error != null && prev?.error != next.error) {
        Dialogs.showSnackbar(context, next.error!);
      }
    });

    final runs = feedState.items;
    final isLastElement = runs.isNotEmpty && feedState.hasMore;

    return DecoratedBox(
      decoration: BoxDecoration(color: colors.blackBackground),
      child: Center(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          displacement: 60.0,
          onRefresh: _onRefresh,
          child: ListView.builder(
            key: PageStorageKey<String>(widget.idCategory),
            itemCount: runs.length,
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            itemBuilder: (BuildContext context, int index) {
              final run = runs[index];
              if (index >= runs.length - 1 && isLastElement) {
                Future.microtask(() {
                  ref
                      .read(
                          categoryRunsFeedProvider(widget.idCategory).notifier)
                      .loadMore();
                });
              }
              return GameCategoryRunItemView(
                  run, isLastElement && index == runs.length - 1, (run) {
                _goToRunDetail(run);
              });
            },
          ),
        ),
      ),
    );
  }

  void _goToRunDetail(Run run) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RunDetailScreen(runId: run.id)),
    );
  }
}
