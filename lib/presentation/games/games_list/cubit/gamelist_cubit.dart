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
  GamelistCubit(this._gamesRepository) : super(GamelistState.initial());

  Future refreshGames() async {
    _offset = 0;
    final gamesStorage =
        await _gamesRepository.getGames(offset: _offset, fromStorage: true);
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
    _offset = state.games.length;
    final games = await _gamesRepository.getGames(offset: _offset);
    games.fold((l) {
      emit(state.copyWith());
    }, (r) {
      emit(state.copyWith(games: [...state.games, ...r]));
    });
    return true;
  }
}
