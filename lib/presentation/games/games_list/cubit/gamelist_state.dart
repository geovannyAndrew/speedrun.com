part of 'gamelist_cubit.dart';

@freezed
abstract class GamelistState with _$GamelistState {
  const factory GamelistState.initial() = _Initial;
}
