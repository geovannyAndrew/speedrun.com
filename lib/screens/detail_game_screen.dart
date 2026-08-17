import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/game_category_run_item_view.dart';
import 'package:speed_run/views/app_bar_game_view.dart';

class GameDetailScreen extends StatefulWidget {
  final Game? game;

  const GameDetailScreen({Key? key, this.game}) : super(key: key);

  @override
  _GameDetailScreenState createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen>
    with SingleTickerProviderStateMixin {
  Game? _game;
  var _categories = <Category>[];

  @override
  void initState() {
    super.initState();
    _getCategories();
  }

  Future _getGame() async {
    try {
      final game = await RestAPI.instance.getGame(id: widget.game!.id);
      if (mounted) {
        setState(() {
          _game = game;
        });
      }
    } catch (e) {
      if (mounted) {
        Dialogs.showSnackbar(context, e.toString());
      }
    }
  }

  Future _getCategories() async {
    try {
      final categories = await RestAPI.instance.getGameCategories(idGame: widget.game!.id);
      if (mounted) {
        setState(() {
          _categories = categories;
          _game = widget.game;
        });
        _getGame();
      }
    } catch (e) {
      if (mounted) {
        Dialogs.showSnackbar(context, e.toString());
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _game == null
          ? AppBar(
              centerTitle: true,
              title: Text(
                widget.game?.name ?? "",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            )
          : null,
      backgroundColor: colors.blackBackground,
      body: _game == null
          ? Container(
              color: colors.blackBackground,
              alignment: const Alignment(0.0, 0.0),
              child: const CircularProgressIndicator(),
            )
          : DefaultTabController(
              length: _categories.length,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    AppBarGameView(
                      game: _game,
                      idTag: _game!.id,
                    ),
                    SliverPersistentHeader(
                      delegate: _SliverAppBarDelegate(
                        TabBar(
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.white,
                          isScrollable: true,
                          tabs: _buildTabs(),
                        ),
                      ),
                      pinned: true,
                    ),
                  ];
                },
                body: Container(
                  color: colors.blackBackground,
                  child: TabBarView(
                    children: _buildViewTabs(),
                  ),
                ),
              ),
            ),
    );
  }

  List<Tab> _buildTabs() {
    final tabs = <Tab>[];
    for (final category in _categories) {
      tabs.add(Tab(
          text: category.name,
        ),);
    }
    return tabs;
  }

  List<Widget> _buildViewTabs() {
    final views = <Widget>[];
    for (final category in _categories) {
      views.add(UserRunsListView(
          idGame: widget.game!.id,
          idCategory: category.id,
        ),);
    }
    return views;
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
      BuildContext context, double shrinkOffset, bool overlapsContent,) {
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

class UserRunsListView extends StatefulWidget {
  final String idGame;
  final String idCategory;

  const UserRunsListView({Key? key, required this.idGame, required this.idCategory}) : super(key: key);

  @override
  _UserRunsListViewState createState() => _UserRunsListViewState();
}

class _UserRunsListViewState extends State<UserRunsListView>
    with AfterLayoutMixin<UserRunsListView> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late ScrollController _scrollController;
  final runs = <Run>[];
  var _loadingItems = false;
  var _allLoaded = false;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadNextItems);
    super.initState();
  }

  Future _onRefresh() {
    return _getRuns(clearList: true);
  }

  void _loadNextItems() {
    if (!_loadingItems && !_allLoaded && runs.length > 10) {
      _getRuns();
    }
  }

  Future _getRuns({bool clearList = false}) async {
    _loadingItems = true;
    final offset = clearList ? 0 : runs.length;
    try {
      final response = await RestAPI.instance.getCategoryRuns(
          idCategory: widget.idCategory, offset: offset);
      if (mounted) {
        setState(() {
          if (clearList) {
            this.runs.clear();
            _allLoaded = false;
          }
          this.runs.addAll(response.items);
          if (response.items.length < AppConfig.itemsPerPage) {
            _allLoaded = true;
          }
        });
      }
      _loadingItems = false;
    } catch (e) {
      _loadingItems = false;
      if (mounted) {
        Dialogs.showSnackbar(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            final isLastElement =
                index >= runs.length - 1 && !_allLoaded;
            if (isLastElement) {
              _loadNextItems();
            }
            return GameCategoryRunItemView(run, isLastElement, (run) {
              _goToRunDetal(run);
            });
          },
        ),
      ),),
    );
  }

  void _goToRunDetal(Run run) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RunDetailScreen(run: run)),);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (runs.isEmpty) {
      _refreshIndicatorKey.currentState?.show();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();
  }
}
