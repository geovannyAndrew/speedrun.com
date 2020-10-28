// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'asset.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Asset _$AssetFromJson(Map<String, dynamic> json) {
  return _Asset.fromJson(json);
}

/// @nodoc
class _$AssetTearOff {
  const _$AssetTearOff();

// ignore: unused_element
  _Asset call({@required String uri, int width, int height}) {
    return _Asset(
      uri: uri,
      width: width,
      height: height,
    );
  }

// ignore: unused_element
  Asset fromJson(Map<String, Object> json) {
    return Asset.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Asset = _$AssetTearOff();

/// @nodoc
mixin _$Asset {
  String get uri;
  int get width;
  int get height;

  Map<String, dynamic> toJson();
  $AssetCopyWith<Asset> get copyWith;
}

/// @nodoc
abstract class $AssetCopyWith<$Res> {
  factory $AssetCopyWith(Asset value, $Res Function(Asset) then) =
      _$AssetCopyWithImpl<$Res>;
  $Res call({String uri, int width, int height});
}

/// @nodoc
class _$AssetCopyWithImpl<$Res> implements $AssetCopyWith<$Res> {
  _$AssetCopyWithImpl(this._value, this._then);

  final Asset _value;
  // ignore: unused_field
  final $Res Function(Asset) _then;

  @override
  $Res call({
    Object uri = freezed,
    Object width = freezed,
    Object height = freezed,
  }) {
    return _then(_value.copyWith(
      uri: uri == freezed ? _value.uri : uri as String,
      width: width == freezed ? _value.width : width as int,
      height: height == freezed ? _value.height : height as int,
    ));
  }
}

/// @nodoc
abstract class _$AssetCopyWith<$Res> implements $AssetCopyWith<$Res> {
  factory _$AssetCopyWith(_Asset value, $Res Function(_Asset) then) =
      __$AssetCopyWithImpl<$Res>;
  @override
  $Res call({String uri, int width, int height});
}

/// @nodoc
class __$AssetCopyWithImpl<$Res> extends _$AssetCopyWithImpl<$Res>
    implements _$AssetCopyWith<$Res> {
  __$AssetCopyWithImpl(_Asset _value, $Res Function(_Asset) _then)
      : super(_value, (v) => _then(v as _Asset));

  @override
  _Asset get _value => super._value as _Asset;

  @override
  $Res call({
    Object uri = freezed,
    Object width = freezed,
    Object height = freezed,
  }) {
    return _then(_Asset(
      uri: uri == freezed ? _value.uri : uri as String,
      width: width == freezed ? _value.width : width as int,
      height: height == freezed ? _value.height : height as int,
    ));
  }
}

@JsonSerializable()

/// @nodoc
class _$_Asset extends _Asset {
  _$_Asset({@required this.uri, this.width, this.height})
      : assert(uri != null),
        super._();

  factory _$_Asset.fromJson(Map<String, dynamic> json) =>
      _$_$_AssetFromJson(json);

  @override
  final String uri;
  @override
  final int width;
  @override
  final int height;

  @override
  String toString() {
    return 'Asset(uri: $uri, width: $width, height: $height)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Asset &&
            (identical(other.uri, uri) ||
                const DeepCollectionEquality().equals(other.uri, uri)) &&
            (identical(other.width, width) ||
                const DeepCollectionEquality().equals(other.width, width)) &&
            (identical(other.height, height) ||
                const DeepCollectionEquality().equals(other.height, height)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uri) ^
      const DeepCollectionEquality().hash(width) ^
      const DeepCollectionEquality().hash(height);

  @override
  _$AssetCopyWith<_Asset> get copyWith =>
      __$AssetCopyWithImpl<_Asset>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_AssetToJson(this);
  }
}

abstract class _Asset extends Asset {
  _Asset._() : super._();
  factory _Asset({@required String uri, int width, int height}) = _$_Asset;

  factory _Asset.fromJson(Map<String, dynamic> json) = _$_Asset.fromJson;

  @override
  String get uri;
  @override
  int get width;
  @override
  int get height;
  @override
  _$AssetCopyWith<_Asset> get copyWith;
}
