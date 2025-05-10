import 'package:get_it/get_it.dart';

import '../../src/user/data/datasources/user_remote_data_source.dart';
import '../../src/user/data/repositories/user_repository_implementation.dart';
import '../../src/user/domain/repositories/user_repository.dart';
import '../../src/user/domain/usecases/create_user.dart';
import '../../src/user/domain/usecases/get_user.dart';
import '../../src/user/presentation/cubit/user_cubit.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> init() async {
  getIt
    ..registerFactory(() => UserCubit(
      createUser: getIt(),
     getUser: getIt(),
    ))

  // Use cases
    ..registerLazySingleton(() => CreateUser(getIt()))
    ..registerLazySingleton(() => GetUser(getIt()))

  // Repositories
    ..registerLazySingleton<UserRepository>(
            () => UserRepositoryImplementation(getIt()))

  // Data Sources
    ..registerLazySingleton<UserRemoteDataSource>(
            () => UserRemoteDataSrcImpl(getIt()))

  // External Dependencies
    ..registerLazySingleton(http.Client.new);
}