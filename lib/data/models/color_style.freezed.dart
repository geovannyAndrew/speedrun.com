// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'color_style.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
ColorStyle _$ColorStyleFromJson(Map<String, dynamic> json) {
  return _ColorStyle.fromJson(json);
}

/// @nodoc
class _$ColorStyleTearOff {
  const _$ColorStyleTearOff();

// ignore: unused_element
  _ColorStyle call(
      {@JsonKey(name: 'style') String style,
      @JsonKey(name: 'color') CColor color,
      @JsonKey(name: 'color-from') CColor colorFrom,
      @JsonKey(name: 'color-to') CColor colorTo}) {
    return _ColorStyle(
      style: style,
      color: color,
      colorFrom: colorFrom,
      colorTo: colorTo,
    );
  }

// ignore: unused_element
  ColorStyle fromJson(Map<String, Object> json) {
    return ColorStyle.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $ColorStyle = _$ColorStyleTearOff();

/// @nodoc
mixin _$ColorStyle {
  @JsonKey(name: 'style')
  String get style;
  @JsonKey(name: 'color')
  CColor get color;
  @JsonKey(name: 'color-from')
  CColor get colorFrom;
  @JsonKey(name: 'color-to')
  CColor get colorTo;

  Map<String, dynamic> toJson();
  $ColorStyleCopyWith<ColorStyle> get copyWith;
}

/// @nodoc
abstract class $ColorStyleCopyWith<$Res> {
  factory $ColorStyleCopyWith(
          ColorStyle value, $Res Function(ColorStyle) then) =
      _$ColorStyleCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'style') String style,
      @JsonKey(name: 'color') CColor color,
      @JsonKey(name: 'color-from') CColor colorFrom,
      @JsonKey(name: 'color-to') CColor colorTo});

  $CColorCopyWith<$Res> get color;
  $CColorCopyWith<$Res> get colorFrom;
  $CColorCopyWith<$Res> get colorTo;
}

/// @nodoc
class _$ColorStyleCopyWithImpl<$Res> implements $ColorStyleCopyWith<$Res> {
  _$ColorStyleCopyWithImpl(this._value, this._then);

  final ColorStyle _value;
  // ignore: unused_field
  final $Res Function(ColorStyle) _then;

  @override
  $Res call({
    Object style = freezed,
    Object color = freezed,
    Object colorFrom = freezed,
    Object colorTo = freezed,
  }) {
    return _then(_value.copyWith(
      style: style == freezed ? _value.style : style as String,
      color: color == freezed ? _value.color : color as CColor,
      colorFrom: colorFrom == freezed ? _value.colorFrom : colorFrom as CColor,
      colorTo: colorTo == freezed ? _value.colorTo : colorTo as CColor,
    ));
  }

  @override
  $CColorCopyWith<$Res> get color {
    if (_value.color == null) {
      return null;
    }
    return $CColorCopyWith<$Res>(_value.color, (value) {
      return _then(_value.copyWith(color: value));
    });
  }

  @override
  $CColorCopyWith<$Res> get colorFrom {
    if (_value.colorFrom == null) {
      return null;
    }
    return $CColorCopyWith<$Res>(_value.colorFrom, (value) {
      return _then(_value.copyWith(colorFrom: value));
    });
  }

  @override
  $CColorCopyWith<$Res> get colorTo {
    if (_value.colorTo == null) {
      return null;
    }
    return $CColorCopyWith<$Res>(_value.colorTo, (value) {
      return _then(_value.copyWith(colorTo: value));
    });
  }
}

/// @nodoc
abstract class _$ColorStyleCopyWith<$Res> implements $ColorStyleCopyWith<$Res> {
  factory _$ColorStyleCopyWith(
          _ColorStyle value, $Res Function(_ColorStyle) then) =
      __$ColorStyleCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'style') String style,
      @JsonKey(name: 'color') CColor color,
      @JsonKey(name: 'color-from') CColor colorFrom,
      @JsonKey(name: 'color-to') CColor colorTo});

  @override
  $CColorCopyWith<$Res> get color;
  @override
  $CColorCopyWith<$Res> get colorFrom;
  @override
  $CColorCopyWith<$Res> get colorTo;
}

/// @nodoc
class __$ColorStyleCopyWithImpl<$Res> extends _$ColorStyleCopyWithImpl<$Res>
    implements _$ColorStyleCopyWith<$Res> {
  __$ColorStyleCopyWithImpl(
      _ColorStyle _value, $Res Function(_ColorStyle) _then)
      : super(_value, (v) => _then(v as _ColorStyle));

  @override
  _ColorStyle get _value => super._value as _ColorStyle;

  @override
  $Res call({
    Object style = freezed,
    Object color = freezed,
    Object colorFrom = freezed,
    Object colorTo = freezed,
  }) {
    return _then(_ColorStyle(
      style: style == freezed ? _value.style : style as String,
      color: color == freezed ? _value.color : color as CColor,
      colorFrom: colorFrom == freezed ? _value.colorFrom : colorFrom as CColor,
      colorTo: colorTo == freezed ? _value.colorTo : colorTo as CColor,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_ColorStyle implements _ColorStyle {
  const _$_ColorStyle(
      {@JsonKey(name: 'style') this.style,
      @JsonKey(name: 'color') this.color,
      @JsonKey(name: 'color-from') this.colorFrom,
      @JsonKey(name: 'color-to') this.colorTo});

  factory _$_ColorStyle.fromJson(Map<String, dynamic> json) =>
      _$_$_ColorStyleFromJson(json);

  @override
  @JsonKey(name: 'style')
  final String style;
  @override
  @JsonKey(name: 'color')
  final CColor color;
  @override
  @JsonKey(name: 'color-from')
  final CColor colorFrom;
  @override
  @JsonKey(name: 'color-to')
  final CColor colorTo;

  @override
  String toString() {
    return 'ColorStyle(style: $style, color: $color, colorFrom: $colorFrom, colorTo: $colorTo)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ColorStyle &&
            (identical(other.style, style) ||
                const DeepCollectionEquality().equals(other.style, style)) &&
            (identical(other.color, color) ||
                const DeepCollectionEquality().equals(other.color, color)) &&
            (identical(other.colorFrom, colorFrom) ||
                const DeepCollectionEquality()
                    .equals(other.colorFrom, colorFrom)) &&
            (identical(other.colorTo, colorTo) ||
                const DeepCollectionEquality().equals(other.colorTo, colorTo)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(style) ^
      const DeepCollectionEquality().hash(color) ^
      const DeepCollectionEquality().hash(colorFrom) ^
      const DeepCollectionEquality().hash(colorTo);

  @override
  _$ColorStyleCopyWith<_ColorStyle> get copyWith =>
      __$ColorStyleCopyWithImpl<_ColorStyle>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_ColorStyleToJson(this);
  }
}

abstract class _ColorStyle implements ColorStyle {
  const factory _ColorStyle(
      {@JsonKey(name: 'style') String style,
      @JsonKey(name: 'color') CColor color,
      @JsonKey(name: 'color-from') CColor colorFrom,
      @JsonKey(name: 'color-to') CColor colorTo}) = _$_ColorStyle;

  factory _ColorStyle.fromJson(Map<String, dynamic> json) =
      _$_ColorStyle.fromJson;

  @override
  @JsonKey(name: 'style')
  String get style;
  @override
  @JsonKey(name: 'color')
  CColor get color;
  @override
  @JsonKey(name: 'color-from')
  CColor get colorFrom;
  @override
  @JsonKey(name: 'color-to')
  CColor get colorTo;
  @override
  _$ColorStyleCopyWith<_ColorStyle> get copyWith;
}
