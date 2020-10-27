// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'speed_run_failure.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$SpeedRunFailureTearOff {
  const _$SpeedRunFailureTearOff();

// ignore: unused_element
  NotFound notFound() {
    return const NotFound();
  }
}

/// @nodoc
// ignore: unused_element
const $SpeedRunFailure = _$SpeedRunFailureTearOff();

/// @nodoc
mixin _$SpeedRunFailure {
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notFound(),
  });
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notFound(),
    @required Result orElse(),
  });
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notFound(NotFound value),
  });
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notFound(NotFound value),
    @required Result orElse(),
  });
}

/// @nodoc
abstract class $SpeedRunFailureCopyWith<$Res> {
  factory $SpeedRunFailureCopyWith(
          SpeedRunFailure value, $Res Function(SpeedRunFailure) then) =
      _$SpeedRunFailureCopyWithImpl<$Res>;
}

/// @nodoc
class _$SpeedRunFailureCopyWithImpl<$Res>
    implements $SpeedRunFailureCopyWith<$Res> {
  _$SpeedRunFailureCopyWithImpl(this._value, this._then);

  final SpeedRunFailure _value;
  // ignore: unused_field
  final $Res Function(SpeedRunFailure) _then;
}

/// @nodoc
abstract class $NotFoundCopyWith<$Res> {
  factory $NotFoundCopyWith(NotFound value, $Res Function(NotFound) then) =
      _$NotFoundCopyWithImpl<$Res>;
}

/// @nodoc
class _$NotFoundCopyWithImpl<$Res> extends _$SpeedRunFailureCopyWithImpl<$Res>
    implements $NotFoundCopyWith<$Res> {
  _$NotFoundCopyWithImpl(NotFound _value, $Res Function(NotFound) _then)
      : super(_value, (v) => _then(v as NotFound));

  @override
  NotFound get _value => super._value as NotFound;
}

/// @nodoc
class _$NotFound implements NotFound {
  const _$NotFound();

  @override
  String toString() {
    return 'SpeedRunFailure.notFound()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is NotFound);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  Result when<Result extends Object>({
    @required Result notFound(),
  }) {
    assert(notFound != null);
    return notFound();
  }

  @override
  @optionalTypeArgs
  Result maybeWhen<Result extends Object>({
    Result notFound(),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (notFound != null) {
      return notFound();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  Result map<Result extends Object>({
    @required Result notFound(NotFound value),
  }) {
    assert(notFound != null);
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  Result maybeMap<Result extends Object>({
    Result notFound(NotFound value),
    @required Result orElse(),
  }) {
    assert(orElse != null);
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFound implements SpeedRunFailure {
  const factory NotFound() = _$NotFound;
}
