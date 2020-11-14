part of 'gamelist_cubit.dart';

@freezed
abstract class GamelistState with _$GamelistState {
  const factory GamelistState({List<Game> games, String query}) =
      _GamelistState;
  factory GamelistState.initial() =>
      GamelistState(games: List.empty(), query: null);
}
