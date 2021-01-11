// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'run_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$RunDetailsStateTearOff {
  const _$RunDetailsStateTearOff();

// ignore: unused_element
  _RunDetailsState call({Run run}) {
    return _RunDetailsState(
      run: run,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $RunDetailsState = _$RunDetailsStateTearOff();

/// @nodoc
mixin _$RunDetailsState {
  Run get run;

  $RunDetailsStateCopyWith<RunDetailsState> get copyWith;
}

/// @nodoc
abstract class $RunDetailsStateCopyWith<$Res> {
  factory $RunDetailsStateCopyWith(
          RunDetailsState value, $Res Function(RunDetailsState) then) =
      _$RunDetailsStateCopyWithImpl<$Res>;
  $Res call({Run run});

  $RunCopyWith<$Res> get run;
}

/// @nodoc
class _$RunDetailsStateCopyWithImpl<$Res>
    implements $RunDetailsStateCopyWith<$Res> {
  _$RunDetailsStateCopyWithImpl(this._value, this._then);

  final RunDetailsState _value;
  // ignore: unused_field
  final $Res Function(RunDetailsState) _then;

  @override
  $Res call({
    Object run = freezed,
  }) {
    return _then(_value.copyWith(
      run: run == freezed ? _value.run : run as Run,
    ));
  }

  @override
  $RunCopyWith<$Res> get run {
    if (_value.run == null) {
      return null;
    }
    return $RunCopyWith<$Res>(_value.run, (value) {
      return _then(_value.copyWith(run: value));
    });
  }
}

/// @nodoc
abstract class _$RunDetailsStateCopyWith<$Res>
    implements $RunDetailsStateCopyWith<$Res> {
  factory _$RunDetailsStateCopyWith(
          _RunDetailsState value, $Res Function(_RunDetailsState) then) =
      __$RunDetailsStateCopyWithImpl<$Res>;
  @override
  $Res call({Run run});

  @override
  $RunCopyWith<$Res> get run;
}

/// @nodoc
class __$RunDetailsStateCopyWithImpl<$Res>
    extends _$RunDetailsStateCopyWithImpl<$Res>
    implements _$RunDetailsStateCopyWith<$Res> {
  __$RunDetailsStateCopyWithImpl(
      _RunDetailsState _value, $Res Function(_RunDetailsState) _then)
      : super(_value, (v) => _then(v as _RunDetailsState));

  @override
  _RunDetailsState get _value => super._value as _RunDetailsState;

  @override
  $Res call({
    Object run = freezed,
  }) {
    return _then(_RunDetailsState(
      run: run == freezed ? _value.run : run as Run,
    ));
  }
}

/// @nodoc
class _$_RunDetailsState implements _RunDetailsState {
  const _$_RunDetailsState({this.run});

  @override
  final Run run;

  @override
  String toString() {
    return 'RunDetailsState(run: $run)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _RunDetailsState &&
            (identical(other.run, run) ||
                const DeepCollectionEquality().equals(other.run, run)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(run);

  @override
  _$RunDetailsStateCopyWith<_RunDetailsState> get copyWith =>
      __$RunDetailsStateCopyWithImpl<_RunDetailsState>(this, _$identity);
}

abstract class _RunDetailsState implements RunDetailsState {
  const factory _RunDetailsState({Run run}) = _$_RunDetailsState;

  @override
  Run get run;
  @override
  _$RunDetailsStateCopyWith<_RunDetailsState> get copyWith;
}
