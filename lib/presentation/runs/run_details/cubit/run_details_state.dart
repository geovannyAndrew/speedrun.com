part of 'run_details_cubit.dart';

@freezed
abstract class RunDetailsState with _$RunDetailsState {
  const factory RunDetailsState({Run run}) = _RunDetailsState;

  factory RunDetailsState.initial() => RunDetailsState(run: null);
}
