
import 'package:flutter/material.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_game_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/view_items/game_item_view.dart';

class GamesNavigationScreen extends StatefulWidget{

  var games = List<Game>();
  var _loadingItems = false;
  var _allLoaded = false;

  GamesNavigationScreen({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return GamesNavigationScreenState();
  }

}

class GamesNavigationScreenState extends State<GamesNavigationScreen> with AfterLayoutMixin<GamesNavigationScreen>{

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController;
  String querySearch;

  void onQuerySearch(String query){
    querySearch = query;
    _refreshIndicatorKey.currentState.show();
  }

  @override
  void initState(){
    _scrollController = ScrollController()..addListener(_loadNextItems);
    super.initState();
  }

  Future _onRefresh(){
    return _getGames(clearList: true);
  }

  void _loadNextItems(){
    //print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 500 && !widget._allLoaded && !widget._loadingItems && widget.games.length > 10) {
      _getGames();
    }
  }

  Future _getGames({clearList = false}){
    widget._loadingItems = true;
    int offset = clearList ? 0 : widget.games.length;
    var future= RestAPI.instance.getGames(
        offset: offset,
        query: querySearch,
        onSuccess:(games){
          if(mounted){
            setState(() {
              if(clearList){
                this.widget.games.clear();
                widget._allLoaded = false;
              }
              this.widget.games.addAll(games);
              if(games.length < 20){
                widget._allLoaded = true;
              }
            });
          }
          widget._loadingItems = false;
        },
        onError:(error){
          widget._loadingItems = false;
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
          child: OrientationBuilder(
              builder: (context,orientation){
                return GridView.builder(
                  controller: _scrollController,
                  itemCount: widget.games.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: MediaQuery.of(context).orientation == Orientation.landscape ? 4 : 2,
                    childAspectRatio: 0.6,
                  ),
                  padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 4.0),
                  itemBuilder: (BuildContext context, int index) {
                    var item = widget.games[index];
                    final isLastElement = index >= widget.games.length-1;
                    return GameItemView(item,isLastElement,(game){
                      _goToGameDetal(game);
                    });
                  },
                );
              }
          ),
          onRefresh: _onRefresh,
        )
      ),
      decoration: BoxDecoration(
        color: colors.blackBackground
      ),
    );

  }


  @override
  void afterFirstLayout(BuildContext context) {
    if(widget.games.length == 0){
      _refreshIndicatorKey.currentState.show();
    }
  }

  void _goToGameDetal(Game game){
    //Navigator.pushNamed(context, "/run_detail");
    Navigator.push(context, MaterialPageRoute(builder: (context) => GameDetailScreen(idGame: game.id,title: game.name)));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();

  }

}