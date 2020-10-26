import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_game_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/game_item_view.dart';
import 'package:speed_run/views/screen_search_view.dart';
import 'package:speed_run/utils/storage.dart' as storage;

class GamesNavigationScreen extends StatefulWidget {
  var games = List<Game>();
  var loadingItems = false;
  var _allLoaded = false;
  String querySearch;

  GamesNavigationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GamesNavigationScreenState();
  }
}

class GamesNavigationScreenState extends State<GamesNavigationScreen>
    with AfterLayoutMixin<GamesNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScreenSearchViewState> _screenSearchKey =
      new GlobalKey<ScreenSearchViewState>();
  ScrollController _scrollController;

  bool get loadingItems => null;

  void onQuerySearch(String query) {
    widget.querySearch = query;
    _refreshIndicatorKey.currentState.show();
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
    //print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 500 &&
        !widget._allLoaded &&
        !widget.loadingItems &&
        widget.games.length > 10) {
      _getGames();
    }
  }

  Future _getGames({bool clearList = false}) {
    widget.loadingItems = true;
    _screenSearchKey.currentState.visibleIcon = false;
    int offset = clearList ? 0 : widget.games.length;
    var future = RestAPI.instance.getGames(
        offset: offset,
        query: widget.querySearch ?? "",
        onSuccess: (games) {
          _screenSearchKey.currentState.visibleIcon = true;
          if (mounted) {
            setState(() {
              if (clearList) {
                this.widget.games.clear();
                widget._allLoaded = false;
              }
              this.widget.games.addAll(games);
              if (games.length < AppConfig.itemsPerPage) {
                widget._allLoaded = true;
              }
            });
          }
          widget.loadingItems = false;
        },
        onError: (error) {
          _screenSearchKey.currentState.visibleIcon = true;
          widget.loadingItems = false;
          Dialogs.showResponseErrorSnackbar(context, error);
        });
    return future;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenSearchView(
      key: _screenSearchKey,
      title: "Games",
      onSearch: (query) {
        onQuerySearch(query);
      },
      onClose: _restoreGames,
      querySearch: widget.querySearch,
      body: Container(
        child: Center(
            child: RefreshIndicator(
          key: _refreshIndicatorKey,
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
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
              itemBuilder: (BuildContext context, int index) {
                var item = widget.games[index];
                final isLastElement = index >= widget.games.length - 1;
                return GameItemView(item, isLastElement, (game) {
                  _goToGameDetal(game);
                });
              },
            );
          }),
          onRefresh: _onRefresh,
        )),
        decoration: BoxDecoration(color: colors.blackBackground),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.games.length == 0) {
      _refreshIndicatorKey.currentState.show();
    }
  }

  void _goToGameDetal(Game game) {
    //Navigator.pushNamed(context, "/run_detail");
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GameDetailScreen(game: game)));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();
  }
}
