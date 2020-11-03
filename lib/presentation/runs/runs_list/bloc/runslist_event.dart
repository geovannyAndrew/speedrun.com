part of 'runslist_bloc.dart';

@freezed
abstract class RunslistEvent with _$RunslistEvent {
  const factory RunslistEvent.started() = _Started;
}