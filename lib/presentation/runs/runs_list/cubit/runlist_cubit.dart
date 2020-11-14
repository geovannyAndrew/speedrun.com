import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/repositories/runs_repository.dart';

part 'runlist_state.dart';
part 'runlist_cubit.freezed.dart';

@LazySingleton()
class RunlistCubit extends Cubit<RunlistState> {
  final IRunsRepository _runsRepository;
  var _offset = 0;
  RunlistCubit(this._runsRepository) : super(RunlistState.initial());

  bool get runListIsEmpty => state.runs.isEmpty;

  Future refreshRuns() async {
    _offset = 0;
    final runsStorage =
        await _runsRepository.getRuns(offset: _offset, fromStorage: true);
    runsStorage.fold((l) {
      emit(RunlistState.initial());
    }, (r) {
      emit(state.copyWith(runs: r));
    });
    final runsRemote = await _runsRepository.getRuns(offset: _offset);
    runsRemote.fold((l) {}, (r) {
      emit(state.copyWith(runs: r));
    });
  }

  Future<bool> loadMoreRuns() async {
    _offset = state.runs.length;
    final runs = await _runsRepository.getRuns(offset: _offset);
    runs.fold((l) {
      emit(state.copyWith());
    }, (r) {
      emit(state.copyWith(runs: [...state.runs, ...r]));
    });
    return true;
  }
}
