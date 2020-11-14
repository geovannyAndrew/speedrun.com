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

  Future refreshGames({String querySearch = null}) async {
    state.copyWith(query: querySearch);
    _offset = 0;
    final gamesStorage = await _gamesRepository.getGames(
        offset: _offset, query: state.query, fromStorage: true);
    gamesStorage.fold((l) {
      emit(GamelistState.initial());
    }, (r) {
      emit(state.copyWith(games: r));
    });
    final gamesRemote = await _gamesRepository.getGames(offset: _offset);
    gamesRemote.fold((l) {
      print("gamesRemote l");
    }, (r) {
      print("gamesRemote ${r.length}");
      emit(state.copyWith(games: r));
    });
  }

  Future<bool> loadMoreGames() async {
    print("loadMoreGames ....");
    if (!_loading && !_allLoaded && state.games.length > 10) return false;
    _loading = true;
    _offset = state.games.length;
    final games =
        await _gamesRepository.getGames(offset: _offset, query: state.query);
    games.fold((l) {
      print("loadMoreGames l");
      emit(state.copyWith());
      _loading = false;
    }, (r) {
      print("loadMoreGames r");
      emit(state.copyWith(games: [...state.games, ...r]));
      _loading = false;
    });
    return true;
  }
}
