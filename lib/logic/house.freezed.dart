// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'house.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
House _$HouseFromJson(Map<String, dynamic> json) {
  return _House.fromJson(json);
}

/// @nodoc
class _$HouseTearOff {
  const _$HouseTearOff();

// ignore: unused_element
  _House call(
      {@JsonKey(name: 'id_house') String id,
      @JsonKey(name: 'id_house') String id}) {
    return _House(
      id: id,
      id: id,
    );
  }

// ignore: unused_element
  House fromJson(Map<String, Object> json) {
    return House.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $House = _$HouseTearOff();

/// @nodoc
mixin _$House {
  @JsonKey(name: 'id_house')
  String get id;
  @JsonKey(name: 'id_house')
  String get id;

  Map<String, dynamic> toJson();
  $HouseCopyWith<House> get copyWith;
}

/// @nodoc
abstract class $HouseCopyWith<$Res> {
  factory $HouseCopyWith(House value, $Res Function(House) then) =
      _$HouseCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'id_house') String id,
      @JsonKey(name: 'id_house') String id});
}

/// @nodoc
class _$HouseCopyWithImpl<$Res> implements $HouseCopyWith<$Res> {
  _$HouseCopyWithImpl(this._value, this._then);

  final House _value;
  // ignore: unused_field
  final $Res Function(House) _then;

  @override
  $Res call({
    Object id = freezed,
    Object id = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      id: id == freezed ? _value.id : id as String,
    ));
  }
}

/// @nodoc
abstract class _$HouseCopyWith<$Res> implements $HouseCopyWith<$Res> {
  factory _$HouseCopyWith(_House value, $Res Function(_House) then) =
      __$HouseCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'id_house') String id,
      @JsonKey(name: 'id_house') String id});
}

/// @nodoc
class __$HouseCopyWithImpl<$Res> extends _$HouseCopyWithImpl<$Res>
    implements _$HouseCopyWith<$Res> {
  __$HouseCopyWithImpl(_House _value, $Res Function(_House) _then)
      : super(_value, (v) => _then(v as _House));

  @override
  _House get _value => super._value as _House;

  @override
  $Res call({
    Object id = freezed,
    Object id = freezed,
  }) {
    return _then(_House(
      id: id == freezed ? _value.id : id as String,
      id: id == freezed ? _value.id : id as String,
    ));
  }
}

@JsonSerializable(explicitToJson: true)

/// @nodoc
class _$_House implements _House {
  const _$_House(
      {@JsonKey(name: 'id_house') this.id, @JsonKey(name: 'id_house') this.id});

  factory _$_House.fromJson(Map<String, dynamic> json) =>
      _$_$_HouseFromJson(json);

  @override
  @JsonKey(name: 'id_house')
  final String id;
  @override
  @JsonKey(name: 'id_house')
  final String id;

  @override
  String toString() {
    return 'House(id: $id, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _House &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(id);

  @override
  _$HouseCopyWith<_House> get copyWith =>
      __$HouseCopyWithImpl<_House>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_HouseToJson(this);
  }
}

abstract class _House implements House {
  const factory _House(
      {@JsonKey(name: 'id_house') String id,
      @JsonKey(name: 'id_house') String id}) = _$_House;

  factory _House.fromJson(Map<String, dynamic> json) = _$_House.fromJson;

  @override
  @JsonKey(name: 'id_house')
  String get id;
  @override
  @JsonKey(name: 'id_house')
  String get id;
  @override
  _$HouseCopyWith<_House> get copyWith;
}
