// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'times.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Times _$TimesFromJson(Map<String, dynamic> json) {
  return _Times.fromJson(json);
}

/// @nodoc
class _$TimesTearOff {
  const _$TimesTearOff();

// ignore: unused_element
  _Times call(
      {@JsonKey(name: "primary") String primary,
      @JsonKey(name: "primary_t") double primarySeconds,
      @JsonKey(name: "realtime") String realtime,
      @JsonKey(name: "realtime_t") double realtimeSeconds}) {
    return _Times(
      primary: primary,
      primarySeconds: primarySeconds,
      realtime: realtime,
      realtimeSeconds: realtimeSeconds,
    );
  }

// ignore: unused_element
  Times fromJson(Map<String, Object> json) {
    return Times.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Times = _$TimesTearOff();

/// @nodoc
mixin _$Times {
  @JsonKey(name: "primary")
  String get primary;
  @JsonKey(name: "primary_t")
  double get primarySeconds;
  @JsonKey(name: "realtime")
  String get realtime;
  @JsonKey(name: "realtime_t")
  double get realtimeSeconds;

  Map<String, dynamic> toJson();
  $TimesCopyWith<Times> get copyWith;
}

/// @nodoc
abstract class $TimesCopyWith<$Res> {
  factory $TimesCopyWith(Times value, $Res Function(Times) then) =
      _$TimesCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: "primary") String primary,
      @JsonKey(name: "primary_t") double primarySeconds,
      @JsonKey(name: "realtime") String realtime,
      @JsonKey(name: "realtime_t") double realtimeSeconds});
}

/// @nodoc
class _$TimesCopyWithImpl<$Res> implements $TimesCopyWith<$Res> {
  _$TimesCopyWithImpl(this._value, this._then);

  final Times _value;
  // ignore: unused_field
  final $Res Function(Times) _then;

  @override
  $Res call({
    Object primary = freezed,
    Object primarySeconds = freezed,
    Object realtime = freezed,
    Object realtimeSeconds = freezed,
  }) {
    return _then(_value.copyWith(
      primary: primary == freezed ? _value.primary : primary as String,
      primarySeconds: primarySeconds == freezed
          ? _value.primarySeconds
          : primarySeconds as double,
      realtime: realtime == freezed ? _value.realtime : realtime as String,
      realtimeSeconds: realtimeSeconds == freezed
          ? _value.realtimeSeconds
          : realtimeSeconds as double,
    ));
  }
}

/// @nodoc
abstract class _$TimesCopyWith<$Res> implements $TimesCopyWith<$Res> {
  factory _$TimesCopyWith(_Times value, $Res Function(_Times) then) =
      __$TimesCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: "primary") String primary,
      @JsonKey(name: "primary_t") double primarySeconds,
      @JsonKey(name: "realtime") String realtime,
      @JsonKey(name: "realtime_t") double realtimeSeconds});
}

/// @nodoc
class __$TimesCopyWithImpl<$Res> extends _$TimesCopyWithImpl<$Res>
    implements _$TimesCopyWith<$Res> {
  __$TimesCopyWithImpl(_Times _value, $Res Function(_Times) _then)
      : super(_value, (v) => _then(v as _Times));

  @override
  _Times get _value => super._value as _Times;

  @override
  $Res call({
    Object primary = freezed,
    Object primarySeconds = freezed,
    Object realtime = freezed,
    Object realtimeSeconds = freezed,
  }) {
    return _then(_Times(
      primary: primary == freezed ? _value.primary : primary as String,
      primarySeconds: primarySeconds == freezed
          ? _value.primarySeconds
          : primarySeconds as double,
      realtime: realtime == freezed ? _value.realtime : realtime as String,
      realtimeSeconds: realtimeSeconds == freezed
          ? _value.realtimeSeconds
          : realtimeSeconds as double,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Times implements _Times {
  const _$_Times(
      {@JsonKey(name: "primary") this.primary,
      @JsonKey(name: "primary_t") this.primarySeconds,
      @JsonKey(name: "realtime") this.realtime,
      @JsonKey(name: "realtime_t") this.realtimeSeconds});

  factory _$_Times.fromJson(Map<String, dynamic> json) =>
      _$_$_TimesFromJson(json);

  @override
  @JsonKey(name: "primary")
  final String primary;
  @override
  @JsonKey(name: "primary_t")
  final double primarySeconds;
  @override
  @JsonKey(name: "realtime")
  final String realtime;
  @override
  @JsonKey(name: "realtime_t")
  final double realtimeSeconds;

  @override
  String toString() {
    return 'Times(primary: $primary, primarySeconds: $primarySeconds, realtime: $realtime, realtimeSeconds: $realtimeSeconds)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Times &&
            (identical(other.primary, primary) ||
                const DeepCollectionEquality()
                    .equals(other.primary, primary)) &&
            (identical(other.primarySeconds, primarySeconds) ||
                const DeepCollectionEquality()
                    .equals(other.primarySeconds, primarySeconds)) &&
            (identical(other.realtime, realtime) ||
                const DeepCollectionEquality()
                    .equals(other.realtime, realtime)) &&
            (identical(other.realtimeSeconds, realtimeSeconds) ||
                const DeepCollectionEquality()
                    .equals(other.realtimeSeconds, realtimeSeconds)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(primary) ^
      const DeepCollectionEquality().hash(primarySeconds) ^
      const DeepCollectionEquality().hash(realtime) ^
      const DeepCollectionEquality().hash(realtimeSeconds);

  @override
  _$TimesCopyWith<_Times> get copyWith =>
      __$TimesCopyWithImpl<_Times>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_TimesToJson(this);
  }
}

abstract class _Times implements Times {
  const factory _Times(
      {@JsonKey(name: "primary") String primary,
      @JsonKey(name: "primary_t") double primarySeconds,
      @JsonKey(name: "realtime") String realtime,
      @JsonKey(name: "realtime_t") double realtimeSeconds}) = _$_Times;

  factory _Times.fromJson(Map<String, dynamic> json) = _$_Times.fromJson;

  @override
  @JsonKey(name: "primary")
  String get primary;
  @override
  @JsonKey(name: "primary_t")
  double get primarySeconds;
  @override
  @JsonKey(name: "realtime")
  String get realtime;
  @override
  @JsonKey(name: "realtime_t")
  double get realtimeSeconds;
  @override
  _$TimesCopyWith<_Times> get copyWith;
}
