import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speed_run/data/feed_state.dart';
import 'package:speed_run/di/providers.dart';
import 'package:speed_run/logic/run.dart';
import 'package:speed_run/screens/detail_run_screen.dart';
import 'package:speed_run/utils/after_layout.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/utils/dialogs.dart';
import 'package:speed_run/view_items/user_run_item_view.dart';
import 'package:speed_run/views/app_bar_user_view.dart';

class UserDetailScreen extends ConsumerStatefulWidget {
  final String userId;

  const UserDetailScreen({
    Key? key,
    required this.userId,
  }) : super(key: key);

  @override
  ConsumerState<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends ConsumerState<UserDetailScreen>
    with AfterLayoutMixin<UserDetailScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_loadNextItems);
    Future.microtask(() {
      ref.read(userDetailProvider(widget.userId));
      ref.read(userRunsFeedProvider(widget.userId).notifier).loadInitial();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadNextItems);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh() {
    return ref.read(userRunsFeedProvider(widget.userId).notifier).refresh();
  }

  void _loadNextItems() {
    final state = ref.read(userRunsFeedProvider(widget.userId));
    if (state.status != FeedStatus.loading &&
        state.hasMore &&
        state.items.length > 10) {
      ref.read(userRunsFeedProvider(widget.userId).notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final userAsync = ref.watch(userDetailProvider(widget.userId));
    final feedState = ref.watch(userRunsFeedProvider(widget.userId));

    ref.listen<AsyncValue<dynamic>>(userDetailProvider(widget.userId),
        (prev, next) {
      if (next.hasError) {
        Dialogs.showSnackbar(context, next.error.toString());
      }
    });

    ref.listen<FeedState<Run>>(userRunsFeedProvider(widget.userId),
        (prev, next) {
      if (next.error != null && prev?.error != next.error) {
        Dialogs.showSnackbar(context, next.error!);
      }
    });

    return userAsync.when(
      loading: () => _buildScaffold(null, feedState),
      error: (error, _) => _buildScaffold(null, feedState),
      data: (user) => _buildScaffold(user, feedState),
    );
  }

  Widget _buildScaffold(dynamic user, FeedState<Run> feedState) {
    if (user == null) {
      return Scaffold(
        backgroundColor: colors.blackBackground,
        body: Container(
          color: colors.blackBackground,
          alignment: const Alignment(0.0, 0.0),
          child: const CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: colors.blackBackground,
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            AppBarUserView(
              user: user,
              idUser: widget.userId,
            ),
          ];
        },
        body: Center(
          child: RefreshIndicator(
            key: _refreshIndicatorKey,
            displacement: 60.0,
            onRefresh: _onRefresh,
            child: ListView.builder(
              key: PageStorageKey<String>(widget.userId),
              itemCount: feedState.items.length,
              padding:
                  const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
              itemBuilder: (BuildContext context, int index) {
                final run = feedState.items[index];
                final isLastElement = feedState.items.length > 10 &&
                    index >= feedState.items.length - 1 &&
                    feedState.hasMore;
                if (isLastElement) {
                  Future.microtask(() {
                    ref
                        .read(userRunsFeedProvider(widget.userId).notifier)
                        .loadMore();
                  });
                }
                return UserRunItemView(run, isLastElement, (run) {
                  _goToRunDetail(run);
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  void _goToRunDetail(Run run) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RunDetailScreen(runId: run.id)),
    );
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _refreshIndicatorKey.currentState?.show();
  }
}
