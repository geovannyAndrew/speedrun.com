import 'package:flutter/material.dart';
import 'package:loadmore/loadmore.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/view_items/game_category_run_item_view.dart';
import 'package:speed_run/view_items/run_item_view.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/views/screen_search_view.dart';
import 'package:speed_run/utils/storage.dart' as storage;
import 'package:speed_run/utils/dialogs.dart';

class RunsNavigationScreen extends StatefulWidget {
  final runs = <Run>[];
  var _loadingItems = false;
  String querySearch = "";

  RunsNavigationScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return RunsNavigationScreenState();
  }
}

class RunsNavigationScreenState extends State<RunsNavigationScreen>
    with AfterLayoutMixin<RunsNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    storage.getRuns((runs) {
      setState(() {
        widget.runs.addAll(runs);
      });
    });
    super.initState();
  }

  Future _onRefresh() {
    return _getRuns(clearList: true);
  }

  void onQuerySearch(String query) {
    widget.querySearch = query;
    _refreshIndicatorKey.currentState?.show();
  }

  Future<bool> _loadNextItems() async {
    if (!widget._loadingItems && widget.runs.length > 10) {
      await _getRuns();
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return true;
  }

  Future _getRuns({bool clearList = false}) {
    widget._loadingItems = true;
    final offset = clearList ? 0 : widget.runs.length;
    final future = RestAPI.instance.getRuns(
        offset: offset,
        onSuccess: (runs) {
          if (mounted) {
            setState(() {
              if (clearList) {
                widget.runs.clear();
              }
              widget.runs.addAll(runs);
            });
          }
          widget._loadingItems = false;
        },
        onError: (error) {
          widget._loadingItems = false;
          Dialogs.showResponseErrorSnackbar(context, error);
        },);
    return future;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenSearchView(
        title: "Runs",
        body: DecoratedBox(
          decoration: BoxDecoration(color: colors.blackBackground),
          child: Center(
              child: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: _onRefresh,
            child: LoadMore(
              textBuilder: DefaultLoadMoreTextBuilder.english,
              whenEmptyLoad: false,
              delegate: const DefaultLoadMoreDelegate(),
              onLoadMore: _loadNextItems,
              child: ListView.builder(
                itemCount: widget.runs.length,
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  final run = widget.runs[index];
                  return RunItemView(run, false, (run) {
                    _goToRunDetail(run);
                  });
                },
              ),
            ),
          ),),
        ),);
  }

  void _goToRunDetail(Run run) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RunDetailScreen(run: run, linkToUser: true),),);
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.runs.isEmpty) {
      _refreshIndicatorKey.currentState?.show();
    }
  }
}
