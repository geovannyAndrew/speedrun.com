import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'gamelist_state.dart';
part 'gamelist_cubit.freezed.dart';

class GamelistCubit extends Cubit<GamelistState> {
  GamelistCubit() : super(GamelistState.initial());
}
