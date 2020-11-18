import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_run/data/models/game.dart';
import 'package:speed_run/injection.dart';
import 'package:speed_run/presentation/games/games_list/cubit/gamelist_cubit.dart';
import 'package:speed_run/presentation/pages/detail_game_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/view_items/game_item_view.dart';
import 'package:speed_run/presentation/widgets/screen_search_view.dart';

class GamesNavigationScreen extends StatefulWidget {
  GamesNavigationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return GamesNavigationScreenState();
  }
}

class GamesNavigationScreenState extends State<GamesNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final GlobalKey<ScreenSearchViewState> _screenSearchKey =
      new GlobalKey<ScreenSearchViewState>();
  ScrollController _scrollController;
  GamelistCubit gamelistCubit;

  void onQuerySearch(String query) {
    gamelistCubit.setQuery(query);
    _refreshIndicatorKey.currentState.show();
  }

  void _loadNextItems() {
    if (_scrollController.position.extentAfter < 500) {
      gamelistCubit.loadMoreGames();
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (BuildContext context) {
          gamelistCubit = getIt<GamelistCubit>();
          return gamelistCubit;
        })
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
            onClose: gamelistCubit.refreshGamesFromStorage,
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
    _scrollController = ScrollController()..addListener(_loadNextItems);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _refreshIndicatorKey.currentState.show();
    });
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_loadNextItems);
    super.dispose();
  }
}
