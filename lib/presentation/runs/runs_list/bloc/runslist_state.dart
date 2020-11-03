part of 'runslist_bloc.dart';

@freezed
abstract class RunslistState with _$RunslistState {
  const factory RunslistState.initial() = _Initial;
  const factory RunslistState.refreshing() = _Refreshing;
  const factory RunslistState.loadingMore() = _LoadingMore;
  const factory RunslistState.loadedRuns(
      Either<SpeedRunFailure, List<Run>> runs) = _LoadedRuns;
}
