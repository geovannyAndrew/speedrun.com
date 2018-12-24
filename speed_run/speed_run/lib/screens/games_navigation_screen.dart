
import 'package:flutter/material.dart';
import 'package:speed_run/logic/game.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/view_items/item_view_game.dart';

class GamesNavigationScreen extends StatefulWidget{

  var games = List<Game>();
  var _loadingItems = false;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _GamesNavigationScreenState();
  }

}

class _GamesNavigationScreenState extends State<GamesNavigationScreen> with AfterLayoutMixin<GamesNavigationScreen>{

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController;

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
    if (_scrollController.position.extentAfter < 500 && !widget._loadingItems && widget.games.length > 10) {
      _getGames();
    }
  }

  Future _getGames({clearList = false}){
    widget._loadingItems = true;
    var future= RestAPI.instance.getGames(
        offset: widget.games.length,
        onSuccess:(games){
          if(mounted){
            setState(() {
              if(clearList){
                this.widget.games.clear();
              }
              this.widget.games.addAll(games);
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
                    return GameItemView(item,isLastElement);
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

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();

  }

}