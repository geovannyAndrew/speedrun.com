// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'user_list_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$UserListStateTearOff {
  const _$UserListStateTearOff();

// ignore: unused_element
  _UserListState call({List<User> users, String query}) {
    return _UserListState(
      users: users,
      query: query,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $UserListState = _$UserListStateTearOff();

/// @nodoc
mixin _$UserListState {
  List<User> get users;
  String get query;

  $UserListStateCopyWith<UserListState> get copyWith;
}

/// @nodoc
abstract class $UserListStateCopyWith<$Res> {
  factory $UserListStateCopyWith(
          UserListState value, $Res Function(UserListState) then) =
      _$UserListStateCopyWithImpl<$Res>;
  $Res call({List<User> users, String query});
}

/// @nodoc
class _$UserListStateCopyWithImpl<$Res>
    implements $UserListStateCopyWith<$Res> {
  _$UserListStateCopyWithImpl(this._value, this._then);

  final UserListState _value;
  // ignore: unused_field
  final $Res Function(UserListState) _then;

  @override
  $Res call({
    Object users = freezed,
    Object query = freezed,
  }) {
    return _then(_value.copyWith(
      users: users == freezed ? _value.users : users as List<User>,
      query: query == freezed ? _value.query : query as String,
    ));
  }
}

/// @nodoc
abstract class _$UserListStateCopyWith<$Res>
    implements $UserListStateCopyWith<$Res> {
  factory _$UserListStateCopyWith(
          _UserListState value, $Res Function(_UserListState) then) =
      __$UserListStateCopyWithImpl<$Res>;
  @override
  $Res call({List<User> users, String query});
}

/// @nodoc
class __$UserListStateCopyWithImpl<$Res>
    extends _$UserListStateCopyWithImpl<$Res>
    implements _$UserListStateCopyWith<$Res> {
  __$UserListStateCopyWithImpl(
      _UserListState _value, $Res Function(_UserListState) _then)
      : super(_value, (v) => _then(v as _UserListState));

  @override
  _UserListState get _value => super._value as _UserListState;

  @override
  $Res call({
    Object users = freezed,
    Object query = freezed,
  }) {
    return _then(_UserListState(
      users: users == freezed ? _value.users : users as List<User>,
      query: query == freezed ? _value.query : query as String,
    ));
  }
}

/// @nodoc
class _$_UserListState implements _UserListState {
  const _$_UserListState({this.users, this.query});

  @override
  final List<User> users;
  @override
  final String query;

  @override
  String toString() {
    return 'UserListState(users: $users, query: $query)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _UserListState &&
            (identical(other.users, users) ||
                const DeepCollectionEquality().equals(other.users, users)) &&
            (identical(other.query, query) ||
                const DeepCollectionEquality().equals(other.query, query)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(users) ^
      const DeepCollectionEquality().hash(query);

  @override
  _$UserListStateCopyWith<_UserListState> get copyWith =>
      __$UserListStateCopyWithImpl<_UserListState>(this, _$identity);
}

abstract class _UserListState implements UserListState {
  const factory _UserListState({List<User> users, String query}) =
      _$_UserListState;

  @override
  List<User> get users;
  @override
  String get query;
  @override
  _$UserListStateCopyWith<_UserListState> get copyWith;
}
