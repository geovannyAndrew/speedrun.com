
import 'package:flutter/material.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/view_items/item_view_run.dart';
import 'package:speed_run/utils/colors.dart' as colors;

class RunsNavigationScreen extends StatefulWidget{

  var runs = List<Run>();
  var _loadingItems = false;

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RunsNavigationScreenState();
  }

}

class _RunsNavigationScreenState extends State<RunsNavigationScreen> with AfterLayoutMixin<RunsNavigationScreen>{

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

  void _loadNextItems(){
    //print(_scrollController.position.extentAfter);
    if (_scrollController.position.extentAfter < 500 && !widget._loadingItems && widget.runs.length > 10) {
      _getRuns();
    }
  }

  Future _getRuns({clearList = false}){
    widget._loadingItems = true;
    var future= RestAPI.instance.getRuns(
        offset: widget.runs.length,
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
            padding: EdgeInsets.symmetric(vertical: 8.0,horizontal: 4.0),
            itemBuilder: (BuildContext context, int index) {
              var run = widget.runs[index];
              final isLastElement = index >= widget.runs.length-1;
              return RunItemView(run,isLastElement);
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