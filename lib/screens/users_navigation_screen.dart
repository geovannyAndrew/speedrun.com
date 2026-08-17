import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/response_error.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_user_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/utils/storage.dart' as storage;
import 'package:speed_run/view_items/user_item_view.dart';
import 'package:speed_run/views/screen_search_view.dart';

class UsersNavigationScreen extends StatefulWidget {
  final users = <User>[];
  var _loadingItems = false;
  String querySearch = "";
  var _allLoaded = false;

  UsersNavigationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return UsersNavigationScreenState();
  }
}

class UsersNavigationScreenState extends State<UsersNavigationScreen>
    with AfterLayoutMixin<UsersNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  final GlobalObjectKey<ScreenSearchViewState> _screenSearchKey =
      const GlobalObjectKey<ScreenSearchViewState>("User");


  Future _onRefresh() {
    return _getUsers(clearList: true);
  }

  void _restoreUsers() {
    widget.querySearch = "";
    storage.getUsers((users) {
      setState(() {
        widget.users.clear();
        widget.users.addAll(users);
      });
    });
  }

  void onQuerySearch(String query) {
    widget.querySearch = query;
    _refreshIndicatorKey.currentState?.show();
  }

  Future<bool> _loadNextItems() async {
    if (!widget._allLoaded &&
        !widget._loadingItems &&
        widget.users.length > 10) {
      await _getUsers();
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return true;
  }

  Future _getUsers({bool clearList = false}) {
    widget._loadingItems = true;
    _screenSearchKey.currentState?.visibleIcon = false;
    final offset = clearList ? 0 : widget.users.length;
    final future = RestAPI.instance.getUsers(
        offset: offset,
        query: widget.querySearch,
        onSuccess: (users) {
          _screenSearchKey.currentState?.visibleIcon = true;
          widget._loadingItems = false;
          if (mounted) {
            setState(() {
              if (clearList) {
                widget.users.clear();
                widget._allLoaded = false;
              }
              if (users.length < AppConfig.itemsPerPage) {
                widget._allLoaded = true;
              }
              widget.users.addAll(users);
            });
          }
        },
        onError: (error) {
          _screenSearchKey.currentState?.visibleIcon = true;
          widget._loadingItems = false;
          _handleStatusError(error);
        },);
    return future;
  }

  void _handleStatusError(ResponseError error) {
    switch (error.statusCode) {
      case 400:
        Dialogs.showSnackbar(context,
            "Please make sure to use 3 or more characters in the search",);
        break;
      default:
        Dialogs.showResponseErrorSnackbar(context, error);
    }
    Dialogs.showResponseErrorSnackbar(context, error);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSearchView(
      key: _screenSearchKey,
      title: "Users",
      onSearch: (query) {
        onQuerySearch(query);
      },
      onClose: _restoreUsers,
      querySearch: widget.querySearch,
      body: DecoratedBox(
        decoration: BoxDecoration(color: colors.blackBackground),
        child: Center(
            child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _onRefresh,
          child: LoadMore(
            textBuilder: DefaultLoadMoreTextBuilder.english,
            whenEmptyLoad: false,
            onLoadMore: _loadNextItems,
            isFinish: widget._allLoaded,
            child: ListView.builder(
              itemCount: widget.users.length,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              itemBuilder: (BuildContext context, int index) {
                final item = widget.users[index];
                return UserItemView(item, false, (user) {
                  _goToUserDetal(user);
                });
              },
            ),
          ),
        ),),
      ),
    );
  }

  void _goToUserDetal(User user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)),);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.users.isEmpty) {
      _refreshIndicatorKey.currentState?.show();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }
}
