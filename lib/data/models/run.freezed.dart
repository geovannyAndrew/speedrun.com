// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'run.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Run _$RunFromJson(Map<String, dynamic> json) {
  return _Run.fromJson(json);
}

/// @nodoc
class _$RunTearOff {
  const _$RunTearOff();

// ignore: unused_element
  _Run call(
      {String id,
      String date,
      String comment,
      String submitted,
      Times times,
      @JsonKey(name: "category", fromJson: Run._getCategoryFromJsonData)
          Category category,
      @JsonKey(name: "game", fromJson: Run._getGameFromJsonData)
          Game game,
      @JsonKey(name: "players", fromJson: Run._getPlayersFromJsonData)
          List<User> players,
      @JsonKey(name: "videos", fromJson: Run._getAssetsFromJsonData)
          List<Asset> videos}) {
    return _Run(
      id: id,
      date: date,
      comment: comment,
      submitted: submitted,
      times: times,
      category: category,
      game: game,
      players: players,
      videos: videos,
    );
  }

// ignore: unused_element
  Run fromJson(Map<String, Object> json) {
    return Run.fromJson(json);
  }
}

/// @nodoc
// ignore: unused_element
const $Run = _$RunTearOff();

/// @nodoc
mixin _$Run {
  String get id;
  String get date;
  String get comment;
  String get submitted;
  Times get times;
  @JsonKey(name: "category", fromJson: Run._getCategoryFromJsonData)
  Category get category;
  @JsonKey(name: "game", fromJson: Run._getGameFromJsonData)
  Game get game;
  @JsonKey(name: "players", fromJson: Run._getPlayersFromJsonData)
  List<User> get players;
  @JsonKey(name: "videos", fromJson: Run._getAssetsFromJsonData)
  List<Asset> get videos;

  Map<String, dynamic> toJson();
  $RunCopyWith<Run> get copyWith;
}

/// @nodoc
abstract class $RunCopyWith<$Res> {
  factory $RunCopyWith(Run value, $Res Function(Run) then) =
      _$RunCopyWithImpl<$Res>;
  $Res call(
      {String id,
      String date,
      String comment,
      String submitted,
      Times times,
      @JsonKey(name: "category", fromJson: Run._getCategoryFromJsonData)
          Category category,
      @JsonKey(name: "game", fromJson: Run._getGameFromJsonData)
          Game game,
      @JsonKey(name: "players", fromJson: Run._getPlayersFromJsonData)
          List<User> players,
      @JsonKey(name: "videos", fromJson: Run._getAssetsFromJsonData)
          List<Asset> videos});

  $TimesCopyWith<$Res> get times;
  $CategoryCopyWith<$Res> get category;
  $GameCopyWith<$Res> get game;
}

/// @nodoc
class _$RunCopyWithImpl<$Res> implements $RunCopyWith<$Res> {
  _$RunCopyWithImpl(this._value, this._then);

  final Run _value;
  // ignore: unused_field
  final $Res Function(Run) _then;

  @override
  $Res call({
    Object id = freezed,
    Object date = freezed,
    Object comment = freezed,
    Object submitted = freezed,
    Object times = freezed,
    Object category = freezed,
    Object game = freezed,
    Object players = freezed,
    Object videos = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed ? _value.id : id as String,
      date: date == freezed ? _value.date : date as String,
      comment: comment == freezed ? _value.comment : comment as String,
      submitted: submitted == freezed ? _value.submitted : submitted as String,
      times: times == freezed ? _value.times : times as Times,
      category: category == freezed ? _value.category : category as Category,
      game: game == freezed ? _value.game : game as Game,
      players: players == freezed ? _value.players : players as List<User>,
      videos: videos == freezed ? _value.videos : videos as List<Asset>,
    ));
  }

  @override
  $TimesCopyWith<$Res> get times {
    if (_value.times == null) {
      return null;
    }
    return $TimesCopyWith<$Res>(_value.times, (value) {
      return _then(_value.copyWith(times: value));
    });
  }

  @override
  $CategoryCopyWith<$Res> get category {
    if (_value.category == null) {
      return null;
    }
    return $CategoryCopyWith<$Res>(_value.category, (value) {
      return _then(_value.copyWith(category: value));
    });
  }

  @override
  $GameCopyWith<$Res> get game {
    if (_value.game == null) {
      return null;
    }
    return $GameCopyWith<$Res>(_value.game, (value) {
      return _then(_value.copyWith(game: value));
    });
  }
}

/// @nodoc
abstract class _$RunCopyWith<$Res> implements $RunCopyWith<$Res> {
  factory _$RunCopyWith(_Run value, $Res Function(_Run) then) =
      __$RunCopyWithImpl<$Res>;
  @override
  $Res call(
      {String id,
      String date,
      String comment,
      String submitted,
      Times times,
      @JsonKey(name: "category", fromJson: Run._getCategoryFromJsonData)
          Category category,
      @JsonKey(name: "game", fromJson: Run._getGameFromJsonData)
          Game game,
      @JsonKey(name: "players", fromJson: Run._getPlayersFromJsonData)
          List<User> players,
      @JsonKey(name: "videos", fromJson: Run._getAssetsFromJsonData)
          List<Asset> videos});

  @override
  $TimesCopyWith<$Res> get times;
  @override
  $CategoryCopyWith<$Res> get category;
  @override
  $GameCopyWith<$Res> get game;
}

/// @nodoc
class __$RunCopyWithImpl<$Res> extends _$RunCopyWithImpl<$Res>
    implements _$RunCopyWith<$Res> {
  __$RunCopyWithImpl(_Run _value, $Res Function(_Run) _then)
      : super(_value, (v) => _then(v as _Run));

  @override
  _Run get _value => super._value as _Run;

  @override
  $Res call({
    Object id = freezed,
    Object date = freezed,
    Object comment = freezed,
    Object submitted = freezed,
    Object times = freezed,
    Object category = freezed,
    Object game = freezed,
    Object players = freezed,
    Object videos = freezed,
  }) {
    return _then(_Run(
      id: id == freezed ? _value.id : id as String,
      date: date == freezed ? _value.date : date as String,
      comment: comment == freezed ? _value.comment : comment as String,
      submitted: submitted == freezed ? _value.submitted : submitted as String,
      times: times == freezed ? _value.times : times as Times,
      category: category == freezed ? _value.category : category as Category,
      game: game == freezed ? _value.game : game as Game,
      players: players == freezed ? _value.players : players as List<User>,
      videos: videos == freezed ? _value.videos : videos as List<Asset>,
    ));
  }
}

@JsonSerializable(createToJson: true)

/// @nodoc
class _$_Run extends _Run {
  const _$_Run(
      {this.id,
      this.date,
      this.comment,
      this.submitted,
      this.times,
      @JsonKey(name: "category", fromJson: Run._getCategoryFromJsonData)
          this.category,
      @JsonKey(name: "game", fromJson: Run._getGameFromJsonData)
          this.game,
      @JsonKey(name: "players", fromJson: Run._getPlayersFromJsonData)
          this.players,
      @JsonKey(name: "videos", fromJson: Run._getAssetsFromJsonData)
          this.videos})
      : super._();

  factory _$_Run.fromJson(Map<String, dynamic> json) => _$_$_RunFromJson(json);

  @override
  final String id;
  @override
  final String date;
  @override
  final String comment;
  @override
  final String submitted;
  @override
  final Times times;
  @override
  @JsonKey(name: "category", fromJson: Run._getCategoryFromJsonData)
  final Category category;
  @override
  @JsonKey(name: "game", fromJson: Run._getGameFromJsonData)
  final Game game;
  @override
  @JsonKey(name: "players", fromJson: Run._getPlayersFromJsonData)
  final List<User> players;
  @override
  @JsonKey(name: "videos", fromJson: Run._getAssetsFromJsonData)
  final List<Asset> videos;

  @override
  String toString() {
    return 'Run(id: $id, date: $date, comment: $comment, submitted: $submitted, times: $times, category: $category, game: $game, players: $players, videos: $videos)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Run &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.date, date) ||
                const DeepCollectionEquality().equals(other.date, date)) &&
            (identical(other.comment, comment) ||
                const DeepCollectionEquality()
                    .equals(other.comment, comment)) &&
            (identical(other.submitted, submitted) ||
                const DeepCollectionEquality()
                    .equals(other.submitted, submitted)) &&
            (identical(other.times, times) ||
                const DeepCollectionEquality().equals(other.times, times)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.game, game) ||
                const DeepCollectionEquality().equals(other.game, game)) &&
            (identical(other.players, players) ||
                const DeepCollectionEquality()
                    .equals(other.players, players)) &&
            (identical(other.videos, videos) ||
                const DeepCollectionEquality().equals(other.videos, videos)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(date) ^
      const DeepCollectionEquality().hash(comment) ^
      const DeepCollectionEquality().hash(submitted) ^
      const DeepCollectionEquality().hash(times) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(game) ^
      const DeepCollectionEquality().hash(players) ^
      const DeepCollectionEquality().hash(videos);

  @override
  _$RunCopyWith<_Run> get copyWith =>
      __$RunCopyWithImpl<_Run>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_RunToJson(this);
  }
}

abstract class _Run extends Run {
  const _Run._() : super._();
  const factory _Run(
      {String id,
      String date,
      String comment,
      String submitted,
      Times times,
      @JsonKey(name: "category", fromJson: Run._getCategoryFromJsonData)
          Category category,
      @JsonKey(name: "game", fromJson: Run._getGameFromJsonData)
          Game game,
      @JsonKey(name: "players", fromJson: Run._getPlayersFromJsonData)
          List<User> players,
      @JsonKey(name: "videos", fromJson: Run._getAssetsFromJsonData)
          List<Asset> videos}) = _$_Run;

  factory _Run.fromJson(Map<String, dynamic> json) = _$_Run.fromJson;

  @override
  String get id;
  @override
  String get date;
  @override
  String get comment;
  @override
  String get submitted;
  @override
  Times get times;
  @override
  @JsonKey(name: "category", fromJson: Run._getCategoryFromJsonData)
  Category get category;
  @override
  @JsonKey(name: "game", fromJson: Run._getGameFromJsonData)
  Game get game;
  @override
  @JsonKey(name: "players", fromJson: Run._getPlayersFromJsonData)
  List<User> get players;
  @override
  @JsonKey(name: "videos", fromJson: Run._getAssetsFromJsonData)
  List<Asset> get videos;
  @override
  _$RunCopyWith<_Run> get copyWith;
}
