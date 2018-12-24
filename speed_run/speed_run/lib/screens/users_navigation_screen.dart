
import 'package:flutter/material.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/view_items/item_view_run.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/view_items/item_view_user.dart';

class UsersNavigationScreen extends StatefulWidget{

  final users = List<User>();
  var _loadingItems = false;
  var querySearch = "";

  UsersNavigationScreen({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UsersNavigationScreenState();
  }

}

class UsersNavigationScreenState extends State<UsersNavigationScreen> with AfterLayoutMixin<UsersNavigationScreen>{

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  ScrollController _scrollController;

  @override
  void initState(){
    _scrollController = ScrollController()..addListener(_loadNextItems);
    super.initState();
  }

  Future _onRefresh(){
    return _getUsers(clearList: true);
  }

  void onQuerySearch(String query){
    widget.querySearch = query;
    _refreshIndicatorKey.currentState.show();
  }

  void _loadNextItems(){
    if (_scrollController.position.extentAfter < 500 && !widget._loadingItems && widget.users.length > 10) {
      _getUsers();
    }
  }

  Future _getUsers({clearList = false}){
    widget._loadingItems = true;
    var future= RestAPI.instance.getUsers(
        offset: widget.users.length,
        onSuccess:(users){
          if(mounted){
            setState(() {
              if(clearList){
                this.widget.users.clear();
              }
              this.widget.users.addAll(users);
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
            itemCount: widget.users.length,
            padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 4.0),
            itemBuilder: (BuildContext context, int index) {
              var item = widget.users[index];
              final isLastElement = index >= widget.users.length-1;
              return UserItemView(item,isLastElement);
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
    if(widget.users.length == 0){
      _refreshIndicatorKey.currentState.show();
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    super.dispose();

  }

}