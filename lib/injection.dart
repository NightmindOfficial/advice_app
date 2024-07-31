import 'package:advice_app/application/advicer/advicer_bloc.dart';
import 'package:advice_app/domain/repositories/advicer_repository.dart';
import 'package:advice_app/domain/usecases/advicer_usecases.dart';
import 'package:advice_app/infrastructure/datasources/advicer_remote_datasource.dart';
import 'package:advice_app/infrastructure/datasources/theme_local_datasource.dart';
import 'package:advice_app/infrastructure/repositories/advicer_repository_impl.dart';
import 'package:get_it/get_it.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Bloc
  sl.registerFactory(() => AdvicerBloc(usecases: sl()));

  //! Usecases
  sl.registerLazySingleton(() => AdvicerUsecases(advicerRepository: sl()));

  //! Repository
  sl.registerLazySingleton<AdvicerRepository>(
      () => AdvicerRepositoryImpl(advicerRemoteDatasource: sl()));

  //! Datasources
  sl.registerLazySingleton<AdvicerRemoteDatasource>(
      () => AdvicerRemoteDatasourceImpl(client: sl()));

  sl.registerLazySingleton<ThemeLocalDatasource>(
      () => ThemeLocalDatasourceImpl(sp: sl()));

  //! Client
  sl.registerLazySingleton(() => http.Client());
  final SharedPreferences sp = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sp);
}
