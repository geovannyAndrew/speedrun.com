import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loadmore/loadmore.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/injection.dart';
import 'package:speed_run/presentation/pages/detail_run_screen.dart';
import 'package:speed_run/presentation/runs/runs_list/cubit/runlist_cubit.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/view_items/run_item_view.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/presentation/widgets/screen_search_view.dart';

class RunsNavigationScreen extends StatefulWidget {
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

  void onQuerySearch(String query) {
    widget.querySearch = query;
    _refreshIndicatorKey.currentState.show();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => getIt<RunlistCubit>())],
      child: BlocBuilder<RunlistCubit, RunlistState>(
        builder: (context, state) {
          return ScreenSearchView(
              title: "Runs",
              body: Container(
                child: Center(
                    child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  child: LoadMore(
                    textBuilder: DefaultLoadMoreTextBuilder.english,
                    whenEmptyLoad: false,
                    delegate: DefaultLoadMoreDelegate(),
                    child: ListView.builder(
                      itemCount: state.runs.length,
                      padding:
                          EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                      itemBuilder: (BuildContext context, int index) {
                        var run = state.runs[index];
                        return RunItemView(run, false, (run) {
                          _goToRunDetail(run);
                        });
                      },
                    ),
                    onLoadMore: context.bloc<RunlistCubit>().loadMoreRuns,
                    isFinish: false,
                  ),
                  onRefresh: context.bloc<RunlistCubit>().refreshRuns,
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
    if (context.bloc<RunlistCubit>().runListIsEmpty) {
      _refreshIndicatorKey.currentState.show();
    }
  }
}
