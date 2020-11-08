// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'runlist_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$RunlistStateTearOff {
  const _$RunlistStateTearOff();

// ignore: unused_element
  _RunlistState call({List<Run> runs}) {
    return _RunlistState(
      runs: runs,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $RunlistState = _$RunlistStateTearOff();

/// @nodoc
mixin _$RunlistState {
  List<Run> get runs;

  $RunlistStateCopyWith<RunlistState> get copyWith;
}

/// @nodoc
abstract class $RunlistStateCopyWith<$Res> {
  factory $RunlistStateCopyWith(
          RunlistState value, $Res Function(RunlistState) then) =
      _$RunlistStateCopyWithImpl<$Res>;
  $Res call({List<Run> runs});
}

/// @nodoc
class _$RunlistStateCopyWithImpl<$Res> implements $RunlistStateCopyWith<$Res> {
  _$RunlistStateCopyWithImpl(this._value, this._then);

  final RunlistState _value;
  // ignore: unused_field
  final $Res Function(RunlistState) _then;

  @override
  $Res call({
    Object runs = freezed,
  }) {
    return _then(_value.copyWith(
      runs: runs == freezed ? _value.runs : runs as List<Run>,
    ));
  }
}

/// @nodoc
abstract class _$RunlistStateCopyWith<$Res>
    implements $RunlistStateCopyWith<$Res> {
  factory _$RunlistStateCopyWith(
          _RunlistState value, $Res Function(_RunlistState) then) =
      __$RunlistStateCopyWithImpl<$Res>;
  @override
  $Res call({List<Run> runs});
}

/// @nodoc
class __$RunlistStateCopyWithImpl<$Res> extends _$RunlistStateCopyWithImpl<$Res>
    implements _$RunlistStateCopyWith<$Res> {
  __$RunlistStateCopyWithImpl(
      _RunlistState _value, $Res Function(_RunlistState) _then)
      : super(_value, (v) => _then(v as _RunlistState));

  @override
  _RunlistState get _value => super._value as _RunlistState;

  @override
  $Res call({
    Object runs = freezed,
  }) {
    return _then(_RunlistState(
      runs: runs == freezed ? _value.runs : runs as List<Run>,
    ));
  }
}

/// @nodoc
class _$_RunlistState extends _RunlistState {
  const _$_RunlistState({this.runs}) : super._();

  @override
  final List<Run> runs;

  @override
  String toString() {
    return 'RunlistState(runs: $runs)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RunlistState &&
            (identical(other.runs, runs) ||
                const DeepCollectionEquality().equals(other.runs, runs)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(runs);

  @override
  _$RunlistStateCopyWith<_RunlistState> get copyWith =>
      __$RunlistStateCopyWithImpl<_RunlistState>(this, _$identity);
}

abstract class _RunlistState extends RunlistState {
  const _RunlistState._() : super._();
  const factory _RunlistState({List<Run> runs}) = _$_RunlistState;

  @override
  List<Run> get runs;
  @override
  _$RunlistStateCopyWith<_RunlistState> get copyWith;
}
