import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:speed_run/data/models/game.dart';
import 'package:speed_run/data/repositories/games_repository.dart';

part 'gamelist_state.dart';
part 'gamelist_cubit.freezed.dart';

@LazySingleton()
class GamelistCubit extends Cubit<GamelistState> {
  final IGamesRepository _gamesRepository;
  var _offset = 0;
  var _allLoaded = false;
  var _loading = false;
  GamelistCubit(this._gamesRepository) : super(GamelistState.initial());

  bool get gameListIsEmpty => state.games.isEmpty;

  Future refreshGames() async {
    _offset = 0;
    print("Query: ${state.query}");
    final gamesRemote =
        await _gamesRepository.getGames(offset: _offset, query: state.query);
    gamesRemote.fold((l) {
      print("gamesRemote l");
    }, (r) {
      print("gamesRemote ${r.length}");
      emit(state.copyWith(games: r));
    });
  }

  Future refreshGamesFromStorage() async {
    setQuery(null);
    final gamesStorage = await _gamesRepository.getGames(
        offset: _offset, query: state.query, fromStorage: true);
    gamesStorage.fold((l) {
      print("gamesStorage l");
      emit(GamelistState.initial());
    }, (r) {
      print("gamesStorage r: ${r.length}");
      emit(state.copyWith(games: r));
    });
  }

  Future<bool> loadMoreGames() async {
    if (_loading || _allLoaded || state.games.isEmpty) return false;
    _loading = true;
    _offset = state.games.length;
    final games =
        await _gamesRepository.getGames(offset: _offset, query: state.query);
    games.fold((l) {
      emit(state.copyWith());
      _loading = false;
    }, (r) {
      emit(state.copyWith(games: [...state.games, ...r]));
      _loading = false;
    });
    return true;
  }

  void setQuery(String query) {
    emit(state.copyWith(query: query));
  }
}
