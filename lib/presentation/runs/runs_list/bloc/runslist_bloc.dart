import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/repositories/runs_repository.dart';
import 'package:speed_run/data/services/speed_run_failure.dart';

part 'runslist_event.dart';
part 'runslist_state.dart';
part 'runslist_bloc.freezed.dart';

@injectable
class RunslistBloc extends Bloc<RunslistEvent, RunslistState> {
  final IRunsRepository _runsRepository;
  var _offset = 0;

  RunslistBloc(this._runsRepository) : super(const _Initial());

  @override
  Stream<RunslistState> mapEventToState(
    RunslistEvent event,
  ) async* {
    print("mapEventToState");
    yield* event.map(started: (e) async* {
      print("mapEventToState1");
      final runs = await _runsRepository.getRuns(offset: _offset);
      yield runs.fold((l) {
        return RunslistState.refreshing();
      }, (r) {
        return RunslistState.loadedRuns(r);
      });
    });
  }

  Future refreshRuns() async {
    final runs = await _runsRepository.getRuns(offset: 0);
    runs.fold((l) {
      emit(const RunslistState.refreshing());
    }, (r) {
      emit(RunslistState.loadedRuns(r));
    });
  }
}
