import 'package:flutter/material.dart';
import 'package:speed_run/config/app_config.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/logic/user.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/user_run_item_view.dart';
import 'package:speed_run/views/app_bar_user_view.dart';

class UserDetailScreen extends StatefulWidget {
  final User? user;

  const UserDetailScreen({Key? key, this.user}) : super(key: key);

  @override
  _UserDetailScreenState createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen>
    with AfterLayoutMixin<UserDetailScreen> {
  User? _user;
  final _runs = <Run>[];
  var _loadingItems = false;
  var _allLoaded = false;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    _user = widget.user;
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getUser() {
    final future = RestAPI.instance.getUser(
        id: _user!.id,
        onSuccess: (user) {
          if (mounted) {
            setState(() {
              _user = user;
            });
          }
        },
        onError: (error) {
          Dialogs.showResponseErrroAlertDialog(
              buildContext: context,
              error: error,
              onActionAlert: () {
                Navigator.of(context).pop();
              },);
        },);
    return future;
  }

  Future _getRunsUser({bool clearList = false}) {
    final offset = clearList ? 0 : _runs.length;
    final future = RestAPI.instance.getUserRuns(
        offset: offset,
        idUser: _user!.id,
        onSuccess: (runs) {
          if (mounted) {
            setState(() {
              if (clearList) {
                _runs.clear();
                _allLoaded = false;
              }
              _runs.addAll(runs);
              if (runs.length < AppConfig.itemsPerPage) {
                _allLoaded = true;
              }
            });
          }
          _loadingItems = false;
        },
        onError: (error) {
          Dialogs.showResponseErrorSnackbar(context, error);
        },);
    return future;
  }

  Future _onRefresh() {
    return _getRunsUser(clearList: true);
  }

  void _loadNextItems() {
    if (!_loadingItems && !_allLoaded && _runs.length > 10) {
      _getRunsUser();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colors.blackBackground,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              AppBarUserView(
                user: _user,
                idUser: _user!.id,
              ),
            ];
          },
          body: Center(
              child: RefreshIndicator(
            key: _refreshIndicatorKey,
            displacement: 60.0,
            onRefresh: _onRefresh,
            child: ListView.builder(
              key: PageStorageKey<String>(_user!.id),
              itemCount: _runs.length,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              itemBuilder: (BuildContext context, int index) {
                final run = _runs[index];
                final isLastElement =
                    index >= _runs.length - 1 && !_allLoaded;
                if (isLastElement) {
                  _loadNextItems();
                }
                return UserRunItemView(run, isLastElement, (run) {
                  _goToRunDetal(run);
                });
              },
            ),
          ),),
        ),);
  }

  void _goToRunDetal(Run run) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RunDetailScreen(run: run)),);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _refreshIndicatorKey.currentState?.show();
  }
}
