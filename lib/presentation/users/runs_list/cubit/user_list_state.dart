part of 'user_list_cubit.dart';

@freezed
abstract class UserListState with _$UserListState {
  const factory UserListState({List<User> users, String query}) =
      _UserListState;
  factory UserListState.initial() => UserListState(users: List.empty());
}
