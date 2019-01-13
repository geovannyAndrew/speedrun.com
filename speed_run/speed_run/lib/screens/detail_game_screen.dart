import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/category.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/view_items/game_category_run_item_view.dart';
import 'package:speed_run/views/app_bar_game_view.dart';
import 'package:speed_run/utils/after_layout.dart';

class GameDetailScreen extends StatefulWidget {

  final Game game;
  //var tabs = List<Tab>();

  GameDetailScreen({Key key, this.game}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  _GameDetailScreenState createState() => _GameDetailScreenState();
}

class _GameDetailScreenState extends State<GameDetailScreen> with SingleTickerProviderStateMixin {

  Game _game;
  var _categories = List<Category>();

  @override
  void initState() {
    super.initState();
   // _game = widget.game;
    _getCategories();
  }

  Future _getGame(){
    var future= RestAPI.instance.getGame(
      id: widget.game.id,
      onSuccess:(game){
        if(mounted){
          setState(() {
            this._game = game;
          });
        }
      },
      onError:(error){

      }
    );
    return future;
  }

  Future _getCategories(){
    var future= RestAPI.instance.getGameCategories(
        idGame: widget.game.id,
        onSuccess:(categories){
          setState(() {
            this._categories = categories;
            this._game = widget.game;
          });
        },
        onError:(error){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
              return AlertDialog(
                title: Text("Error"),
                content: Text("Error to get categories"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: (){
                        Navigator.of(context).pop();
                        Navigator.of(this.context).pop();
                      },
                      child: Text(
                          "Ok"
                      ))
                ],
              );
            }
          );
        }
    );
    return future;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: this._game == null ?
        AppBar(
          centerTitle: true,
          title: Text(
            widget.game.name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0
            ),
          ),
        ):
        null,
      backgroundColor: colors.blackBackground,
      body:this._game == null ?
        Container(
          color: colors.blackBackground,
          alignment: Alignment(0.0, 0.0),
          child: CircularProgressIndicator(),
        ) :
        DefaultTabController(
          length: this._categories.length,
          child: NestedScrollView(
            headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                AppBarGameView(
                  game: this._game,
                  idTag: this._game.id,
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

  List<Tab> _buildTabs(){
    var tabs = List<Tab>();
    this._categories?.forEach((category)=>
      tabs.add(Tab(
        text: category.name,
      ))
    );
    return tabs;
  }

  List<Widget> _buildViewTabs(){
    var views = List<Widget>();
    this._categories?.forEach((category)=>
        views.add(UserRunsListView(
          idGame: widget.game.id,
          idCategory: category.id,
        ))
    );
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
    return new Container(
      color: colors.blackDark,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

class UserRunsListView extends StatefulWidget{

  final idGame;
  final idCategory;


  UserRunsListView({Key key, this.idGame, this.idCategory}) : super(key: key);


  @override
  _UserRunsListViewState createState() => _UserRunsListViewState();

}

class _UserRunsListViewState extends State<UserRunsListView> with AfterLayoutMixin<UserRunsListView>{

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController;
  final runs = List<Run>();
  var _loadingItems = false;
  var _allLoaded = false;

  @override
  void initState() {
    _scrollController = ScrollController()..addListener(_loadNextItems);
    super.initState();
  }

  Future _onRefresh(){
    return _getRuns(clearList: true);
  }

  void _loadNextItems(){
    //print(_scrollController.position.extentAfter);
    if (!this._loadingItems && !this._allLoaded && this.runs.length > 10) {
      _getRuns();
    }
  }

  Future _getRuns({clearList = false}){
    this._loadingItems = true;
    var offset = clearList ? 0 : this.runs.length;
    var future= RestAPI.instance.getCategoryRuns(
        idCategory: widget.idCategory,
        offset: offset,
        onSuccess:(runs){
          if(mounted){
            setState(() {
              if(clearList){
                this.runs.clear();
                this._allLoaded = false;
              }
              this.runs.addAll(runs);
              if(runs.length < AppConfig.itemsPerPage){
                this._allLoaded = true;
              }
            });
          }
          this._loadingItems = false;
        },
        onError:(error){
          this._loadingItems = false;
        }
    );
    return future;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Center(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            displacement: 60.0,
            child: ListView.builder(
              key: PageStorageKey<String>(widget.idCategory),
              itemCount: this.runs.length,
              padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 4.0),
              itemBuilder: (BuildContext context, int index) {
                var run = this.runs[index];
                final isLastElement = index >= this.runs.length-1 && !this._allLoaded;
                if(isLastElement){
                  _loadNextItems();
                }
                return GameCategoryRunItemView(run,isLastElement,(run){
                  _goToRunDetal(run);
                });
              },
            ),
            onRefresh: _onRefresh,
          )
      ),
      decoration: BoxDecoration(
          color: colors.blackBackground
      ),
    );
    /*return RefreshIndicator(
      key: _refreshIndicatorKey,
      displacement: 90.0,
      onRefresh: _onRefresh,
      child: CustomScrollView(
        key: PageStorageKey<String>(widget.idCategory),
        slivers: <Widget>[
          SliverOverlapInjector(
          // This is the flip side of the SliverOverlapAbsorber above.
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context,index){
                var run = this.runs[index];
                final isLastElement = index >= this.runs.length-1;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0,vertical: 0.0),
                  child: GameCategoryRunItemView(run,isLastElement,(run){
                    _goToRunDetal();
                  }),
                );
              },
            childCount:this.runs.length,
          )
          )
        ],
      ),
    );*/
  }

  void _goToRunDetal(Run run){
    //Navigator.pushNamed(context, "/run_detail");
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RunDetailScreen(run: run)));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if(this.runs.length == 0){
      _refreshIndicatorKey.currentState.show();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();
  }



}
