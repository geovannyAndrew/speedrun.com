// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'game.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

/// @nodoc
class _$GameTearOff {
  const _$GameTearOff();

// ignore: unused_element
  _Game call(
      {String id,
      Names names,
      String abbreviation,
      String released,
      Asset coverMedium,
      Asset coverLarge,
      Asset background,
      List<Platform> platforms}) {
    return _Game(
      id: id,
      names: names,
      abbreviation: abbreviation,
      released: released,
      coverMedium: coverMedium,
      coverLarge: coverLarge,
      background: background,
      platforms: platforms,
    );
  }
}

/// @nodoc
// ignore: unused_element
const $Game = _$GameTearOff();

/// @nodoc
mixin _$Game {
  String get id;
  Names get names;
  String get abbreviation;
  String get released;
  Asset get coverMedium;
  Asset get coverLarge;
  Asset get background;
  List<Platform> get platforms;

  $GameCopyWith<Game> get copyWith;
}

/// @nodoc
abstract class $GameCopyWith<$Res> {
  factory $GameCopyWith(Game value, $Res Function(Game) then) =
      _$GameCopyWithImpl<$Res>;
  $Res call(
      {String id,
      Names names,
      String abbreviation,
      String released,
      Asset coverMedium,
      Asset coverLarge,
      Asset background,
      List<Platform> platforms});

  $NamesCopyWith<$Res> get names;
  $AssetCopyWith<$Res> get coverMedium;
  $AssetCopyWith<$Res> get coverLarge;
  $AssetCopyWith<$Res> get background;
}

/// @nodoc
class _$GameCopyWithImpl<$Res> implements $GameCopyWith<$Res> {
  _$GameCopyWithImpl(this._value, this._then);

  final Game _value;
  // ignore: unused_field
  final $Res Function(Game) _then;

  @override
  $Res call({
    Object id = freezed,
    Object names = freezed,
    Object abbreviation = freezed,
    Object released = freezed,
    Object coverMedium = freezed,
    Object coverLarge = freezed,
    Object background = freezed,
    Object platforms = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      names: names == freezed ? _value.names : names as Names,
      abbreviation: abbreviation == freezed
          ? _value.abbreviation
          : abbreviation as String,
      released: released == freezed ? _value.released : released as String,
      coverMedium:
          coverMedium == freezed ? _value.coverMedium : coverMedium as Asset,
      coverLarge:
          coverLarge == freezed ? _value.coverLarge : coverLarge as Asset,
      background:
          background == freezed ? _value.background : background as Asset,
      platforms:
          platforms == freezed ? _value.platforms : platforms as List<Platform>,
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

  @override
  $AssetCopyWith<$Res> get coverMedium {
    if (_value.coverMedium == null) {
      return null;
    }
    return $AssetCopyWith<$Res>(_value.coverMedium, (value) {
      return _then(_value.copyWith(coverMedium: value));
    });
  }

  @override
  $AssetCopyWith<$Res> get coverLarge {
    if (_value.coverLarge == null) {
      return null;
    }
    return $AssetCopyWith<$Res>(_value.coverLarge, (value) {
      return _then(_value.copyWith(coverLarge: value));
    });
  }

  @override
  $AssetCopyWith<$Res> get background {
    if (_value.background == null) {
      return null;
    }
    return $AssetCopyWith<$Res>(_value.background, (value) {
      return _then(_value.copyWith(background: value));
    });
  }
}

/// @nodoc
abstract class _$GameCopyWith<$Res> implements $GameCopyWith<$Res> {
  factory _$GameCopyWith(_Game value, $Res Function(_Game) then) =
      __$GameCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      Names names,
      String abbreviation,
      String released,
      Asset coverMedium,
      Asset coverLarge,
      Asset background,
      List<Platform> platforms});

  @override
  $NamesCopyWith<$Res> get names;
  @override
  $AssetCopyWith<$Res> get coverMedium;
  @override
  $AssetCopyWith<$Res> get coverLarge;
  @override
  $AssetCopyWith<$Res> get background;
}

/// @nodoc
class __$GameCopyWithImpl<$Res> extends _$GameCopyWithImpl<$Res>
    implements _$GameCopyWith<$Res> {
  __$GameCopyWithImpl(_Game _value, $Res Function(_Game) _then)
      : super(_value, (v) => _then(v as _Game));

  @override
  _Game get _value => super._value as _Game;

  @override
  $Res call({
    Object id = freezed,
    Object names = freezed,
    Object abbreviation = freezed,
    Object released = freezed,
    Object coverMedium = freezed,
    Object coverLarge = freezed,
    Object background = freezed,
    Object platforms = freezed,
  }) {
    return _then(_Game(
      id: id == freezed ? _value.id : id as String,
      names: names == freezed ? _value.names : names as Names,
      abbreviation: abbreviation == freezed
          ? _value.abbreviation
          : abbreviation as String,
      released: released == freezed ? _value.released : released as String,
      coverMedium:
          coverMedium == freezed ? _value.coverMedium : coverMedium as Asset,
      coverLarge:
          coverLarge == freezed ? _value.coverLarge : coverLarge as Asset,
      background:
          background == freezed ? _value.background : background as Asset,
      platforms:
          platforms == freezed ? _value.platforms : platforms as List<Platform>,
    ));
  }
}

/// @nodoc
class _$_Game extends _Game {
  const _$_Game(
      {this.id,
      this.names,
      this.abbreviation,
      this.released,
      this.coverMedium,
      this.coverLarge,
      this.background,
      this.platforms})
      : super._();

  @override
  final String id;
  @override
  final Names names;
  @override
  final String abbreviation;
  @override
  final String released;
  @override
  final Asset coverMedium;
  @override
  final Asset coverLarge;
  @override
  final Asset background;
  @override
  final List<Platform> platforms;

  @override
  String toString() {
    return 'Game(id: $id, names: $names, abbreviation: $abbreviation, released: $released, coverMedium: $coverMedium, coverLarge: $coverLarge, background: $background, platforms: $platforms)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Game &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.names, names) ||
                const DeepCollectionEquality().equals(other.names, names)) &&
            (identical(other.abbreviation, abbreviation) ||
                const DeepCollectionEquality()
                    .equals(other.abbreviation, abbreviation)) &&
            (identical(other.released, released) ||
                const DeepCollectionEquality()
                    .equals(other.released, released)) &&
            (identical(other.coverMedium, coverMedium) ||
                const DeepCollectionEquality()
                    .equals(other.coverMedium, coverMedium)) &&
            (identical(other.coverLarge, coverLarge) ||
                const DeepCollectionEquality()
                    .equals(other.coverLarge, coverLarge)) &&
            (identical(other.background, background) ||
                const DeepCollectionEquality()
                    .equals(other.background, background)) &&
            (identical(other.platforms, platforms) ||
                const DeepCollectionEquality()
                    .equals(other.platforms, platforms)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(names) ^
      const DeepCollectionEquality().hash(abbreviation) ^
      const DeepCollectionEquality().hash(released) ^
      const DeepCollectionEquality().hash(coverMedium) ^
      const DeepCollectionEquality().hash(coverLarge) ^
      const DeepCollectionEquality().hash(background) ^
      const DeepCollectionEquality().hash(platforms);

  @override
  _$GameCopyWith<_Game> get copyWith =>
      __$GameCopyWithImpl<_Game>(this, _$identity);
}

abstract class _Game extends Game {
  const _Game._() : super._();
  const factory _Game(
      {String id,
      Names names,
      String abbreviation,
      String released,
      Asset coverMedium,
      Asset coverLarge,
      Asset background,
      List<Platform> platforms}) = _$_Game;

  @override
  String get id;
  @override
  Names get names;
  @override
  String get abbreviation;
  @override
  String get released;
  @override
  Asset get coverMedium;
  @override
  Asset get coverLarge;
  @override
  Asset get background;
  @override
  List<Platform> get platforms;
  @override
  _$GameCopyWith<_Game> get copyWith;
}
