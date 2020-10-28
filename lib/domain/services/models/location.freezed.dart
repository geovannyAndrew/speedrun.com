// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Location _$LocationFromJson(Map<String, dynamic> json) {
  return _Location.fromJson(json);
}

/// @nodoc
class _$LocationTearOff {
  const _$LocationTearOff();

// ignore: unused_element
  _Location call({String code, Names names}) {
    return _Location(
      code: code,
      names: names,
    );
  }

// ignore: unused_element
  Location fromJson(Map<String, Object> json) {
    return Location.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Location = _$LocationTearOff();

/// @nodoc
mixin _$Location {
  String get code;
  Names get names;

  Map<String, dynamic> toJson();
  $LocationCopyWith<Location> get copyWith;
}

/// @nodoc
abstract class $LocationCopyWith<$Res> {
  factory $LocationCopyWith(Location value, $Res Function(Location) then) =
      _$LocationCopyWithImpl<$Res>;
  $Res call({String code, Names names});

  $NamesCopyWith<$Res> get names;
}

/// @nodoc
class _$LocationCopyWithImpl<$Res> implements $LocationCopyWith<$Res> {
  _$LocationCopyWithImpl(this._value, this._then);

  final Location _value;
  // ignore: unused_field
  final $Res Function(Location) _then;

  @override
  $Res call({
    Object code = freezed,
    Object names = freezed,
  }) {
    return _then(_value.copyWith(
      code: code == freezed ? _value.code : code as String,
      names: names == freezed ? _value.names : names as Names,
    ));
  }

  @override
  $NamesCopyWith<$Res> get names {
    if (_value.names == null) {
      return null;
    }
    return $NamesCopyWith<$Res>(_value.names, (value) {
      return _then(_value.copyWith(names: value));
    });
  }
}

/// @nodoc
abstract class _$LocationCopyWith<$Res> implements $LocationCopyWith<$Res> {
  factory _$LocationCopyWith(_Location value, $Res Function(_Location) then) =
      __$LocationCopyWithImpl<$Res>;
  @override
  $Res call({String code, Names names});

  @override
  $NamesCopyWith<$Res> get names;
}

/// @nodoc
class __$LocationCopyWithImpl<$Res> extends _$LocationCopyWithImpl<$Res>
    implements _$LocationCopyWith<$Res> {
  __$LocationCopyWithImpl(_Location _value, $Res Function(_Location) _then)
      : super(_value, (v) => _then(v as _Location));

  @override
  _Location get _value => super._value as _Location;

  @override
  $Res call({
    Object code = freezed,
    Object names = freezed,
  }) {
    return _then(_Location(
      code: code == freezed ? _value.code : code as String,
      names: names == freezed ? _value.names : names as Names,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Location implements _Location {
  const _$_Location({this.code, this.names});

  factory _$_Location.fromJson(Map<String, dynamic> json) =>
      _$_$_LocationFromJson(json);

  @override
  final String code;
  @override
  final Names names;

  @override
  String toString() {
    return 'Location(code: $code, names: $names)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Location &&
            (identical(other.code, code) ||
                const DeepCollectionEquality().equals(other.code, code)) &&
            (identical(other.names, names) ||
                const DeepCollectionEquality().equals(other.names, names)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(code) ^
      const DeepCollectionEquality().hash(names);

  @override
  _$LocationCopyWith<_Location> get copyWith =>
      __$LocationCopyWithImpl<_Location>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LocationToJson(this);
  }
}

abstract class _Location implements Location {
  const factory _Location({String code, Names names}) = _$_Location;

  factory _Location.fromJson(Map<String, dynamic> json) = _$_Location.fromJson;

  @override
  String get code;
  @override
  Names get names;
  @override
  _$LocationCopyWith<_Location> get copyWith;
}
