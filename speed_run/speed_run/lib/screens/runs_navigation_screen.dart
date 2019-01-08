
import 'package:flutter/material.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/view_items/game_category_run_item_view.dart';
import 'package:speed_run/view_items/run_item_view.dart';
import 'package:speed_run/utils/colors.dart' as colors;

class RunsNavigationScreen extends StatefulWidget{

  final runs = List<Run>();
  var _loadingItems = false;
  var querySearch = "";

  RunsNavigationScreen({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RunsNavigationScreenState();
  }

}

class RunsNavigationScreenState extends State<RunsNavigationScreen> with AfterLayoutMixin<RunsNavigationScreen>{

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController;

  @override
  void initState(){
    _scrollController = ScrollController()..addListener(_loadNextItems);
    super.initState();
  }

  Future _onRefresh(){
    return _getRuns(clearList: true);
  }

  void onQuerySearch(String query){
    widget.querySearch = query;
    _refreshIndicatorKey.currentState.show();
  }

  void _loadNextItems(){
    //print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 500 && !widget._loadingItems && widget.runs.length > 10) {
      _getRuns();
    }
  }

  Future _getRuns({clearList = false}){
    widget._loadingItems = true;
    var offset = clearList ? 0 : widget.runs.length;
    var future= RestAPI.instance.getRuns(
        offset: offset,
        onSuccess:(runs){
          if(mounted){
            setState(() {
              if(clearList){
                this.widget.runs.clear();
              }
              this.widget.runs.addAll(runs);
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
          child: ListView.builder(
            controller: _scrollController,
            itemCount: widget.runs.length,
            padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 4.0),
            itemBuilder: (BuildContext context, int index) {
              var run = widget.runs[index];
              final isLastElement = index >= widget.runs.length-1;
              return RunItemView(run,isLastElement,(run){
                _goToRunDetail(run);
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

  }

  void _goToRunDetail(Run run){
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RunDetailScreen(idRun: run.id)));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if(widget.runs.length == 0){
      _refreshIndicatorKey.currentState.show();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();

  }

}