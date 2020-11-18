import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:speed_run/data/models/user.dart';
import 'package:speed_run/data/repositories/users_repository.dart';

part 'user_list_state.dart';
part 'user_list_cubit.freezed.dart';

@LazySingleton()
class UserListCubit extends Cubit<UserListState> {
  final IUsersRepository _usersRepository;
  var _offset = 0;
  var _allLoaded = false;
  var _loading = false;
  UserListCubit(this._usersRepository) : super(UserListState.initial());

  bool get userListIsEmpty => state.users.isEmpty;

  Future refreshUsers() async {
    _offset = 0;
    print("Query users: ${state.query}");
    final usersRemote =
        await _usersRepository.getUsers(offset: _offset, query: state.query);
    usersRemote.fold((l) {
      print("usersRemote l");
    }, (r) {
      print("usersRemote ${r.length}");
      emit(state.copyWith(users: r));
    });
  }

  Future refreshUsersFromStorage() async {
    setQuery(null);
    final usersStorage = await _usersRepository.getUsers(
        offset: _offset, query: state.query, fromStorage: true);
    usersStorage.fold((l) {
      print("usersStorage l");
      emit(UserListState.initial());
    }, (r) {
      print("usersStorage r: ${r.length}");
      emit(state.copyWith(users: r));
    });
  }

  Future<bool> loadMoreUsers() async {
    if (_loading || _allLoaded || state.users.isEmpty) return false;
    _loading = true;
    _offset = state.users.length;
    final users =
        await _usersRepository.getUsers(offset: _offset, query: state.query);
    users.fold((l) {
      print("loadMoreUsers l");
      _loading = false;
    }, (r) {
      print("loadMoreUsers r: ${r.length}");
      emit(state.copyWith(users: [...state.users, ...r]));
      _loading = false;
    });
    return true;
  }

  void setQuery(String query) {
    emit(state.copyWith(query: query));
  }
}
