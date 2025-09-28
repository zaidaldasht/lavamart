

import '../application/user_bloc/user_bloc.dart';
import '../data/data_sources/local/user_local_data_source.dart';
import '../data/data_sources/remot/user_remote_data_source.dart';
import '../data/repositories/user_repository_impl.dart';
import '../domain/reposetories/user_reposetory.dart';
import '../domain/usecases/users/get_cached_user_usecase.dart';
import '../domain/usecases/users/sign_in_usecase.dart';
import '../domain/usecases/users/sign_out_usecase.dart';
import '../domain/usecases/users/sign_up_usecase.dart';
import 'di.dart';

void registerUserFeature() {
  // User BLoC and Use Cases
  sl.registerFactory(() => UserBloc(sl(), sl(), sl(), sl()));
  sl.registerLazySingleton(() => GetCachedUserUseCase(sl()));
  sl.registerLazySingleton(() => SignInUseCase(sl()));
  sl.registerLazySingleton(() => SignUpUseCase(sl()));
  sl.registerLazySingleton(() => SignOutUseCase(sl()));

  // User Repository and Data Sources
  sl.registerLazySingleton<UserRepository>(
        () => UserRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSourceImpl(sharedPreferences: sl(), secureStorage: sl()),
  );
  sl.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImpl(client: sl()),
  );
}