


import '../application/product_bloc/product_bloc.dart';
import '../data/data_sources/local/product_local_data_source.dart';
import '../data/data_sources/remot/product_remote_data_source.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/reposetories/product_reposetory.dart';
import '../domain/usecases/products/get_product_usecase.dart';
import 'di.dart';

void registerProductFeature() {
  // Product BLoC and Use Cases
  sl.registerFactory(() => ProductBloc(sl()));
  sl.registerLazySingleton(() => GetProductUseCase(sl()));

  // Product Repository and Data Sources
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      networkInfo: sl(),
    ),
  );
  sl.registerLazySingleton<ProductRemoteDataSource>(
        () => ProductRemoteDataSourceImpl(client: sl()),
  );
  sl.registerLazySingleton<ProductLocalDataSource>(
        () => ProductLocalDataSourceImpl(sharedPreferences: sl()),
  );
}