import 'package:flutter/material.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:speed_run/presentation/pages/detail_user_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/view_items/user_item_view.dart';
import 'package:speed_run/presentation/widgets/screen_search_view.dart';
import 'package:loadmore/loadmore.dart';
import 'package:speed_run/utils/storage.dart' as storage;

class UsersNavigationScreen extends StatefulWidget {
  final users = List<User>();
  var _loadingItems = false;
  var querySearch = "";
  var _allLoaded = false;

  UsersNavigationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UsersNavigationScreenState();
  }
}

class UsersNavigationScreenState extends State<UsersNavigationScreen>
    with AfterLayoutMixin<UsersNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final GlobalObjectKey<ScreenSearchViewState> _screenSearchKey =
      GlobalObjectKey<ScreenSearchViewState>("User");

  @override
  void initState() {
    super.initState();
  }

  void _restoreUsers() {
    widget.querySearch = null;
    storage.getUsers((users) {
      setState(() {
        widget.users.clear();
      });
    });
  }

  void onQuerySearch(String query) {
    widget.querySearch = query;
    _refreshIndicatorKey.currentState.show();
  }

  Future<bool> _loadNextItems() async {
    return true;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ScreenSearchView(
      key: _screenSearchKey,
      title: "Users",
      onSearch: (query) {
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
              padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              itemBuilder: (BuildContext context, int index) {
                var item = widget.users[index];
                return UserItemView(item, false, (user) {
                  _goToUserDetal(user);
                });
              },
            ),
            onLoadMore: _loadNextItems,
            isFinish: widget._allLoaded,
          ),
          onRefresh: null,
        )),
        decoration: BoxDecoration(color: colors.blackBackground),
      ),
    );
  }

  void _goToUserDetal(User user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.users.length == 0) {
      _refreshIndicatorKey.currentState.show();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
