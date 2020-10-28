// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'names.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Names _$NamesFromJson(Map<String, dynamic> json) {
  return _Names.fromJson(json);
}

/// @nodoc
class _$NamesTearOff {
  const _$NamesTearOff();

// ignore: unused_element
  _Names call({String international, String japanese}) {
    return _Names(
      international: international,
      japanese: japanese,
    );
  }

// ignore: unused_element
  Names fromJson(Map<String, Object> json) {
    return Names.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Names = _$NamesTearOff();

/// @nodoc
mixin _$Names {
  String get international;
  String get japanese;

  Map<String, dynamic> toJson();
  $NamesCopyWith<Names> get copyWith;
}

/// @nodoc
abstract class $NamesCopyWith<$Res> {
  factory $NamesCopyWith(Names value, $Res Function(Names) then) =
      _$NamesCopyWithImpl<$Res>;
  $Res call({String international, String japanese});
}

/// @nodoc
class _$NamesCopyWithImpl<$Res> implements $NamesCopyWith<$Res> {
  _$NamesCopyWithImpl(this._value, this._then);

  final Names _value;
  // ignore: unused_field
  final $Res Function(Names) _then;

  @override
  $Res call({
    Object international = freezed,
    Object japanese = freezed,
  }) {
    return _then(_value.copyWith(
      international: international == freezed
          ? _value.international
          : international as String,
      japanese: japanese == freezed ? _value.japanese : japanese as String,
    ));
  }
}

/// @nodoc
abstract class _$NamesCopyWith<$Res> implements $NamesCopyWith<$Res> {
  factory _$NamesCopyWith(_Names value, $Res Function(_Names) then) =
      __$NamesCopyWithImpl<$Res>;
  @override
  $Res call({String international, String japanese});
}

/// @nodoc
class __$NamesCopyWithImpl<$Res> extends _$NamesCopyWithImpl<$Res>
    implements _$NamesCopyWith<$Res> {
  __$NamesCopyWithImpl(_Names _value, $Res Function(_Names) _then)
      : super(_value, (v) => _then(v as _Names));

  @override
  _Names get _value => super._value as _Names;

  @override
  $Res call({
    Object international = freezed,
    Object japanese = freezed,
  }) {
    return _then(_Names(
      international: international == freezed
          ? _value.international
          : international as String,
      japanese: japanese == freezed ? _value.japanese : japanese as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Names implements _Names {
  const _$_Names({this.international, this.japanese});

  factory _$_Names.fromJson(Map<String, dynamic> json) =>
      _$_$_NamesFromJson(json);

  @override
  final String international;
  @override
  final String japanese;

  @override
  String toString() {
    return 'Names(international: $international, japanese: $japanese)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Names &&
            (identical(other.international, international) ||
                const DeepCollectionEquality()
                    .equals(other.international, international)) &&
            (identical(other.japanese, japanese) ||
                const DeepCollectionEquality()
                    .equals(other.japanese, japanese)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(international) ^
      const DeepCollectionEquality().hash(japanese);

  @override
  _$NamesCopyWith<_Names> get copyWith =>
      __$NamesCopyWithImpl<_Names>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_NamesToJson(this);
  }
}

abstract class _Names implements Names {
  const factory _Names({String international, String japanese}) = _$_Names;

  factory _Names.fromJson(Map<String, dynamic> json) = _$_Names.fromJson;

  @override
  String get international;
  @override
  String get japanese;
  @override
  _$NamesCopyWith<_Names> get copyWith;
}
