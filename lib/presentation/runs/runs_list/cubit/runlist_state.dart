part of 'runlist_cubit.dart';

@freezed
abstract class RunlistState with _$RunlistState {
  const factory RunlistState({List<Run> runs}) = _RunlistState;

  factory RunlistState.initial() => RunlistState(runs: List.empty());
}
