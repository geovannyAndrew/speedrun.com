import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/game_category_run_item_view.dart';
import 'package:speed_run/views/app_bar_game_view.dart';
import 'package:speed_run/utils/after_layout.dart';

class GameDetailScreen extends StatefulWidget {
  final Game? game;

  GameDetailScreen({Key? key, this.game}) : super(key: key);

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

  Future _getGame() {
    var future = RestAPI.instance.getGame(
        id: widget.game!.id,
        onSuccess: (game) {
          if (mounted) {
            setState(() {
              _game = game;
            });
          }
        },
        onError: (error) {
          Dialogs.showResponseErrroAlertDialog(
              buildContext: context,
              error: error,
              onActionAlert: () {
                Navigator.of(context).pop();
              });
        });
    return future;
  }

  Future _getCategories() {
    var future = RestAPI.instance.getGameCategories(
        idGame: widget.game!.id,
        onSuccess: (categories) {
          setState(() {
            _categories = categories;
            _game = widget.game;
          });
          _getGame();
        },
        onError: (error) {
          Dialogs.showResponseErrroAlertDialog(
              buildContext: context,
              error: error,
              onActionAlert: () {
                Navigator.of(context).pop();
              });
        });
    return future;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._game == null
          ? AppBar(
              centerTitle: true,
              title: Text(
                widget.game?.name ?? "",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
            )
          : null,
      backgroundColor: colors.blackBackground,
      body: this._game == null
          ? Container(
              color: colors.blackBackground,
              alignment: Alignment(0.0, 0.0),
              child: CircularProgressIndicator(),
            )
          : DefaultTabController(
              length: this._categories.length,
              child: NestedScrollView(
                headerSliverBuilder:
                    (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    AppBarGameView(
                      game: this._game,
                      idTag: this._game!.id,
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
                    )
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
    var tabs = <Tab>[];
    this._categories.forEach((category) => tabs.add(Tab(
          text: category.name,
        )));
    return tabs;
  }

  List<Widget> _buildViewTabs() {
    var views = <Widget>[];
    this._categories.forEach((category) => views.add(UserRunsListView(
          idGame: widget.game!.id,
          idCategory: category.id,
        )));
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
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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

  UserRunsListView({Key? key, required this.idGame, required this.idCategory}) : super(key: key);

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
    if (!this._loadingItems && !this._allLoaded && this.runs.length > 10) {
      _getRuns();
    }
  }

  Future _getRuns({bool clearList = false}) {
    this._loadingItems = true;
    var offset = clearList ? 0 : this.runs.length;
    var future = RestAPI.instance.getCategoryRuns(
        idCategory: widget.idCategory.toString(),
        offset: offset,
        onSuccess: (runs) {
          if (mounted) {
            setState(() {
              if (clearList) {
                this.runs.clear();
                this._allLoaded = false;
              }
              this.runs.addAll(runs);
              if (runs.length < AppConfig.itemsPerPage) {
                this._allLoaded = true;
              }
            });
          }
          this._loadingItems = false;
        },
        onError: (error) {
          this._loadingItems = false;
          Dialogs.showResponseErrorSnackbar(context, error);
        });
    return future;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
          child: RefreshIndicator(
        key: _refreshIndicatorKey,
        displacement: 60.0,
        child: ListView.builder(
          key: PageStorageKey<String>(widget.idCategory.toString()),
          itemCount: this.runs.length,
          padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
          itemBuilder: (BuildContext context, int index) {
            var run = this.runs[index];
            final isLastElement =
                index >= this.runs.length - 1 && !this._allLoaded;
            if (isLastElement) {
              _loadNextItems();
            }
            return GameCategoryRunItemView(run, isLastElement, (run) {
              _goToRunDetal(run);
            });
          },
        ),
        onRefresh: _onRefresh,
      )),
      decoration: BoxDecoration(color: colors.blackBackground),
    );
  }

  void _goToRunDetal(Run run) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RunDetailScreen(run: run)));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (this.runs.length == 0) {
      _refreshIndicatorKey.currentState?.show();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();
  }
}
