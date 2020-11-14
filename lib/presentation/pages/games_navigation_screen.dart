import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/data/models/game.dart';
import 'package:speed_run/injection.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/presentation/games/games_list/cubit/gamelist_cubit.dart';
import 'package:speed_run/presentation/pages/detail_game_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/game_item_view.dart';
import 'package:speed_run/presentation/widgets/screen_search_view.dart';
import 'package:speed_run/utils/storage.dart' as storage;

class GamesNavigationScreen extends StatefulWidget {
  GamesNavigationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GamesNavigationScreenState();
  }
}

class GamesNavigationScreenState extends State<GamesNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScreenSearchViewState> _screenSearchKey =
      new GlobalKey<ScreenSearchViewState>();
  ScrollController _scrollController;

  bool get loadingItems => null;

  void onQuerySearch(String query) {
    //widget.querySearch = query;
    _refreshIndicatorKey.currentState.show();
  }

  void _restoreGames() {
    //widget.querySearch = null;
    /*storage.getGames((games) {
      setState(() {
        widget.games.clear();
      });
    });*/
  }

  void _loadNextItems() {
    //print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 500) {
      context.watch<GamelistCubit>().loadMoreGames();
    }
  }

  /*Future _getGames({bool clearList = false}) {
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
  }*/

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) => getIt<GamelistCubit>())
      ],
      child: BlocConsumer<GamelistCubit, GamelistState>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenSearchView(
            key: _screenSearchKey,
            title: "Games",
            onSearch: (query) {
              onQuerySearch(query);
            },
            onClose: _restoreGames,
            querySearch: state.query,
            body: Container(
              child: Center(
                  child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      child:
                          OrientationBuilder(builder: (context, orientation) {
                        return GridView.builder(
                          controller: _scrollController,
                          itemCount: state.games.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount:
                                MediaQuery.of(context).orientation ==
                                        Orientation.landscape
                                    ? 4
                                    : 2,
                            childAspectRatio: 0.6,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          itemBuilder: (BuildContext context, int index) {
                            var item = state.games[index];
                            final isLastElement =
                                index >= state.games.length - 1;
                            return GameItemView(item, isLastElement, (game) {
                              _goToGameDetal(game);
                            });
                          },
                        );
                      }),
                      onRefresh: context.watch<GamelistCubit>().refreshGames)),
              decoration: BoxDecoration(color: colors.blackBackground),
            ),
          );
        },
      ),
    );
  }

  void _goToGameDetal(Game game) {
    //Navigator.pushNamed(context, "/run_detail");
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => GameDetailScreen(game: game)));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //if (context.watch<GamelistCubit>().gameListIsEmpty) {
      _refreshIndicatorKey.currentState.show();
      //}
    });
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_loadNextItems);
    super.dispose();
  }
}
