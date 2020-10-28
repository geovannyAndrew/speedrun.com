// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'ccolor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
CColor _$CColorFromJson(Map<String, dynamic> json) {
  return _CColor.fromJson(json);
}

/// @nodoc
class _$CColorTearOff {
  const _$CColorTearOff();

// ignore: unused_element
  _CColor call({String light, String dark}) {
    return _CColor(
      light: light,
      dark: dark,
    );
  }

// ignore: unused_element
  CColor fromJson(Map<String, Object> json) {
    return CColor.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $CColor = _$CColorTearOff();

/// @nodoc
mixin _$CColor {
  String get light;
  String get dark;

  Map<String, dynamic> toJson();
  $CColorCopyWith<CColor> get copyWith;
}

/// @nodoc
abstract class $CColorCopyWith<$Res> {
  factory $CColorCopyWith(CColor value, $Res Function(CColor) then) =
      _$CColorCopyWithImpl<$Res>;
  $Res call({String light, String dark});
}

/// @nodoc
class _$CColorCopyWithImpl<$Res> implements $CColorCopyWith<$Res> {
  _$CColorCopyWithImpl(this._value, this._then);

  final CColor _value;
  // ignore: unused_field
  final $Res Function(CColor) _then;

  @override
  $Res call({
    Object light = freezed,
    Object dark = freezed,
  }) {
    return _then(_value.copyWith(
      light: light == freezed ? _value.light : light as String,
      dark: dark == freezed ? _value.dark : dark as String,
    ));
  }
}

/// @nodoc
abstract class _$CColorCopyWith<$Res> implements $CColorCopyWith<$Res> {
  factory _$CColorCopyWith(_CColor value, $Res Function(_CColor) then) =
      __$CColorCopyWithImpl<$Res>;
  @override
  $Res call({String light, String dark});
}

/// @nodoc
class __$CColorCopyWithImpl<$Res> extends _$CColorCopyWithImpl<$Res>
    implements _$CColorCopyWith<$Res> {
  __$CColorCopyWithImpl(_CColor _value, $Res Function(_CColor) _then)
      : super(_value, (v) => _then(v as _CColor));

  @override
  _CColor get _value => super._value as _CColor;

  @override
  $Res call({
    Object light = freezed,
    Object dark = freezed,
  }) {
    return _then(_CColor(
      light: light == freezed ? _value.light : light as String,
      dark: dark == freezed ? _value.dark : dark as String,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_CColor implements _CColor {
  const _$_CColor({this.light, this.dark});

  factory _$_CColor.fromJson(Map<String, dynamic> json) =>
      _$_$_CColorFromJson(json);

  @override
  final String light;
  @override
  final String dark;

  @override
  String toString() {
    return 'CColor(light: $light, dark: $dark)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _CColor &&
            (identical(other.light, light) ||
                const DeepCollectionEquality().equals(other.light, light)) &&
            (identical(other.dark, dark) ||
                const DeepCollectionEquality().equals(other.dark, dark)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(light) ^
      const DeepCollectionEquality().hash(dark);

  @override
  _$CColorCopyWith<_CColor> get copyWith =>
      __$CColorCopyWithImpl<_CColor>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_CColorToJson(this);
  }
}

abstract class _CColor implements CColor {
  const factory _CColor({String light, String dark}) = _$_CColor;

  factory _CColor.fromJson(Map<String, dynamic> json) = _$_CColor.fromJson;

  @override
  String get light;
  @override
  String get dark;
  @override
  _$CColorCopyWith<_CColor> get copyWith;
}
