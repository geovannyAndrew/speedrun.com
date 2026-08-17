import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_game_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/utils/storage.dart' as storage;
import 'package:speed_run/view_items/game_item_view.dart';
import 'package:speed_run/views/screen_search_view.dart';

class GamesNavigationScreen extends StatefulWidget {
  List<Game> games = <Game>[];
  bool loadingItems = false;
  var _allLoaded = false;
  String? querySearch;

  GamesNavigationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GamesNavigationScreenState();
  }
}

class GamesNavigationScreenState extends State<GamesNavigationScreen>
    with AfterLayoutMixin<GamesNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScreenSearchViewState> _screenSearchKey =
      GlobalKey<ScreenSearchViewState>();
  late ScrollController _scrollController;

  bool get loadingItems => false;

  void onQuerySearch(String query) {
    widget.querySearch = query;
    _refreshIndicatorKey.currentState?.show();
  }

  void _restoreGames() {
    widget.querySearch = null;
    storage.getGames((games) {
      setState(() {
        widget.games.clear();
        widget.games.addAll(games);
      });
    });
  }

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadNextItems);
    super.initState();
  }

  Future _onRefresh() {
    return _getGames(clearList: true);
  }

  void _loadNextItems() {
    if (_scrollController.position.extentAfter < 500 &&
        !widget._allLoaded &&
        !widget.loadingItems &&
        widget.games.length > 10) {
      _getGames();
    }
  }

  Future _getGames({bool clearList = false}) {
    widget.loadingItems = true;
    _screenSearchKey.currentState?.visibleIcon = false;
    final int offset = clearList ? 0 : widget.games.length;
    final future = RestAPI.instance.getGames(
        offset: offset,
        query: widget.querySearch ?? "",
        onSuccess: (games) {
          _screenSearchKey.currentState?.visibleIcon = true;
          if (mounted) {
            setState(() {
              if (clearList) {
                widget.games.clear();
                widget._allLoaded = false;
              }
              widget.games.addAll(games);
              if (games.length < AppConfig.itemsPerPage) {
                widget._allLoaded = true;
              }
            });
          }
          widget.loadingItems = false;
        },
        onError: (error) {
          _screenSearchKey.currentState?.visibleIcon = true;
          widget.loadingItems = false;
          Dialogs.showResponseErrorSnackbar(context, error);
        },);
    return future;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSearchView(
      key: _screenSearchKey,
      title: "Games",
      onSearch: (query) {
        onQuerySearch(query);
      },
      onClose: _restoreGames,
      querySearch: widget.querySearch,
      body: DecoratedBox(
        decoration: BoxDecoration(color: colors.blackBackground),
        child: Center(
            child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _onRefresh,
          child: OrientationBuilder(builder: (context, orientation) {
            return GridView.builder(
              controller: _scrollController,
              itemCount: widget.games.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    MediaQuery.of(context).orientation == Orientation.landscape
                        ? 4
                        : 2,
                childAspectRatio: 0.6,
              ),
              padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              itemBuilder: (BuildContext context, int index) {
                final item = widget.games[index];
                final isLastElement = index >= widget.games.length - 1;
                return GameItemView(item, isLastElement, (game) {
                  _goToGameDetal(game);
                });
              },
            );
          },),
        ),),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.games.isEmpty) {
      _refreshIndicatorKey.currentState?.show();
    }
  }

  void _goToGameDetal(Game game) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GameDetailScreen(game: game)),);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();
  }
}
