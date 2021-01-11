import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:speed_run/data/models/run.dart';
import 'package:speed_run/data/repositories/runs_repository.dart';

part 'run_details_state.dart';
part 'run_details_cubit.freezed.dart';

@LazySingleton()
class RunDetailsCubit extends Cubit<RunDetailsState> {
  final IRunsRepository _runsRepository;

  RunDetailsCubit(this._runsRepository) : super(RunDetailsState.initial());

  loadRun(Run run) async {
    emit(state.copyWith(run: run));
  }
}
