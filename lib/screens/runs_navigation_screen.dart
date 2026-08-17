import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:loadmore/loadmore.dart';
import 'package:speed_run/data/feed_state.dart';
import 'package:speed_run/di/providers.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/view_items/run_item_view.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/views/screen_search_view.dart';
import 'package:speed_run/utils/dialogs.dart';

class RunsNavigationScreen extends ConsumerStatefulWidget {
  const RunsNavigationScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<RunsNavigationScreen> createState() =>
      _RunsNavigationScreenState();
}

class _RunsNavigationScreenState extends ConsumerState<RunsNavigationScreen>
    with AfterLayoutMixin<RunsNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeFeed();
    });
  }

  void _initializeFeed() {
    final feedState = ref.read(runsFeedProvider);
    if (feedState.items.isEmpty && feedState.status != FeedStatus.loading) {
      ref.read(runsFeedProvider.notifier).loadInitial();
    }
  }

  Future<void> _onRefresh() {
    return ref.read(runsFeedProvider.notifier).refresh();
  }

  Future<bool> _loadNextItems() async {
    final feedState = ref.read(runsFeedProvider);
    if (!feedState.isLoadingMore &&
        feedState.hasMore &&
        feedState.items.length > 10) {
      await ref.read(runsFeedProvider.notifier).loadMore();
    } else {
      await Future.delayed(const Duration(milliseconds: 100));
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(runsFeedProvider);

    ref.listen<FeedState<Run>>(runsFeedProvider, (previous, next) {
      if (next.status == FeedStatus.failure && next.error != null) {
        Dialogs.showSnackbar(context, next.error!);
      }
    });

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
                itemCount: feedState.items.length,
                padding:
                    const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
                itemBuilder: (BuildContext context, int index) {
                  final run = feedState.items[index];
                  return RunItemView(run, false, (run) {
                    _goToRunDetail(run);
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _goToRunDetail(Run run) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RunDetailScreen(runId: run.id, linkToUser: true),
      ),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    final feedState = ref.read(runsFeedProvider);
    if (feedState.items.isEmpty) {
      _refreshIndicatorKey.currentState?.show();
    }
  }
}
