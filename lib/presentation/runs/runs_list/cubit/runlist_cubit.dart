import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/repositories/runs_repository.dart';

part 'runlist_state.dart';
part 'runlist_cubit.freezed.dart';

@injectable
class RunlistCubit extends Cubit<RunlistState> {
  final IRunsRepository _runsRepository;
  var _offset = 0;
  RunlistCubit(this._runsRepository) : super(RunlistState.initial());

  Future refreshRuns() async {
    _offset = 0;
    final runs = await _runsRepository.getRuns(offset: _offset);
    runs.fold((l) {
      emit(RunlistState.initial());
    }, (r) {
      emit(state.copyWith(runs: r));
    });
  }

  Future<bool> loadMoreRuns() async {
    _offset++;
    final runs = await _runsRepository.getRuns(offset: _offset);
    runs.fold((l) {
      emit(state.copyWith());
    }, (r) {
      emit(state.copyWith(runs: state.runs..addAll(r)));
    });
    return true;
  }

  bool get runListIsEmpty => state.runs.isEmpty;
}
