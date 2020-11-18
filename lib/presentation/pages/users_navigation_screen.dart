import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:speed_run/presentation/pages/detail_user_screen.dart';
import 'package:speed_run/presentation/users/runs_list/cubit/user_list_cubit.dart';
import 'package:speed_run/utils/colors.dart' as colors;
import 'package:speed_run/view_items/user_item_view.dart';
import 'package:speed_run/presentation/widgets/screen_search_view.dart';
import 'package:loadmore/loadmore.dart';

import '../../injection.dart';

class UsersNavigationScreen extends StatefulWidget {
  UsersNavigationScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return UsersNavigationScreenState();
  }
}

class UsersNavigationScreenState extends State<UsersNavigationScreen> {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();
  final GlobalObjectKey<ScreenSearchViewState> _screenSearchKey =
      GlobalObjectKey<ScreenSearchViewState>("User");
  UserListCubit _userlistCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      //if (context.watch<RunlistCubit>().runListIsEmpty) {
      _refreshIndicatorKey.currentState.show();
      //}
    });
  }

  void onQuerySearch(String query) {
    _userlistCubit.setQuery(query);
    _refreshIndicatorKey.currentState.show();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            _userlistCubit = getIt<UserListCubit>();
            return _userlistCubit;
          })
        ],
        child: BlocConsumer<UserListCubit, UserListState>(
            builder: (context, state) {
              return ScreenSearchView(
                key: _screenSearchKey,
                title: "Users",
                onSearch: (query) {
                  onQuerySearch(query);
                },
                onClose: context.watch<UserListCubit>().refreshUsersFromStorage,
                querySearch: state.query,
                body: Container(
                  decoration: BoxDecoration(color: colors.blackBackground),
                  child: Center(
                      child: RefreshIndicator(
                    key: _refreshIndicatorKey,
                    onRefresh: _userlistCubit.refreshUsers,
                    child: LoadMore(
                      textBuilder: DefaultLoadMoreTextBuilder.english,
                      whenEmptyLoad: false,
                      delegate: DefaultLoadMoreDelegate(),
                      child: ListView.builder(
                        itemCount: state.users.length,
                        padding: EdgeInsets.symmetric(
                            vertical: 4.0, horizontal: 4.0),
                        itemBuilder: (BuildContext context, int index) {
                          var item = state.users[index];
                          return UserItemView(item, false, (user) {
                            _goToUserDetal(user);
                          });
                        },
                      ),
                      onLoadMore: context.watch<UserListCubit>().loadMoreUsers,
                      isFinish: false,
                    ),
                  )),
                ),
              );
            },
            listener: (context, state) {}));
  }

  void _goToUserDetal(User user) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserDetailScreen(user: user)));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
