// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'gamelist_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$GamelistStateTearOff {
  const _$GamelistStateTearOff();

// ignore: unused_element
  _GamelistState call({List<Game> games, String query}) {
    return _GamelistState(
      games: games,
      query: query,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $GamelistState = _$GamelistStateTearOff();

/// @nodoc
mixin _$GamelistState {
  List<Game> get games;
  String get query;

  $GamelistStateCopyWith<GamelistState> get copyWith;
}

/// @nodoc
abstract class $GamelistStateCopyWith<$Res> {
  factory $GamelistStateCopyWith(
          GamelistState value, $Res Function(GamelistState) then) =
      _$GamelistStateCopyWithImpl<$Res>;
  $Res call({List<Game> games, String query});
}

/// @nodoc
class _$GamelistStateCopyWithImpl<$Res>
    implements $GamelistStateCopyWith<$Res> {
  _$GamelistStateCopyWithImpl(this._value, this._then);

  final GamelistState _value;
  // ignore: unused_field
  final $Res Function(GamelistState) _then;

  @override
  $Res call({
    Object games = freezed,
    Object query = freezed,
  }) {
    return _then(_value.copyWith(
      games: games == freezed ? _value.games : games as List<Game>,
      query: query == freezed ? _value.query : query as String,
    ));
  }
}

/// @nodoc
abstract class _$GamelistStateCopyWith<$Res>
    implements $GamelistStateCopyWith<$Res> {
  factory _$GamelistStateCopyWith(
          _GamelistState value, $Res Function(_GamelistState) then) =
      __$GamelistStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Game> games, String query});
}

/// @nodoc
class __$GamelistStateCopyWithImpl<$Res>
    extends _$GamelistStateCopyWithImpl<$Res>
    implements _$GamelistStateCopyWith<$Res> {
  __$GamelistStateCopyWithImpl(
      _GamelistState _value, $Res Function(_GamelistState) _then)
      : super(_value, (v) => _then(v as _GamelistState));

  @override
  _GamelistState get _value => super._value as _GamelistState;

  @override
  $Res call({
    Object games = freezed,
    Object query = freezed,
  }) {
    return _then(_GamelistState(
      games: games == freezed ? _value.games : games as List<Game>,
      query: query == freezed ? _value.query : query as String,
    ));
  }
}

/// @nodoc
class _$_GamelistState implements _GamelistState {
  const _$_GamelistState({this.games, this.query});

  @override
  final List<Game> games;
  @override
  final String query;

  @override
  String toString() {
    return 'GamelistState(games: $games, query: $query)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _GamelistState &&
            (identical(other.games, games) ||
                const DeepCollectionEquality().equals(other.games, games)) &&
            (identical(other.query, query) ||
                const DeepCollectionEquality().equals(other.query, query)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(games) ^
      const DeepCollectionEquality().hash(query);

  @override
  _$GamelistStateCopyWith<_GamelistState> get copyWith =>
      __$GamelistStateCopyWithImpl<_GamelistState>(this, _$identity);
}

abstract class _GamelistState implements GamelistState {
  const factory _GamelistState({List<Game> games, String query}) =
      _$_GamelistState;

  @override
  List<Game> get games;
  @override
  String get query;
  @override
  _$GamelistStateCopyWith<_GamelistState> get copyWith;
}
