// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'platform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Platform _$PlatformFromJson(Map<String, dynamic> json) {
  return _Platform.fromJson(json);
}

/// @nodoc
class _$PlatformTearOff {
  const _$PlatformTearOff();

// ignore: unused_element
  _Platform call(
      {String id,
      String name,
      @JsonKey(fromJson: JsonSerializableConverters.dynamicToString)
          String released}) {
    return _Platform(
      id: id,
      name: name,
      released: released,
    );
  }

// ignore: unused_element
  Platform fromJson(Map<String, Object> json) {
    return Platform.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Platform = _$PlatformTearOff();

/// @nodoc
mixin _$Platform {
  String get id;
  String get name;
  @JsonKey(fromJson: JsonSerializableConverters.dynamicToString)
  String get released;

  Map<String, dynamic> toJson();
  $PlatformCopyWith<Platform> get copyWith;
}

/// @nodoc
abstract class $PlatformCopyWith<$Res> {
  factory $PlatformCopyWith(Platform value, $Res Function(Platform) then) =
      _$PlatformCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String name,
      @JsonKey(fromJson: JsonSerializableConverters.dynamicToString)
          String released});
}

/// @nodoc
class _$PlatformCopyWithImpl<$Res> implements $PlatformCopyWith<$Res> {
  _$PlatformCopyWithImpl(this._value, this._then);

  final Platform _value;
  // ignore: unused_field
  final $Res Function(Platform) _then;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object released = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      released: released == freezed ? _value.released : released as String,
    ));
  }
}

/// @nodoc
abstract class _$PlatformCopyWith<$Res> implements $PlatformCopyWith<$Res> {
  factory _$PlatformCopyWith(_Platform value, $Res Function(_Platform) then) =
      __$PlatformCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String name,
      @JsonKey(fromJson: JsonSerializableConverters.dynamicToString)
          String released});
}

/// @nodoc
class __$PlatformCopyWithImpl<$Res> extends _$PlatformCopyWithImpl<$Res>
    implements _$PlatformCopyWith<$Res> {
  __$PlatformCopyWithImpl(_Platform _value, $Res Function(_Platform) _then)
      : super(_value, (v) => _then(v as _Platform));

  @override
  _Platform get _value => super._value as _Platform;

  @override
  $Res call({
    Object id = freezed,
    Object name = freezed,
    Object released = freezed,
  }) {
    return _then(_Platform(
      id: id == freezed ? _value.id : id as String,
      name: name == freezed ? _value.name : name as String,
      released: released == freezed ? _value.released : released as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Platform implements _Platform {
  const _$_Platform(
      {this.id,
      this.name,
      @JsonKey(fromJson: JsonSerializableConverters.dynamicToString)
          this.released});

  factory _$_Platform.fromJson(Map<String, dynamic> json) =>
      _$_$_PlatformFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  @JsonKey(fromJson: JsonSerializableConverters.dynamicToString)
  final String released;

  @override
  String toString() {
    return 'Platform(id: $id, name: $name, released: $released)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Platform &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.released, released) ||
                const DeepCollectionEquality()
                    .equals(other.released, released)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(released);

  @override
  _$PlatformCopyWith<_Platform> get copyWith =>
      __$PlatformCopyWithImpl<_Platform>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_PlatformToJson(this);
  }
}

abstract class _Platform implements Platform {
  const factory _Platform(
      {String id,
      String name,
      @JsonKey(fromJson: JsonSerializableConverters.dynamicToString)
          String released}) = _$_Platform;

  factory _Platform.fromJson(Map<String, dynamic> json) = _$_Platform.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  @JsonKey(fromJson: JsonSerializableConverters.dynamicToString)
  String get released;
  @override
  _$PlatformCopyWith<_Platform> get copyWith;
}
