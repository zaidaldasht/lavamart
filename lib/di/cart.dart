
import '../application/cart_bloc/cart_bloc.dart';
import '../data/data_sources/local/cart_local_data_source.dart';
import '../data/data_sources/remot/cart_remote_data_source.dart';
import '../data/repositories/cart_repository_impl.dart';
import '../domain/reposetories/cart_reposetory.dart';
import '../domain/usecases/carts/add_cart_item_usecase.dart';
import '../domain/usecases/carts/clear_cart_usecase.dart';
import '../domain/usecases/carts/get_cached_cart_usecase.dart';
import '../domain/usecases/carts/sync_cart_usecas.dart';
import 'di.dart';

void registerCartFeature() {
  // Cart BLoC and Use Cases
  sl.registerFactory(
        () => CartBloc(sl(), sl(), sl(), sl()),
  );
  // Use cases
  sl.registerLazySingleton(() => GetCachedCartUseCase(sl()));
  sl.registerLazySingleton(() => AddCartUseCase(sl()));
  sl.registerLazySingleton(() => SyncCartUseCase(sl()));
  sl.registerLazySingleton(() => ClearCartUseCase(sl()));
  // Repository
  sl.registerLazySingleton<CartRepository>(
        () => CartRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
      userLocalDataSource: sl(),
    ),
  );
  // Data sources
  sl.registerLazySingleton<CartRemoteDataSource>(
        () => CartRemoteDataSourceSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<CartLocalDataSource>(
        () => CartLocalDataSourceImpl(sharedPreferences: sl()),
  );

}