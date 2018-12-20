
import 'package:flutter/material.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/utils/after_layout.dart';

class RunsNavigationScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RunsNavigationScreenState();
  }

}

class _RunsNavigationScreenState extends State<RunsNavigationScreen> with AfterLayoutMixin<RunsNavigationScreen>{

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  var runs = List<Run>();

  Future getRuns(){
    var future= RestAPI.instance.getRuns((runs){
      if(mounted){
        setState(() {
          this.runs = runs;
        });
      }
    });
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
            itemCount: runs.length,
            padding: EdgeInsets.all(8.0),
            itemExtent: 20.0,
            itemBuilder: (BuildContext context, int index) {
              var run = runs[index];
              return Text('entry ${run.date}');
            },
          ),
          onRefresh: getRuns,
        )
      ),
      decoration: BoxDecoration(
        color: Colors.blue
      ),
    );

  }

  @override
  void afterFirstLayout(BuildContext context) {
    _refreshIndicatorKey.currentState.show();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

  }

}