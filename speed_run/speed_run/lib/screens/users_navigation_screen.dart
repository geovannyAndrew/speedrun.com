
import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_user_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/user_item_view.dart';
import 'package:speed_run/views/screen_search_view.dart';
import 'package:loadmore/loadmore.dart';
import 'package:speed_run/utils/storage.dart' as storage;

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
  final GlobalObjectKey<ScreenSearchViewState> _screenSearchKey = GlobalObjectKey<ScreenSearchViewState>("User");

  @override
  void initState(){
    super.initState();
  }

  Future _onRefresh(){
    return _getUsers(clearList: true);
  }

  void _restoreUsers(){
    widget.querySearch = null;
    storage.getUsers((users){
      setState(() {
        widget.users.clear();
        widget.users.addAll(users);
      });
    });
  }

  void onQuerySearch(String query){
    widget.querySearch = query;
    _refreshIndicatorKey.currentState.show();
  }


  Future<bool> _loadNextItems() async{
    if (!widget._allLoaded && !widget._loadingItems && widget.users.length > 10) {
     await _getUsers();
    }
    else{
      await Future.delayed(Duration(seconds: 0, milliseconds: 100));
    }
    return true;
  }

  Future _getUsers({clearList = false}){
    widget._loadingItems = true;
    _screenSearchKey.currentState.visibleIcon = false;
    var offset = clearList ? 0 : widget.users.length;
    var future= RestAPI.instance.getUsers(
        offset: offset,
        query: widget.querySearch,
        onSuccess:(users){
          _screenSearchKey?.currentState?.visibleIcon = true;
          widget._loadingItems = false;
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

        },
        onError:(error){
          _screenSearchKey?.currentState?.visibleIcon = true;
          widget._loadingItems = false;
          Dialogs.showResponseErrorSnackbar(context, error);
        }
        );
    return future;
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenSearchView(
      key: _screenSearchKey,
      title: "Users",
      onSearch: (query){
        onQuerySearch(query);
      },
      onClose: _restoreUsers,
      querySearch: widget.querySearch,
      body: Container(
        child: Center(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            child: LoadMore(
              textBuilder: DefaultLoadMoreTextBuilder.english,
              whenEmptyLoad: false,
              delegate: DefaultLoadMoreDelegate(),
              child: ListView.builder(
                itemCount: widget.users.length,
                padding: EdgeInsets.symmetric(vertical: 4.0,horizontal: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  var item = widget.users[index];
                  return UserItemView(item,false,(user){
                    _goToUserDetal(user);
                  });
                },
              ),
              onLoadMore: _loadNextItems,
              isFinish: widget._allLoaded,
            ),
            onRefresh: _onRefresh,
          )
        ),
        decoration: BoxDecoration(
          color: colors.blackBackground
        ),
      ),
    );

  }

  void _goToUserDetal(User user){
    Navigator.push(context, MaterialPageRoute(
        builder: (context) => UserDetailScreen(user: user)));
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