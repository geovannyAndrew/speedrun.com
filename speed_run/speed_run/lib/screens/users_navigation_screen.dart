
import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_user_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/view_items/run_item_view.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/view_items/user_item_view.dart';

class UsersNavigationScreen extends StatefulWidget{

  final users = List<User>();
  var _loadingItems = false;
  var querySearch = "";
  var _allLoaded = false;

  UsersNavigationScreen({Key key}):super(key:key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UsersNavigationScreenState();
  }

}

class UsersNavigationScreenState extends State<UsersNavigationScreen> with AfterLayoutMixin<UsersNavigationScreen>{

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();

  @override
  void initState(){
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
    if (!widget._allLoaded && !widget._loadingItems && widget.users.length > 10) {
      _getUsers();
    }
  }

  Future _getUsers({clearList = false}){
    widget._loadingItems = true;
    var offset = clearList ? 0 : widget.users.length;
    var future= RestAPI.instance.getUsers(
        offset: offset,
        query: widget.querySearch,
        onSuccess:(users){
          if(mounted){
            setState(() {
              if(clearList){
                this.widget.users.clear();
                widget._allLoaded = false;
              }
              if(users.length < AppConfig.itemsPerPage){
                widget._allLoaded = true;
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
            itemCount: widget.users.length,
            padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 4.0),
            itemBuilder: (BuildContext context, int index) {
              var item = widget.users[index];
              final isLastElement = index >= widget.users.length-1 && !widget._allLoaded;
              if(isLastElement){
                _loadNextItems();
              }
              return UserItemView(item,isLastElement,(user){
                _goToUserDetal(user);
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

  void _goToUserDetal(User user){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => UserDetailScreen(idUser: user.id,title: user.name)));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if(widget.users.length == 0){
      _refreshIndicatorKey.currentState.show();
    }
  }

  @override
  void dispose() {
    super.dispose();

  }

}