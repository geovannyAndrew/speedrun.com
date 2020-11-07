// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'data/services/apis/games_api.dart';
import 'data/repositories/games_repository.dart';
import 'data/services/apis/runs_api.dart';
import 'data/repositories/runs_repository.dart';
import 'data/services/apis/users_api.dart';
import 'data/repositories/users_repository.dart';
import 'presentation/runs/runs_list/cubit/runlist_cubit.dart';
import 'data/services/services_module.dart';

/// adds generated dependencies
/// to the provided [GetIt] instance

GetIt $initGetIt(
  GetIt get, {
  String environment,
  EnvironmentFilter environmentFilter,
}) {
  final gh = GetItHelper(get, environment, environmentFilter);
  final servicesModule = _$ServicesModule();
  gh.lazySingleton<Dio>(() => servicesModule.dio());
  gh.lazySingleton<IGamesApi>(() => GamesApiImpl(get<Dio>()));
  gh.factory<IGamesRepository>(() => GamesRepositoryImpl(get<IGamesApi>()));
  gh.lazySingleton<IRunsApi>(() => RunApiImpl(get<Dio>()));
  gh.factory<IRunsRepository>(() => RunsRepositoryImpl(get<IRunsApi>()));
  gh.lazySingleton<IUsersApi>(() => UsersApiImpl(get<Dio>()));
  gh.factory<IUsersRepository>(() => UsersRepositoryImpl(get<IUsersApi>()));
  gh.factory<RunlistCubit>(() => RunlistCubit(get<IRunsRepository>()));
  return get;
}

class _$ServicesModule extends ServicesModule {}
