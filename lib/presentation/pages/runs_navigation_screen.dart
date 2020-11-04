import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import 'package:speed_run/injection.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/network/rest_api.dart';
import 'package:speed_run/presentation/pages/detail_run_screen.dart';
import 'package:speed_run/presentation/runs/runs_list/bloc/runslist_bloc.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/view_items/run_item_view.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/presentation/widgets/screen_search_view.dart';
import 'package:speed_run/utils/storage.dart' as storage;
import 'package:speed_run/utils/dialogs.dart';

class RunsNavigationScreen extends StatefulWidget {
  final runs = List<Run>();
  var _loadingItems = false;
  var querySearch = "";

  RunsNavigationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RunsNavigationScreenState();
  }
}

class RunsNavigationScreenState extends State<RunsNavigationScreen>
    with AfterLayoutMixin<RunsNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    storage.getRuns((runs) {
      setState(() {
        widget.runs.addAll(runs);
      });
    });
    super.initState();
  }

  void onQuerySearch(String query) {
    widget.querySearch = query;
    _refreshIndicatorKey.currentState.show();
  }

  Future<bool> _loadNextItems() async {
    //print(_scrollController.position.extentAfter);
    if (!widget._loadingItems && widget.runs.length > 10) {
      await _getRuns();
    } else {
      await Future.delayed(Duration(seconds: 0, milliseconds: 100));
    }
    return true;
  }

  Future _getRuns({bool clearList = false}) {
    widget._loadingItems = true;
    var offset = clearList ? 0 : widget.runs.length;
    var future = RestAPI.instance.getRuns(
        offset: offset,
        onSuccess: (runs) {
          if (mounted) {
            setState(() {
              if (clearList) {
                this.widget.runs.clear();
              }
              this.widget.runs.addAll(runs);
            });
          }
          widget._loadingItems = false;
        },
        onError: (error) {
          widget._loadingItems = false;
          Dialogs.showResponseErrorSnackbar(context, error);
        });
    return future;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) =>
                getIt<RunslistBloc>()..add(const RunslistEvent.started()))
      ],
      child: BlocBuilder<RunslistBloc, RunslistState>(
        builder: (context, state) {
          return ScreenSearchView(
              title:
                  state == RunslistState.refreshing() ? "Refreshing" : "Runs",
              body: Container(
                child: Center(
                    child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  child: LoadMore(
                    textBuilder: DefaultLoadMoreTextBuilder.english,
                    whenEmptyLoad: false,
                    delegate: DefaultLoadMoreDelegate(),
                    child: ListView.builder(
                      itemCount: widget.runs.length,
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                      itemBuilder: (BuildContext context, int index) {
                        var run = widget.runs[index];
                        return RunItemView(run, false, (run) {
                          context
                              .bloc<RunslistBloc>()
                              .add(const RunslistEvent.started());
                        });
                      },
                    ),
                    onLoadMore: _loadNextItems,
                    isFinish: false,
                  ),
                  onRefresh: context.bloc<RunslistBloc>().refreshRuns,
                )),
                decoration: BoxDecoration(color: colors.blackBackground),
              ));
        },
      ),
    );
  }

  void _goToRunDetail(Run run) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => RunDetailScreen(run: run, linkToUser: true)));
  }

  @override
  void afterFirstLayout(BuildContext context) {
    if (widget.runs.length == 0) {
      _refreshIndicatorKey.currentState.show();
    }
  }
}
