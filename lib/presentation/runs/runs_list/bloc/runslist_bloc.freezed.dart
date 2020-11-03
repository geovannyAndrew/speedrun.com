// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'runslist_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$RunslistEventTearOff {
  const _$RunslistEventTearOff();

// ignore: unused_element
  _Started started() {
    return const _Started();
  }
}

/// @nodoc
// ignore: unused_element
const $RunslistEvent = _$RunslistEventTearOff();

/// @nodoc
mixin _$RunslistEvent {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result started(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result started(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result started(_Started value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result started(_Started value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $RunslistEventCopyWith<$Res> {
  factory $RunslistEventCopyWith(
          RunslistEvent value, $Res Function(RunslistEvent) then) =
      _$RunslistEventCopyWithImpl<$Res>;
}

/// @nodoc
class _$RunslistEventCopyWithImpl<$Res>
    implements $RunslistEventCopyWith<$Res> {
  _$RunslistEventCopyWithImpl(this._value, this._then);

  final RunslistEvent _value;
  // ignore: unused_field
  final $Res Function(RunslistEvent) _then;
}

/// @nodoc
abstract class _$StartedCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) then) =
      __$StartedCopyWithImpl<$Res>;
}

/// @nodoc
class __$StartedCopyWithImpl<$Res> extends _$RunslistEventCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(_Started _value, $Res Function(_Started) _then)
      : super(_value, (v) => _then(v as _Started));

  @override
  _Started get _value => super._value as _Started;
}

/// @nodoc
class _$_Started implements _Started {
  const _$_Started();

  @override
  String toString() {
    return 'RunslistEvent.started()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Started);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result started(),
  }) {
    assert(started != null);
    return started();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result started(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (started != null) {
      return started();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result started(_Started value),
  }) {
    assert(started != null);
    return started(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result started(_Started value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (started != null) {
      return started(this);
    }
    return orElse();
  }
}

abstract class _Started implements RunslistEvent {
  const factory _Started() = _$_Started;
}

/// @nodoc
class _$RunslistStateTearOff {
  const _$RunslistStateTearOff();

// ignore: unused_element
  _Initial initial() {
    return const _Initial();
  }

// ignore: unused_element
  _Refreshing refreshing() {
    return const _Refreshing();
  }

// ignore: unused_element
  _LoadingMore loadingMore() {
    return const _LoadingMore();
  }

// ignore: unused_element
  _LoadedRuns loadedRuns(Either<SpeedRunFailure, List<Run>> runs) {
    return _LoadedRuns(
      runs,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $RunslistState = _$RunslistStateTearOff();

/// @nodoc
mixin _$RunslistState {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result refreshing(),
    @required Result loadingMore(),
    @required Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result refreshing(),
    Result loadingMore(),
    Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result refreshing(_Refreshing value),
    @required Result loadingMore(_LoadingMore value),
    @required Result loadedRuns(_LoadedRuns value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result refreshing(_Refreshing value),
    Result loadingMore(_LoadingMore value),
    Result loadedRuns(_LoadedRuns value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $RunslistStateCopyWith<$Res> {
  factory $RunslistStateCopyWith(
          RunslistState value, $Res Function(RunslistState) then) =
      _$RunslistStateCopyWithImpl<$Res>;
}

/// @nodoc
class _$RunslistStateCopyWithImpl<$Res>
    implements $RunslistStateCopyWith<$Res> {
  _$RunslistStateCopyWithImpl(this._value, this._then);

  final RunslistState _value;
  // ignore: unused_field
  final $Res Function(RunslistState) _then;
}

/// @nodoc
abstract class _$InitialCopyWith<$Res> {
  factory _$InitialCopyWith(_Initial value, $Res Function(_Initial) then) =
      __$InitialCopyWithImpl<$Res>;
}

/// @nodoc
class __$InitialCopyWithImpl<$Res> extends _$RunslistStateCopyWithImpl<$Res>
    implements _$InitialCopyWith<$Res> {
  __$InitialCopyWithImpl(_Initial _value, $Res Function(_Initial) _then)
      : super(_value, (v) => _then(v as _Initial));

  @override
  _Initial get _value => super._value as _Initial;
}

/// @nodoc
class _$_Initial implements _Initial {
  const _$_Initial();

  @override
  String toString() {
    return 'RunslistState.initial()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Initial);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result refreshing(),
    @required Result loadingMore(),
    @required Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
  }) {
    assert(initial != null);
    assert(refreshing != null);
    assert(loadingMore != null);
    assert(loadedRuns != null);
    return initial();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result refreshing(),
    Result loadingMore(),
    Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result refreshing(_Refreshing value),
    @required Result loadingMore(_LoadingMore value),
    @required Result loadedRuns(_LoadedRuns value),
  }) {
    assert(initial != null);
    assert(refreshing != null);
    assert(loadingMore != null);
    assert(loadedRuns != null);
    return initial(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result refreshing(_Refreshing value),
    Result loadingMore(_LoadingMore value),
    Result loadedRuns(_LoadedRuns value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class _Initial implements RunslistState {
  const factory _Initial() = _$_Initial;
}

/// @nodoc
abstract class _$RefreshingCopyWith<$Res> {
  factory _$RefreshingCopyWith(
          _Refreshing value, $Res Function(_Refreshing) then) =
      __$RefreshingCopyWithImpl<$Res>;
}

/// @nodoc
class __$RefreshingCopyWithImpl<$Res> extends _$RunslistStateCopyWithImpl<$Res>
    implements _$RefreshingCopyWith<$Res> {
  __$RefreshingCopyWithImpl(
      _Refreshing _value, $Res Function(_Refreshing) _then)
      : super(_value, (v) => _then(v as _Refreshing));

  @override
  _Refreshing get _value => super._value as _Refreshing;
}

/// @nodoc
class _$_Refreshing implements _Refreshing {
  const _$_Refreshing();

  @override
  String toString() {
    return 'RunslistState.refreshing()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _Refreshing);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result refreshing(),
    @required Result loadingMore(),
    @required Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
  }) {
    assert(initial != null);
    assert(refreshing != null);
    assert(loadingMore != null);
    assert(loadedRuns != null);
    return refreshing();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result refreshing(),
    Result loadingMore(),
    Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (refreshing != null) {
      return refreshing();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result refreshing(_Refreshing value),
    @required Result loadingMore(_LoadingMore value),
    @required Result loadedRuns(_LoadedRuns value),
  }) {
    assert(initial != null);
    assert(refreshing != null);
    assert(loadingMore != null);
    assert(loadedRuns != null);
    return refreshing(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result refreshing(_Refreshing value),
    Result loadingMore(_LoadingMore value),
    Result loadedRuns(_LoadedRuns value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (refreshing != null) {
      return refreshing(this);
    }
    return orElse();
  }
}

abstract class _Refreshing implements RunslistState {
  const factory _Refreshing() = _$_Refreshing;
}

/// @nodoc
abstract class _$LoadingMoreCopyWith<$Res> {
  factory _$LoadingMoreCopyWith(
          _LoadingMore value, $Res Function(_LoadingMore) then) =
      __$LoadingMoreCopyWithImpl<$Res>;
}

/// @nodoc
class __$LoadingMoreCopyWithImpl<$Res> extends _$RunslistStateCopyWithImpl<$Res>
    implements _$LoadingMoreCopyWith<$Res> {
  __$LoadingMoreCopyWithImpl(
      _LoadingMore _value, $Res Function(_LoadingMore) _then)
      : super(_value, (v) => _then(v as _LoadingMore));

  @override
  _LoadingMore get _value => super._value as _LoadingMore;
}

/// @nodoc
class _$_LoadingMore implements _LoadingMore {
  const _$_LoadingMore();

  @override
  String toString() {
    return 'RunslistState.loadingMore()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is _LoadingMore);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result refreshing(),
    @required Result loadingMore(),
    @required Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
  }) {
    assert(initial != null);
    assert(refreshing != null);
    assert(loadingMore != null);
    assert(loadedRuns != null);
    return loadingMore();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result refreshing(),
    Result loadingMore(),
    Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadingMore != null) {
      return loadingMore();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result refreshing(_Refreshing value),
    @required Result loadingMore(_LoadingMore value),
    @required Result loadedRuns(_LoadedRuns value),
  }) {
    assert(initial != null);
    assert(refreshing != null);
    assert(loadingMore != null);
    assert(loadedRuns != null);
    return loadingMore(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result refreshing(_Refreshing value),
    Result loadingMore(_LoadingMore value),
    Result loadedRuns(_LoadedRuns value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadingMore != null) {
      return loadingMore(this);
    }
    return orElse();
  }
}

abstract class _LoadingMore implements RunslistState {
  const factory _LoadingMore() = _$_LoadingMore;
}

/// @nodoc
abstract class _$LoadedRunsCopyWith<$Res> {
  factory _$LoadedRunsCopyWith(
          _LoadedRuns value, $Res Function(_LoadedRuns) then) =
      __$LoadedRunsCopyWithImpl<$Res>;
  $Res call({Either<SpeedRunFailure, List<Run>> runs});
}

/// @nodoc
class __$LoadedRunsCopyWithImpl<$Res> extends _$RunslistStateCopyWithImpl<$Res>
    implements _$LoadedRunsCopyWith<$Res> {
  __$LoadedRunsCopyWithImpl(
      _LoadedRuns _value, $Res Function(_LoadedRuns) _then)
      : super(_value, (v) => _then(v as _LoadedRuns));

  @override
  _LoadedRuns get _value => super._value as _LoadedRuns;

  @override
  $Res call({
    Object runs = freezed,
  }) {
    return _then(_LoadedRuns(
      runs == freezed
          ? _value.runs
          : runs as Either<SpeedRunFailure, List<Run>>,
    ));
  }
}

/// @nodoc
class _$_LoadedRuns implements _LoadedRuns {
  const _$_LoadedRuns(this.runs) : assert(runs != null);

  @override
  final Either<SpeedRunFailure, List<Run>> runs;

  @override
  String toString() {
    return 'RunslistState.loadedRuns(runs: $runs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LoadedRuns &&
            (identical(other.runs, runs) ||
                const DeepCollectionEquality().equals(other.runs, runs)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(runs);

  @override
  _$LoadedRunsCopyWith<_LoadedRuns> get copyWith =>
      __$LoadedRunsCopyWithImpl<_LoadedRuns>(this, _$identity);

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result initial(),
    @required Result refreshing(),
    @required Result loadingMore(),
    @required Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
  }) {
    assert(initial != null);
    assert(refreshing != null);
    assert(loadingMore != null);
    assert(loadedRuns != null);
    return loadedRuns(runs);
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result initial(),
    Result refreshing(),
    Result loadingMore(),
    Result loadedRuns(Either<SpeedRunFailure, List<Run>> runs),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadedRuns != null) {
      return loadedRuns(runs);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result initial(_Initial value),
    @required Result refreshing(_Refreshing value),
    @required Result loadingMore(_LoadingMore value),
    @required Result loadedRuns(_LoadedRuns value),
  }) {
    assert(initial != null);
    assert(refreshing != null);
    assert(loadingMore != null);
    assert(loadedRuns != null);
    return loadedRuns(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result initial(_Initial value),
    Result refreshing(_Refreshing value),
    Result loadingMore(_LoadingMore value),
    Result loadedRuns(_LoadedRuns value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (loadedRuns != null) {
      return loadedRuns(this);
    }
    return orElse();
  }
}

abstract class _LoadedRuns implements RunslistState {
  const factory _LoadedRuns(Either<SpeedRunFailure, List<Run>> runs) =
      _$_LoadedRuns;

  Either<SpeedRunFailure, List<Run>> get runs;
  _$LoadedRunsCopyWith<_LoadedRuns> get copyWith;
}
